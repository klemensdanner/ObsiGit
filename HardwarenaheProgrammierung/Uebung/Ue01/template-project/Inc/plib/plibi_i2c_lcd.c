/*
    This file contains the code for configuring and interacting with a LCD display (16 characters, 2 lines) over I2C.
    The supported hardware is:
    - LCD display: HD44780 compatible display (https://www.mikrocontroller.net/articles/HD44780)
    - Port Expander: PCF8574T (https://www.mikrocontroller.net/articles/Port-Expander_PCF8574)
    - I2C Port 1 with pins (from Arduino connectors on the STM32 board):
      - D15 for SCL
      - D14 for SDA
      - GND
      - 5V
    Product datasheet: https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/5773/CN0295D%20other%20related%20document.pdf
*/

#include <stdint.h>
#include <string.h>
#include "plibi_i2c_lcd.h"

// forward declarations for static functions
static void lcd_detect_i2c_address(void);

/*                                          I2C functions and definitions                                         */

static uint8_t g_lcd_i2c_addr7 = LCD_I2C_ADDR_7BIT;

static volatile i2c1_error_t g_i2c1_last_error = I2C1_ERR_NONE;

uint8_t circle_char[8] = {
    0x00, // 00000
    0x0E, // 01110
    0x11, // 10001
    0x11, // 10001
    0x11, // 10001
    0x11, // 10001
    0x0E, // 01110
    0x00, // 00000
};

uint8_t circle_plus_char[8] = {
    0x00, // 00000
    0x0E, // 01110
    0x1F, // 11111
    0x1F, // 11111
    0x1F, // 11111
    0x1F, // 11111
    0x0E, // 01110
    0x00, // 00000
};

// cursor offset for positioning the virtual LEDs on the LCD
const uint8_t cursor_offset = 4;

void init_I2C()
{
    // GPIO clock for I2C.
    SET_BIT(RCC->AHB2ENR, RCC_AHB2ENR_GPIOBEN);
    (void)READ_BIT(RCC->AHB2ENR, RCC_AHB2ENR_GPIOBEN);

    // enable HSI and wait until ready.
    // default configured clock source is to slow, so we switch on HSI for I2C.
    SET_BIT(RCC->CR, RCC_CR_HSION);
    while ((RCC->CR & RCC_CR_HSIRDY) == 0U)
    {
    }

    // enable HSI kernel clock for peripheral devices
    SET_BIT(RCC->CR, RCC_CR_HSIKERON);

    // Select HSI as the I2C1 kernel clock source
    MODIFY_REG(RCC->CCIPR4,
               RCC_CCIPR4_I2C1SEL,
               RCC_CCIPR4_I2C1SEL_1);

    // I2C1 peripheral clock.
    SET_BIT(RCC->APB1LENR, RCC_APB1LENR_I2C1EN);
    (void)READ_BIT(RCC->APB1LENR, RCC_APB1LENR_I2C1EN);

    // Reset I2C1 to clear any stale bus/peripheral state.
    SET_BIT(RCC->APB1LRSTR, RCC_APB1LRSTR_I2C1RST);
    CLEAR_BIT(RCC->APB1LRSTR, RCC_APB1LRSTR_I2C1RST);

    // PB6 (D15)/PB7(D14) -> AF4 I2C1 SCL/SDA, open-drain with pull-up.
    MODIFY_REG(GPIOB->MODER,
               GPIO_MODER_MODE6_Msk | GPIO_MODER_MODE7_Msk,
               (GPIO_MODE_AF_PP << GPIO_MODER_MODE6_Pos) |
                   (GPIO_MODE_AF_PP << GPIO_MODER_MODE7_Pos));

    // set PB6/PB7 to open-drain output type
    // I2C devices only actively pull the lines low; pull-up resistors bring them high
    SET_BIT(GPIOB->OTYPER, GPIO_OTYPER_OT6 | GPIO_OTYPER_OT7);

    // Enable pull-up resistors on PB6/PB7
    MODIFY_REG(GPIOB->PUPDR,
               GPIO_PUPDR_PUPD6_Msk | GPIO_PUPDR_PUPD7_Msk,
               (GPIO_PULLUP << GPIO_PUPDR_PUPD6_Pos) |
                   (GPIO_PULLUP << GPIO_PUPDR_PUPD7_Pos));

    // Set PB6/PB7 to high speed (50 MHz) for I2C. 0x3U is the maximum speed setting for the OSPEEDR register
    MODIFY_REG(GPIOB->OSPEEDR,
               GPIO_OSPEEDR_OSPEED6_Msk | GPIO_OSPEEDR_OSPEED7_Msk,
               (0x3U << GPIO_OSPEEDR_OSPEED6_Pos) |
                   (0x3U << GPIO_OSPEEDR_OSPEED7_Pos));

    // Set PB6/PB7 to AF4 (0x4U = I2C1) in the AFR register.
    // PB6, AF4 -> I2C1_SCL, PB7, AF4 -> I2C1_SDA
    MODIFY_REG(GPIOB->AFR[0],
               GPIO_AFRL_AFSEL6_Msk | GPIO_AFRL_AFSEL7_Msk,
               (0x4U << GPIO_AFRL_AFSEL6_Pos) |
                   (0x4U << GPIO_AFRL_AFSEL7_Pos));

    // Disable I2C before timing configuration.
    CLEAR_BIT(LCD_I2C_PORT->CR1, I2C_CR1_PE);
    // Configure I2C timing
    WRITE_REG(LCD_I2C_PORT->TIMINGR, LCD_I2C_TIMINGR);
    SET_BIT(LCD_I2C_PORT->CR1, I2C_CR1_PE);

    // check for correct LCD backpack address (0x27 or 0x3F) and set g_lcd_i2c_addr7 accordingly
    lcd_detect_i2c_address();
}

