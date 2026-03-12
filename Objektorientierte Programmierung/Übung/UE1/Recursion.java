/* recursion:                                                 da, 2026-03-11 */
/* ------                                                                    */
/* tryyyyyyyyyyy recursion yeeey                                             */
/* ========================================================================= */


void main() {

    for (int i = 0; i < 50; i++) {
        IO.println(i + ". fibonacci = " + fibonacci(i));
    }
}


boolean isOdd(int value) {
    return (value % 2 == 1);
}

int readInt(String prompt) {
    return Integer.parseInt(IO.readln(prompt));
}

long fibonacciNaive(int n) {
    if (n <= 2) {
        return 1;
    } else {
        return fibonacciNaive(n - 1) + fibonacciNaive(n - 2);
    }
}

long fibonacci(int n) {
    return fibonacci_rec(n, 1, 1);
}

long fibonacci_rec(int n, long f1, long f2) {
    if (n <= 1) return f1;
    else return fibonacci_rec(n - 1, f2, f1 + f2);
}