

void printAllVariationsOf3() {
    int n = 3;
    int[] v = new int[n];
    int ct = 0;
    for (int i = 0; i < n; i++) {
        v[0] = i;
        for (int j = 0; j < n; j++) {
            v[1] = j;
            for (int k = 0; k < n; k++) {
                v[2] = k;
                IO.println(Arrays.toString(v));
                ct++;
            }
        }
    }
    IO.println("nr of variations > " + ct);
}

void printAllVariations(int n) {
    int[] v = new int[n];
    printAllVariationsRec(v, 0);


}

void printAllVariationsRec(int[] v, int i) {
    if (i == v.length) {
        IO.println(Arrays.toString(v));
    } else {
        for (int j = 0; j < v.length; j++) {
            v[i] = j;
            printAllVariationsRec(v, i + 1);
        }
    }
}



void main() {
    //printAllVariationsOf3();+
    printAllVariations(5);
}