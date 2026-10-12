/* HeapSort:                                                   DA, 2026-05-27 */
/* ------                                                                     */
/*                                                                            */
/* =========================================================================  */

public class HeapSort {

    public static void sort(int[] a) {
        int n = 1;
        while (n < a.length) { // build heap
            n++;
            swim(a, n);
        }

        while (n > 1) {
            swap(a, 1, n);
            n--;
            sink(a, 1, n);
        }

    }



    public static void sort_optimized(int[] a) {
        int n = a.length;
        for (int i = n / 2; i >= 1; i--) {
            sink(a, i, n);
        }

        while (n < a.length) { // build heap
            n++;
            swim(a, n);
        }

        while (n > 1) {
            swap(a, 1, n);
            n--;
            sink(a, 1, n);
        }

    }




    private static void swim(int[] a, int i) {
        int parent = i / 2;
        while ((i > 1) && (isLess(a, parent, i))) {
            swap(a, parent, i);
            i = parent;
            parent = i / 2;
        }

    }

    private static boolean isLess(int[] a, int i, int j) {
        return a[i-1] < a[j-1];
    }

    private static void swap(int[] a, int i, int j) {
        int tmp = a[i-1];
        a[i-1] = a[j-1];
        a[j-1] = tmp;
    }


    private static void sink(int[] a, int i, int n) {
        int child = i * 2;
        if (child <= n) {
            if ((child < n) && isLess(a, child, child + 1)) {
                child++; // right child is larger -> sink to the right
            }
            if (isLess(a, i, child)) {
                swap(a, i, child);
                sink(a, child, n);
            }
        }
    }
}