void delay_microseconds(unsigned int us)
{
    if (us == 0U)
    {
        return;
    }

    uint32_t cycles_per_us = SystemCoreClock / 1000000U;
    if (cycles_per_us < 4U)
    {
        cycles_per_us = 4U;
    }

    volatile uint32_t loops = us * (cycles_per_us / 4U);
    while (loops--)
    {
        __NOP();
    }
}

static bool i2c_wait_flag_set(uint32_t flag, uint32_t timeout)
{
    while (timeout--)
    {
        if ((LCD_I2C_PORT->ISR & flag) != 0U)
        {
            return true;
        }
    }
    return false;
}

static bool i2c_wait_bus_free(uint32_t timeout)
{
    while (timeout--)
    {
        if ((LCD_I2C_PORT->ISR & I2C_ISR_BUSY) == 0U)
        {
            return true;
        }
    }
    return false;
}

bool i2c1_write_byte(uint8_t addr7, uint8_t data)
{
    g_i2c1_last_error = I2C1_ERR_NONE;
    const uint32_t timeout = 500000U;

    if (!i2c_wait_bus_free(timeout))
    {
        g_i2c1_last_error = I2C1_ERR_BUS_BUSY_TIMEOUT;
        return false;
    }

    // clear all error flags and STOP flag before starting a new transfer
    LCD_I2C_PORT->ICR = I2C_ICR_STOPCF | I2C_ICR_NACKCF | I2C_ICR_BERRCF | I2C_ICR_ARLOCF;

    // Configure transfer: 1 byte, auto-end, write, 7-bit address. clear other bits before.
    MODIFY_REG(LCD_I2C_PORT->CR2,
               I2C_CR2_SADD | I2C_CR2_RD_WRN | I2C_CR2_NBYTES | I2C_CR2_RELOAD | I2C_CR2_AUTOEND |
                   I2C_CR2_START | I2C_CR2_STOP,
               (((uint32_t)addr7 << 1U) & I2C_CR2_SADD) |
                   (1U << I2C_CR2_NBYTES_Pos) |
                   I2C_CR2_AUTOEND);

    // Start the transfer by setting the START bit in CR2
    SET_BIT(LCD_I2C_PORT->CR2, I2C_CR2_START);

    uint32_t timeout_cnt = timeout;
    uint32_t isr;
    // Wait until TX register is ready, or abort on any terminal/error condition
    do
    {
        isr = LCD_I2C_PORT->ISR;
        if ((isr & (I2C_ISR_TXIS | I2C_ISR_NACKF | I2C_ISR_BERR | I2C_ISR_ARLO | I2C_ISR_STOPF)) != 0U)
        {
            break;
        }
    } while (timeout_cnt-- != 0U);

    if (timeout_cnt == 0U)
    {
        g_i2c1_last_error = I2C1_ERR_TIMEOUT_WAIT_TXIS;
        return false;
    }

    // check for errors and clear flags (write-one-to-clear bits!)
    if ((isr & I2C_ISR_BERR) != 0U)
    {
        g_i2c1_last_error = I2C1_ERR_BERR;
        LCD_I2C_PORT->ICR = I2C_ICR_BERRCF | I2C_ICR_STOPCF;
        return false;
    }

    if ((isr & I2C_ISR_ARLO) != 0U)
    {
        g_i2c1_last_error = I2C1_ERR_ARLO;
        LCD_I2C_PORT->ICR = I2C_ICR_ARLOCF | I2C_ICR_STOPCF;
        return false;
    }

    if ((isr & I2C_ISR_STOPF) != 0U)
    {
        g_i2c1_last_error = I2C1_ERR_STOP_BEFORE_TX;
        LCD_I2C_PORT->ICR = I2C_ICR_STOPCF;
        return false;
    }

    if ((isr & I2C_ISR_NACKF) != 0U)
    {
        g_i2c1_last_error = I2C1_ERR_NACK;
        LCD_I2C_PORT->ICR = I2C_ICR_NACKCF | I2C_ICR_STOPCF;
        return false;
    }

    // write data to transfer register; triggers transfer
    LCD_I2C_PORT->TXDR = data;

    if (!i2c_wait_flag_set(I2C_ISR_STOPF, timeout))
    {
        g_i2c1_last_error = I2C1_ERR_TIMEOUT_WAIT_STOP;
        return false;
    }

    // stop is written automatically by hardware when AUTOEND is set, so just clear the STOP flag
    LCD_I2C_PORT->ICR = I2C_ICR_STOPCF;
    return true;
}

