void main() {
    int number = 7;

    if (isOdd(number)) {
        IO.println("number is odd");
    } else {
        IO.println("number is even");
    }
}

boolean isOdd(int val) {
    return val % 2 != 0;
}