/* Arrays:                                                    DA, 2026-03-16 */
/* ------                                                                    */
/* fun with simple arrays in java                                            */
/* ========================================================================= */

void fillRandom(double[] a) {
    for (int i = 0; i < a.length; i++) { // Schleifenbedingung i < a.length 
    // wird immer neu geprüft. Komplizierte Schleifenbedingungen werden immer neu
    // berechnet
        a[i] = Math.random();
    }
}

void fillRandom(double[][] m) {
    for (int i = 0; i < m.length; i++) {
        fillRandom(m[i]);
    }
}

void printArray(double[] a) {
    for (int i = 0; i < a.length; i++) {
        IO.print(a[i] + " ");
    }
    IO.println();
}

void printArray1(double[] a) {
    for (double value : a) {
        IO.print(value + " ");
    }
    IO.println();
}

void printMatrix(double[][] m) {
    for (int i = 0; i < m.length; i++) {
        printArray(m[i]);
    }
    IO.println();
}

double dotProduct(double[] a, double[] b) {
    assert a.length == b.length;
    double sum = 0;
    for (int i = 0; i < a.length; i++) {
        sum += a[i] * b[i];
    }
    return sum;
}

double[][] createTriangularMatrix(int rows) {
    double[][] m = new double[rows][]; // double[][rows] wär logischer
    for (int i = 0; i < rows; i++) {
        m[i] = new double[i+1];
    }
    return m;
}


void main() {
    double[] a = new double[10];
    fillRandom(a);
    double[] b = new double[10];
    fillRandom(b);
    double dp = dotProduct(a, b);
    IO.println(dp);


    double[][] m = new double[10][10];

    fillRandom(m);
    printMatrix(m);

/* 
    int[] a = new int[17];
    int[] b;
    a[0] = 17;
    b = a;
    IO.println(b[0]);
    a[16] = 5;*/
}