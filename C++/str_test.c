#include <stdio.h>


int main() {

    char char_arr[] = "char_array";

    char* char_ptr_arr = "ptr_array";


    printf("char_arr: %s\n", char_arr);
    printf("char_ptr_arr: %s\n\n", char_ptr_arr);

    char_arr[0] = 'T';  // geht
    char_ptr_arr[0] = 'T'; // geht net

    printf("char_arr: %s\n", char_arr);
    printf("char_ptr_arr: %s\n", char_ptr_arr);
}