/*                                           Backpack functions and definitions                                */

static void lcd_detect_i2c_address(void)
{
    if (i2c1_write_byte(LCD_I2C_ADDR_7BIT, LCD_PCF_BL))
    {
        g_lcd_i2c_addr7 = LCD_I2C_ADDR_7BIT;
        return;
    }

    if (i2c1_write_byte(LCD_I2C_ADDR_ALT_7BIT, LCD_PCF_BL))
    {
        g_lcd_i2c_addr7 = LCD_I2C_ADDR_ALT_7BIT;
        return;
    }

    // Keep default when neither address responds.
    g_lcd_i2c_addr7 = LCD_I2C_ADDR_7BIT;
}

void lcd_expander_write(uint8_t value)
{
    bool result = i2c1_write_byte(g_lcd_i2c_addr7, value);
    if (result == false)
    {
        // Set breakpoint here when debugging to catch I2C errors.
        // The error code is stored in g_i2c1_last_error.
        delay_microseconds(50);
    }
}

/*                                           LCD functions and definitions                                       */

static void lcd_pulse_enable(uint8_t value)
{
    lcd_expander_write(value | LCD_PCF_EN);
    delay_microseconds(2);
    lcd_expander_write(value & (uint8_t)~LCD_PCF_EN);
    delay_microseconds(20);
}

static uint8_t lcd_pack_nibble(uint8_t nibble, uint8_t rs)
{
    uint8_t out = LCD_PCF_BL;

    if (rs != 0U)
    {
        out |= LCD_PCF_RS;
    }
    if ((nibble & 0x01U) != 0U)
    {
        out |= LCD_PCF_D4;
    }
    if ((nibble & 0x02U) != 0U)
    {
        out |= LCD_PCF_D5;
    }
    if ((nibble & 0x04U) != 0U)
    {
        out |= LCD_PCF_D6;
    }
    if ((nibble & 0x08U) != 0U)
    {
        out |= LCD_PCF_D7;
    }

    return out;
}

static void lcd_send_nibble(uint8_t nibble)
{
    uint8_t packed = lcd_pack_nibble(nibble, 0U);
    lcd_pulse_enable(packed);
}

static void lcd_send_byte(uint8_t rs, uint8_t data)
{
    uint8_t high = lcd_pack_nibble((uint8_t)(data >> 4), rs);
    uint8_t low = lcd_pack_nibble((uint8_t)(data & 0x0FU), rs);
    lcd_pulse_enable(high);
    lcd_pulse_enable(low);
}

