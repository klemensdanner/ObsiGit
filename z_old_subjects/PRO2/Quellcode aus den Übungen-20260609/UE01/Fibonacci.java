void main() {

    long fib = fib_naive(20);
    IO.println("fib = " + fib);

    IO.println("fib = " + fib_naive(12));
    IO.println("fib = " + fib_smart(12));    
}

long fib_naive(int n) {
    if (n <= 2) {
        return 1;
    } else {
        return fib_naive(n-1) + fib_naive(n-2);
    }
}

long fib_smart(int n) {
    return fib_rec(n, 1, 1);
}

long fib_rec(int n, int f1, int f2) {
    if (n <= 1) {
        return f1;
    } else {
        return fib_rec(n-1, f2, f1 + f2);
    } 
}