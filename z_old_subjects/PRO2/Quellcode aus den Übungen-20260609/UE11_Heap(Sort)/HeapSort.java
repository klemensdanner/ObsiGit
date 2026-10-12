public class HeapSort {

    public static void sort(int[] a) { // top-down strategy
        int n = 1;

        while (n < a.length) {
            n++;
            swim(a, n);
        }
        // heap is ready ...

        while (n > 1) {
            swap(a, 1, n);
            n--;
            sink(a, 1, n);
        }
    } // sort

    public static void sortOptimized(int[] a) {  // bottom-up strategy
        int n = a.length;

        for (int k = n/2; k >= 1; k--) {
            sink(a, k, n);
        }

        while (n > 1) {
            swap(a, 1, n);
            n--;
            sink(a, 1, n);
        }        
    }

    private static void swim(int[] a, int i) {
        while (i > 1 && isLess(a, i/2, i)) {
            swap(a, i/2, i);
            i = i/2;
        }
    } //swim

    private static void sink(int[] heap, int i, int n) {
        int j = 2 * i;
        if (j <= n) {
            if (j < n && isLess(heap, j, j+1)) {
                j++;
            }
            if (isLess(heap, i, j)) {
                swap(heap, i, j);
                sink(heap, j, n);
            }
        }
    } // sink

    private static boolean isLess(int[] heap, int i, int j) {
        return heap[i-1] < heap[j-1]; // -1 to start sorting at index 0
    } // isLess

    private static void swap(int[] heap, int i, int j) {
        int tmp = heap[i-1];   // -1 to start sorting at index 0
        heap[i-1] = heap[j-1];
        heap[j-1] = tmp;
    } // swap   
    
}
