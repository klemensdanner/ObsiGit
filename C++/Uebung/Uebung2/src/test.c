#include <stdio.h>
#include <stdlib.h>
#include "str.h"

int main() {
    str_t s = str_create(5, "str_t");
    str_print(s);
    str_free(&s)
    printf("\n");

    return 0
}