
#include <stdio.h> // mit spitzen Klammern sucht er zuerst im lokalen Verzeichnis
#include <stdlib.h>
#include <stdbool.h>

typedef enum {
    CALC_ERR_NONE,
    CALC_ERR_INVALID_OP,
    CALC_ERR_DIVISION_BY_ZERO
} error_code_t;


error_code_t last_error = CALC_ERR_NONE;

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


    double a = 0;
    double b = 0;
    char op = '+';


    /*
    for (int i = 0; i < argc; i++) {
        printf("argv[%d] = %s\n", i, argv[i]);
    }*/


    if (argc != 4) {
        printf("Usage: %s [a] [op] [b]\n", argv[0]);
        return -1;
    }



    a = strtod(argv[1], NULL);
    b = strtod(argv[3], NULL);
    sscanf(argv[2], "%c", &op);

    bool ok = true;
    double result = calculate(a, b, op, &ok);

    if (ok == false) {
        print_last_error();
        return 1;
    } else {
        printf("Result %0.2f\n", result);
    }
    


    return 0;
}