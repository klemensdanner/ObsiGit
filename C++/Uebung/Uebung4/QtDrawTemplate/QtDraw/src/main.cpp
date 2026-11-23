#include <format>
#include <print>

#include "drawwindow.h"
#include "shapes.h"

#define SHOW(X) std::cout << #X << " -> " << (X) << '\n';

void test_inheritance() {
    std::println("---- C++ Inheritance ----");
}

int main(int argc, char* argv[]) {
    test_inheritance();
}
