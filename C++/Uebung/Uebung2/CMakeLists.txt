
cmake_minimum_required(VERSION 3.20)

project(str LANGUAGES C)

set(CMAKE_C_STANDARD 23)
set(CMAKE_C_STANDARD_REQUIRED ON)
add_compile_options(
        -Wall -Wextra
        -Wconversion -Wshadow
        -fsanitize=address,undefined,leak
)

add_executable(string src/main.c)
target_link_libraries(string PUBLIC asan ubsan)

add_library(str STATIC src/str.h src/str.c)

add_executable(test src/test.c)
target_link_libraries(test PUBLIC asan ubsan str)