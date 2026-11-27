#ifndef PLIBI_EXT_BUTTONS_H_
#define PLIBI_EXT_BUTTONS_H_

#include <stdint.h>
#include <stdbool.h>
#include <stm32h533xx.h>
#include <stm32h5xx.h>


#define EXTERNAL_BUTTON_1 11U
#define EXTERNAL_BUTTON_2 12U
#define EXTERNAL_BUTTON_3 2U
#define EXTERNAL_BUTTON_4 3U


// type for the button states (pressed = 1, released = 0)
typedef uint8_t button_states_t[4];


// type for the button mapping of pins
typedef button_states_t button_pins_t;


void pl_init_buttons();


void pl_buttons_pressed(button_states_t states, button_pins_t button_pins);

#endif
