
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




void rightShift(int[] a) {
    int len = a.length;
    int tmp = a[len - 1];
    for (int i = 0; i < len-1; i++) {
        a[len-1 -i] = a[len-1 -i -1];
    }
    a[0] = tmp;
}












void reverse(int[] a) {
    int tmp;
    for (int i = 0; i < (a.length / 2); i++) {
        tmp = a[i];
        a[i] = a[a.length-1 - i];
        a[a.length-1 - i] = tmp;
    }
}

String toString(int[] a) {
    StringBuilder sb = new StringBuilder();
    for (int i = 0; i < a.length; i++) {
        sb.append(a[i]).append(" ");
    }
    return sb.toString();
}

void printMatrix(int[][] matrix) {
    for (int i = 0; i < matrix.length; i++) {
        for (int j = 0; j < matrix[i].length; j++) {
            IO.print(matrix[i][j]);
        }
        IO.println();
    }
}

int[] flatten(int[][] jagged) {
    assert jagged != null;
    int nrValues = 0;
    for (int i = 0; i < jagged.length; i++) {
        nrValues += jagged[i].length;
    }

    int flatCount = 0;
    int [] flat = new int[nrValues];

    for (int i = 0; i < jagged.length; i++) {
        for (int j = 0; j < jagged[i].length; j++) {
            flat[flatCount] = jagged[i][j];
            flatCount++;
         }
    }
    return flat;
}

void main() {
    int[] array = new int[]{1,2,3,4,5,6};
    IO.println(toString(array));
   // reverse(array);
   // IO.println(toString(array));

   // int[][] matrix = new int[3][5];


    rightShift(array);
    IO.println(toString(array));
    
}