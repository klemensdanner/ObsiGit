cmake_minimum_required(VERSION 4.2)

project(QtDraw VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)

add_compile_options(
        -Wall -Wextra -Wconversion
        -fsanitize=address,leak,undefined
)

find_package(Qt6 REQUIRED COMPONENTS Widgets)

add_executable(QtDraw
        #src/main.cpp
       # src/shapes.h src/shapes.cpp
        src/drawwindow.cpp src/drawwindow.h
)

target_link_libraries(QtDraw PRIVATE
        asan ubsan # address santitizer and undefined behaviour sanitizer
        Qt6::Widgets
)
