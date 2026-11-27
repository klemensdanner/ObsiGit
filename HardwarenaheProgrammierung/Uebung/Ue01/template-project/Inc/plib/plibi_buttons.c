#include <stdint.h>
#include <stdbool.h>
#include <stm32h533xx.h>
#include <stm32h5xx.h>
#include "plib.h"
#include "plibi_mini_hal.h"
#include "plibi_buttons.h"

/* Configuration and utility functions for external buttons.
   This assumes that the buttons are connected to GPIOC pins PC11, PC12, PC2, and PC3 on the Morpho connectors,
   and that they are active-low (pressed = input reads 0).
   The helper functions will nevertheless return 1 for a pressed button and 0 for a released button
*/

void pl_init_buttons()
{
    // external buttons are connected to PC11, PC12, PC2 and PC3.
    // configure them as inputs to read their state (pressed or not pressed).
    // when pressed, the input reads 0 (active-low), therefore configure pull-up resistors on the input pins.
    SET_BIT(RCC->AHB2ENR, RCC_AHB2ENR_GPIOCEN);
    (void)READ_BIT(RCC->AHB2ENR, RCC_AHB2ENR_GPIOCEN);

    MODIFY_REG(GPIOC->PUPDR,
               GPIO_PUPDR_PUPD11_Msk | GPIO_PUPDR_PUPD12_Msk | GPIO_PUPDR_PUPD2_Msk | GPIO_PUPDR_PUPD3_Msk,
               (GPIO_PULLUP << GPIO_PUPDR_PUPD11_Pos) |
                   (GPIO_PULLUP << GPIO_PUPDR_PUPD12_Pos) |
                   (GPIO_PULLUP << GPIO_PUPDR_PUPD2_Pos) |
                   (GPIO_PULLUP << GPIO_PUPDR_PUPD3_Pos));

    MODIFY_REG(GPIOC->MODER,
               GPIO_MODER_MODE11_Msk | GPIO_MODER_MODE12_Msk | GPIO_MODER_MODE2_Msk | GPIO_MODER_MODE3_Msk,
               (GPIO_MODE_INPUT << GPIO_MODER_MODE11_Pos) |
                   (GPIO_MODE_INPUT << GPIO_MODER_MODE12_Pos) |
                   (GPIO_MODE_INPUT << GPIO_MODER_MODE2_Pos) |
                   (GPIO_MODE_INPUT << GPIO_MODER_MODE3_Pos));
}

static uint8_t external_button_pressed(uint8_t button_pin)
{
    // Active-low buttons: pressed means input reads 0 with pull-up enabled.
    if ((GPIOC->IDR & (1U << button_pin)) == 0U)
    {
        return 1; // button is pressed
    }
    else
    {
        return 0; // button is not pressed
    }
}

/*
    button_pins is an array of 4 pin numbers (uint8_t) corresponding to the external buttons.
    It gets filled with the EXTERNAL_BUTTON_* defines by the caller, who is also responsible 
    for the order of the buttons in the array.
    
    button_states is an array of 4 uint8_t values that will be filled with the current state 
    of the buttons (1 = pressed, 0 = released). The order of the states corresponds 
    to the order of the pins in button_pins.
*/
void pl_buttons_pressed(button_states_t states, button_pins_t button_pins)
{
    states[0] = external_button_pressed(button_pins[0]);
    states[1] = external_button_pressed(button_pins[1]);
    states[2] = external_button_pressed(button_pins[2]);
    states[3] = external_button_pressed(button_pins[3]);
}
