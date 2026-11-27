#ifndef PLIBI_I2C_LCD_H_
#define PLIBI_I2C_LCD_H_

#include <stdint.h>
#include <stdbool.h>
#include <stm32h533xx.h>
#include <stm32h5xx.h>
#include "plib.h"
#include "plibi_mini_hal.h"

/*                                          I2C functions and definitions                                         */

// I2C + PCF8574 backpack configuration for HD44780.
// Change these values if your wiring uses another I2C instance/pins/address.
#define LCD_I2C_PORT I2C1
// This address is correct according to the product page (amazon) and the datasheet of the PCF8574.
#define LCD_I2C_ADDR_7BIT 0x27U
// Common alternative address used by many PCF8574A backpacks.
#define LCD_I2C_ADDR_ALT_7BIT 0x3FU

// Standard-mode (100 kHz) timing for a 64 MHz I2C1 kernel clock (HSI).
/*
0x 1 0 7 0 7D BC
   | | | |  |  |
   | | | |  |  +-- SCLL = 0xBC (188 -> t_SCLL ~5.91 us)
   | | | |  +----- SCLH = 0x7D (125 -> t_SCLH ~3.94 us)
   | | | +-------- SDADEL = 0x0
   | | +---------- SCLDEL = 0x7 (-> 250 ns data setup)
   | +------------ Reserved bits
   +-------------- PRESC = 0x1 (divide by 2 -> t_presc = 31.25 ns)
*/
#define LCD_I2C_TIMINGR 0x10707DBCUL
// try this for more error margin: 0x10707FBCUL

typedef enum
{
    I2C1_ERR_NONE = 0,
    I2C1_ERR_BUS_BUSY_TIMEOUT,
    I2C1_ERR_TIMEOUT_WAIT_TXIS,
    I2C1_ERR_BERR,
    I2C1_ERR_ARLO,
    I2C1_ERR_STOP_BEFORE_TX,
    I2C1_ERR_NACK,
    I2C1_ERR_TIMEOUT_WAIT_STOP
} i2c1_error_t;

/*                                           Backpack functions and definitions                                */

// Common PCF8574 backpack bit mapping:
// P0=RS, P1=RW, P2=EN, P3=BL, P4=D4, P5=D5, P6=D6, P7=D7.
#define LCD_PCF_RS (1U << 0)
#define LCD_PCF_RW (1U << 1)
#define LCD_PCF_EN (1U << 2)
#define LCD_PCF_BL (1U << 3) // backlight control bit
#define LCD_PCF_D4 (1U << 4)
#define LCD_PCF_D5 (1U << 5)
#define LCD_PCF_D6 (1U << 6)
#define LCD_PCF_D7 (1U << 7)

void lcd_expander_write(uint8_t value);

/*                                           LCD functions and definitions                                       */

// defines from LiquidCrystal
// commands
#define LCD_CLEARDISPLAY 0x01
#define LCD_RETURNHOME 0x02
#define LCD_ENTRYMODESET 0x04
#define LCD_DISPLAYCONTROL 0x08
#define LCD_CURSORSHIFT 0x10
#define LCD_FUNCTIONSET 0x20
#define LCD_SETCGRAMADDR 0x40
#define LCD_SETDDRAMADDR 0x80

// flags for display entry mode
#define LCD_ENTRYRIGHT 0x00
#define LCD_ENTRYLEFT 0x02
#define LCD_ENTRYSHIFTINCREMENT 0x01
#define LCD_ENTRYSHIFTDECREMENT 0x00

// flags for display on/off control
#define LCD_DISPLAYON 0x04
#define LCD_DISPLAYOFF 0x00
#define LCD_CURSORON 0x02
#define LCD_CURSOROFF 0x00
#define LCD_BLINKON 0x01
#define LCD_BLINKOFF 0x00

// flags for display/cursor shift
#define LCD_DISPLAYMOVE 0x08
#define LCD_CURSORMOVE 0x00
#define LCD_MOVERIGHT 0x04
#define LCD_MOVELEFT 0x00

#define LCD_4BITMODE 0x00U
#define LCD_2LINE 0x08U
#define LCD_5x8DOTS 0x00U

// global lcd and "led" definitions
void pl_lcd_clear();

void pl_lcd_set_cursor(uint8_t col, uint8_t row);

void pl_lcd_display_u16(uint16_t v);

void pl_lcd_display_char(char c);

void pl_lcd_display_str(const char *s);

void pl_lcd_init();

void pl_lcd_led_init();

void pl_lcd_led_set(uint8_t leds);

void pl_lcd_log(char *message);

void pl_lcd_log_short(char *message);

#endif