// Minimal HD44780 4-bit initialization and display one character
void pl_lcd_init(void)
{
    init_I2C();

    delay_microseconds(50000); // Wait for LCD to power up
    lcd_expander_write(LCD_PCF_BL);
    lcd_send_nibble(0x3);
    delay_microseconds(4500);
    lcd_send_nibble(0x3);
    delay_microseconds(4500);
    lcd_send_nibble(0x3);
    delay_microseconds(150);
    // Set to 4-bit mode
    lcd_send_nibble(0x2);

    lcd_send_byte(0,
                  LCD_FUNCTIONSET |
                      LCD_4BITMODE |
                      LCD_2LINE |
                      LCD_5x8DOTS);

    lcd_send_byte(0,
                  LCD_DISPLAYCONTROL |
                      LCD_DISPLAYON |
                      LCD_CURSOROFF |
                      LCD_BLINKOFF);

    lcd_send_byte(0,
                  LCD_ENTRYMODESET |
                      LCD_ENTRYLEFT |
                      LCD_ENTRYSHIFTDECREMENT);
    lcd_send_byte(0, LCD_CLEARDISPLAY); // Clear display
    delay_microseconds(2000);
}

void autoscroll()
{
    lcd_send_byte(0, (LCD_ENTRYMODESET | LCD_ENTRYLEFT | LCD_ENTRYSHIFTINCREMENT));
    delay_microseconds(2000);
}

void no_autoscroll()
{
    lcd_send_byte(0, (LCD_ENTRYMODESET | LCD_ENTRYLEFT | LCD_ENTRYSHIFTDECREMENT));
    delay_microseconds(2000);
}

void pl_lcd_display_char(char c)
{
    lcd_send_byte(1, c); // Send data (RS=1)
}

void lcd_command(uint8_t cmd)
{
    lcd_send_byte(0, cmd);

    // HD44780 needs longer delay for clear/home
    if (cmd == LCD_RETURNHOME || cmd == LCD_CLEARDISPLAY)
    {
        delay_microseconds(2000);
    }
    else
    {
        delay_microseconds(40);
    }
}

void pl_lcd_display_str(const char *s)
{
    while (*s)
    {
        pl_lcd_display_char(*s++);
    }
}

void pl_lcd_display_u16(uint16_t v)
{
    char buf[6]; // 0..65535
    int i = 0;

    if (v == 0)
    {
        pl_lcd_display_char('0');
        return;
    }

    while (v > 0 && i < 5)
    {
        buf[i++] = (char)('0' + (v % 10));
        v /= 10;
    }

    while (i--)
    {
        pl_lcd_display_char(buf[i]);
    }
}

void pl_lcd_set_cursor(uint8_t col, uint8_t row)
{
    lcd_command(LCD_SETDDRAMADDR | (row == 0U ? col : 0x40U + col));
}

void pl_lcd_clear(void)
{
    lcd_command(LCD_CLEARDISPLAY); // clear display, set cursor position to zero
    delay_microseconds(2000);
}

void lcd_create_char(uint8_t location, const uint8_t charmap[8])
{
    location &= 0x07;                    // 0..7 only
    lcd_command(0x40 | (location << 3)); // CGRAM address
    for (int i = 0; i < 8; i++)
    {
        pl_lcd_display_char(charmap[i]);
        delay_microseconds(2000);
    }
}

void pl_lcd_led_init(void)
{
    lcd_create_char(0, circle_char);
    lcd_create_char(1, circle_plus_char);

    // Return to DDRAM and clear
    lcd_command(0x01);

    for (int i = 0; i < 8; i++)
    {
        pl_lcd_set_cursor(cursor_offset + i, 0);
        pl_lcd_display_char(0); // hollow circle
    }
}

// gets a uint_8 value and switches on the led on the corresponding position
void pl_lcd_led_set(uint8_t leds)
{
    static uint8_t previous_led_position = 0;
    const uint8_t nr_of_leds = 8;
    for (int i = 0; i < nr_of_leds; i++)
    {
        if ((leds & (1 << i)) == (previous_led_position & (1 << i)))
        {
            continue; // skip updating this LED if its state hasn't changed
        }

        pl_lcd_set_cursor(cursor_offset + (nr_of_leds - i - 1), 0);
        if (leds & (1 << i))
        {
            pl_lcd_display_char(1); // filled circle
        }
        else
        {
            pl_lcd_display_char(0); // hollow circle
        }
    }
    previous_led_position = leds;
}

void pl_lcd_log_short(char *message)
{
    int len = strlen(message);
    pl_lcd_set_cursor(0, 1);
    pl_lcd_display_str(message);
    // Fill the rest of the line with spaces so that no artifacts from previous messages remain
    for (int i = len; i < 16; i++)
    {
        pl_lcd_display_char(' ');
    }
}

void pl_lcd_log(char *message)
{
    autoscroll();
    pl_lcd_set_cursor(16, 1);
    while (*message)
    {
        pl_lcd_display_char(*message++);
        delay_microseconds(90000);
    }
    no_autoscroll();
}
