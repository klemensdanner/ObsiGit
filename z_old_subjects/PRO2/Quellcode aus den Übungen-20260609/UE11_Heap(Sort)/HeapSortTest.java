void main() {
    int n = 100;
    int[] xs = new int[n];
    java.util.Random rand = new java.util.Random(3141);

    for (int i = 0; i < n; i++) {
        xs[i] = rand.nextInt(100);
    }

    HeapSort.sort(xs);

    for (int i = 0; i < n; i++) {
        IO.print(xs[i] + " ");
    }

    IO.println();
    xs = new int[n];
    rand = new java.util.Random(3141);

    for (int i = 0; i < n; i++) {
        xs[i] = rand.nextInt(100);
    }

    HeapSort.sortOptimized(xs);

    for (int i = 0; i < n; i++) {
        IO.print(xs[i] + " ");
    }    

}