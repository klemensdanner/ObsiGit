
#include <stdio.h> // mit spitzen Klammern sucht er zuerst im lokalen Verzeichnis
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define COMMAND_BUFFER_SIZE 50

typedef enum {
    CALC_ERR_NONE,
    CALC_ERR_INVALID_OP,
    CALC_ERR_DIVISION_BY_ZERO
} error_code_t;


error_code_t last_error = CALC_ERR_NONE;


void print_usage() {
    printf("Usage: ./calc [options]\n");
    printf("Options:\n");
    printf("  --help   shop help page");
}



double calculate(double a, double b, char op, bool* ok) {
    double result = 0.0;
    *ok = true;

    last_error = CALC_ERR_NONE;
    

    switch(op) {
        case '+':
            result = a + b;
            break;
        case '-':
            result = a - b;
            break;
        case '*':
            result = a * b;
            break;
        case '/':
            if (b == 0) {
                *ok = false;
                last_error = CALC_ERR_DIVISION_BY_ZERO;
            } else {
                result = a / b;
            }
            break;
        default:
            *ok = false;
            last_error = CALC_ERR_INVALID_OP;
        break;
    }
    return result;

}


void print_last_error(void) {
    switch (last_error)
    {
    case CALC_ERR_NONE:
        printf("No error\n");
        break;
    case CALC_ERR_DIVISION_BY_ZERO:
        printf("Error - division by zero\n");
        break;
        
    case CALC_ERR_INVALID_OP:
        printf("Error: invalid operator\n");
        break;
    }
}



int main(int argc, char* argv[]) {

/*

    */


    /*
    for (int i = 0; i < argc; i++) {
        printf("argv[%d] = %s\n", i, argv[i]);
    }*/


    if (argc == 2 && (strcmp(argv[1], "--help") == 0)) { // strcmp gibt 0 zurück wenn gleich, sonst die Stelle ab ders nicht gleich ist
        printf("Usage: %s [a] [op] [b]\n", argv[0]);
        return -1;
    }


    char command[COMMAND_BUFFER_SIZE];
    bool exit_requested = false;

    while (!exit_requested) {
        printf("Calc > ");

        char *s = fgets(command, COMMAND_BUFFER_SIZE, stdin);

        if (!s ||
             strncmp(command, "exit", 4) == 0 ||
             strncmp(command, "quit", 4) == 0) {
            printf("Exiting calculator\n");
            exit_requested = true;
        } else if (strncmp(command, "help", 4) == 0) {
            print_usage();
        } else {
            double a = 0;
            double b = 0;
            char op = '+';

            if (sscanf(command, "%lf %c %lf", &a, &op, &b) != 3) {
                printf("Invalid command format. Use [a] [op] [b]\n");
                continue;
            }


            bool ok = true;
            double result = calculate(a, b, op, &ok);

            if (ok == false) {
                print_last_error();
                continue;
            } else {
                printf("Result %0.2f\n", result);
            }
        }
    }






    return 0;
}