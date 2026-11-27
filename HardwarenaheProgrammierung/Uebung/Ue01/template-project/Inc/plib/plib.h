/*
 * plib.h
 *
 * This is the public interface of the peripheral library (plib).
 * Its main purpose is to initialize the board, the external buttons as well as the LCD display which is connected through I2C.
 * It furthermore provides helper functions to interact with the board's LED, button, external buttons, and the LCD display.
 *
 * How to use the plib:
 *
 * The app must call pl_init() first. This sets up the board. After that the application code can be implemented and called.
 * If the display and external buttons are used, separate init functions are provided that need to be called before being able to use them.
 *
 */

#ifndef PLIB_H_
#define PLIB_H_

#include <stdint.h>
#include "plibi_buttons.h"

#define PL_TICKS_PER_SECOND 1000

/*
 * Initialize the board (clock sources, clock speed, timer,...)
 * Needs to be called at application start.
 */
void pl_init(void);

/*
 * Switches the user led on the real hardware on (0) or off (1)
 */
void pl_board_led_set(uint8_t onoff);

/*
 * Returns if the user button (on the real hardware) is pressed (0) or not pressed (1)
 *
 */
int pl_board_button_get(void);

/*
 * Initialize the external buttons by configuring the GPIOs.
 * This assumes that the buttons are connected to GPIOC pins PC11, PC12, PC2, and PC3 on the Morpho connectors,
 * and that they are active-low (pressed = input reads 0).
 * Needs to be called at application start.
 */
void pl_init_buttons();

/*
 * Reads the current state of the external buttons (if one was pressed or not) and writes it to the states argument.
 * button_pins is an array of 4 pin numbers (uint8_t) corresponding to the external buttons.
 * It needs to be explicitly filled with the EXTERNAL_BUTTON_* defines by the caller, who is also responsible
 * for the order of the buttons in the array.
 *
 * button_states is an array of 4 uint8_t values that will be filled with the current state
 * of the buttons (1 = pressed, 0 = released). The order of the states corresponds
 * to the order of the pins in button_pins.
 */
void pl_buttons_pressed(button_states_t states, button_pins_t button_pins);

/*
 * Initializes the LCD display over I2C.
 * Needs to be called at application start / before using the display.
 * In more detail what it does: initializes a faster clock for I2C, I2C config and LCD display startup.
 */
void pl_lcd_init();

/*
 * Clears the LCD display, so that nothing is shown on it.
 */
void pl_lcd_clear();

/*
 * Sets the cursor position on the LCD display.
 * Needs to be called before displaying any content on the LCD.
 * col specifies the column (0-based) and row specifies the row (0-based).
 * There are 2 rows and 16 columns on the LCD display.
 */
void pl_lcd_set_cursor(uint8_t col, uint8_t row);

/*
 * Displays an unsigned 16-bit integer on the LCD display.
 * The value will be shown at the current cursor position.
 */
void pl_lcd_display_u16(uint16_t v);

/*
 * Displays a single character on the LCD display.
 * The character will be shown at the current cursor position.
 */
void pl_lcd_display_char(char c);

/*
 * Displays a null-terminated string on the LCD display.
 * The string will be shown starting at the current cursor position.
 */
void pl_lcd_display_str(const char *s);

/*
 * Logging function for the LCD display.
 * The message can be arbitrarily long and will scroll through the display.
 * The whole display is used, so all content may be overwritten as the message scrolls.
 */
void pl_lcd_log(char *message);

/*
 * Logs a short message on the LCD display.
 * Only the second row of the LCD display is used for the message.
 * Therefore, if the message is > 16 characters, it will be truncated.
 * The first row of the LCD remains unchanged.
 */
void pl_lcd_log_short(char *message);

/*
 * Creates a custom character for the LCD display.
 * location specifies the character slot (0-7) where the character will be stored.
 * Note that location 0 and 1 are used for the lcd "led" display, so they should not be used for custom characters as 
 * they will be overwritten by the LED functions.
 * charmap is an array of 8 bytes defining the character pattern.
 */
void lcd_create_char(uint8_t location, const uint8_t charmap[8]);

/*
 * Initializes the "virtual" LEDs on the LCD display.
 * Needs to be called before using the LED functions.
 */
void pl_lcd_led_init();

/*
 * Sets the state of the 8 "virtual" LEDs on the LCD display.
 * The leds argument is a bitmask where each bit represents an LED (1 = on, 0 = off).
 * Each bit in the bitmask corresponds to a specific LED on the display.
 */
void pl_lcd_led_set(uint8_t leds);

#endif
