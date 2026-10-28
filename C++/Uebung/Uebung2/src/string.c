#include <stdio.h>
#include <string.h>

#define SHOW_INT(X) printf("%s -> %d\n", #X, (X))
#define SHOW_SIZE(X) printf("%s -> %zu\n", #X, (X))
#define SHOW_STRING(X) printf("%s -> '%s' (%zu/%zu)\n", #X, (X), strlen(X), sizeof(X))


int main() {
    const char first[] = "Julian";
    const char last[] = "Holzmann";
    constexpr size_t n = sizeof(first) + sizeof(last); // shit works

    char full[n] = {}; // zero is initialized

    SHOW_STRING(first);
    SHOW_STRING(last);
    SHOW_STRING(full);


    strncpy(full, first, n);
    full[n-1] = '\n';
    SHOW_STRING(full);
    



}