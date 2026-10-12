
#include <stdio.h> // mit spitzen Klammern sucht er zuerst im lokalen Verzeichnis
#include <stdlib.h>

int main(int argc, char* argv[]) {


    int a = 0;
    int b = 0;
    int result = 0;
    char op = '+';


    /*
    for (int i = 0; i < argc; i++) {
        printf("argv[%d] = %s\n", i, argv[i]);
    }*/


    if (argc != 4) {
        printf("Usage: %s [a] [op] [b]\n", argv[0]);
        return -1;
    }

    a = atoi(argv[1]);
    b = atoi(argv[3]);
    sscanf(argv[2], "%c", &op);


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