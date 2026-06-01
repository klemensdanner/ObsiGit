import java.util.Random;

void main() {
    Random rand = new Random(1234);
    int n = 10000000;
    int[] a = new int[n];

    for (int i = 0; i < n; i++) {
        a[i] = rand.nextInt(n);
    }

    HeapSort.sort_optimized(a);

    for (int i = 0; i < a.length; i++) {
        IO.print(a[i] + " ");
    }
}