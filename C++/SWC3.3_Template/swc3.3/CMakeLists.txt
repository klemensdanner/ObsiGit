cmake_minimum_required(VERSION 4.2)
project(SWC3.3 VERSION 1.0.0 LANGUAGES CXX)

# configure C++23
set(CMAKE_CXX_STANDARD 23)          # request C++23
set(CMAKE_CXX_STANDARD_REQUIRED ON) # enforce requested standard
set(CMAKE_CXX_EXTENSIONS OFF)       # disable compiler specific extensions

# --- Common compiler warnings ---
set(COMMON_WARNINGS
    -Wall
    -Wextra
    -Wpedantic
    -Wconversion
    -Werror=vla
)

add_executable(intro intro/main.cpp)
target_compile_options(intro PRIVATE ${COMMON_WARNINGS})

add_executable(intro_cpp
        intro_cpp/main.cpp
        intro_cpp/Person.h
        intro_cpp/Person.cpp
)
target_compile_options(intro_cpp PRIVATE ${COMMON_WARNINGS})

add_executable(rational
		rational/main.cpp
		rational/Rational.h
		rational/Rational.cpp)
target_compile_options(rational PRIVATE ${COMMON_WARNINGS})

