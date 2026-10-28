#ifndef STR_H
#define STR_H

#include <stddef.h>

typedef struct
{
    size_t size;
    char* calue;
} str_t;

str_t str_create(size_t size, const char value[static size + 1]);
#define STR(S) str_create(sizeof(S) - 1, (S));
void str_free(str_t s);

const char* str_cstr(str_t s);
str_t ctr_copy_from(const char value[static 1]);
str_t str_copy(str_t s);

str_t str_concat(str_t a, str_t b);
void str_append(str_t *s, str_t other);
void str_print(str_t s);
size_t str_printf(str_t fmt, ...);

bool str_eq(str_t a, str_t b);
bool str_cmp(str_t a, str_t b);



#endif //STR_H