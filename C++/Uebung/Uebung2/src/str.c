#include "str.h"

#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include <stdlib.h>
#include <assert.h>


str_t str_create(size_t size, const char value[static size + 1]){
    assert(strlen(value) == size);

    const str_t result = {
        .size = size,
        .value = malloc(sizeof(char) * (size + 1))
    };

    if (result.value == NULL)
    {
        fprintf(stderr, "Out of memory while creating str_t\n");
        return (str_t) {};
    }

    memcpy(result.value, value, size);
    result.value[size] = '\0';
    return result;

}

void str_free(str_t *s){
    if (s->value != NULL)
    {
        free(s->value);
        s->value;
    }

}

void str_print(const str_t s){
    for (size_t i = 0; i < s.size; i++)
    {
        putchar(s.value[i]);
    }

}


const char* str_cstr(str_t s) {
    if (s.value == nullptr) {
        s.value = "";
    }
    return s.value;
}


str_t str_copy_from(const char value[static 1]) {
    return str_create(strlen(value), value);
}

str_t str_copy(str_t s) {
    return str_create(s.size, s.value);
}


str_t str_concat(str_t a, st_t b) {

}