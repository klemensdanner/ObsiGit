
#include <stdio.h> // mit spitzen Klammern sucht er zuerst im lokalen Verzeichnis

int main(void) {


    int a = 0;
    int b = 0;
    int result = 0;
    char op = '+';

    printf("Calculator: ");
    scanf("%i %c %i", &a, &op, &b);

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
            result = a / b;
            break;
        default: result = 0;
        break;
    }

    printf("Result %i\n", result);


    return 0;
}