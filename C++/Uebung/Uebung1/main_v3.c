
#include <stdio.h> // mit spitzen Klammern sucht er zuerst im lokalen Verzeichnis
#include <stdlib.h>
#include <stdbool.h>

double calculate(double a, double b, char op, bool* ok) {
    double result = 0.0;
    *ok = true;



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
            } else {
                result = a / b;
            }
            break;
        default: *ok = false;
        break;
    }
    return result;

}



int main(int argc, char* argv[]) {


    int a = 0;
    int b = 0;
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
        printf("error\n");
        return 1;
    } else {
        printf("Result %0.2f\n", result);
    }
    


    return 0;
}