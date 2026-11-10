#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main() {

    char char_arr[] = "char_array";
    printf("strlen(char_dyn_arr): %ld", strlen(char_arr));

    char* char_ptr_arr = "ptr_array";



    printf("char_arr: %s\n", char_arr);
    printf("char_ptr_arr: %s\n\n", char_ptr_arr);

    char_arr[0] = 'T';  // geht
 // char_ptr_arr[0] = 'T'; // geht net

    printf("char_arr: %s\n", char_arr);
    printf("char_ptr_arr: %s\n", char_ptr_arr);
}












    /* char* char_dyn_arr = malloc(8*sizeof(char));
    char_dyn_arr = "Halloab";
    
    char_dyn_arr[7] = '\0';
    printf("strlen(char_dyn_arr): %ld", strlen(char_dyn_arr)); */
 