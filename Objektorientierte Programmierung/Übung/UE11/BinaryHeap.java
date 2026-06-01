/* BinaryHeap:                                                 DA, 2026-05-27 */
/* ------                                                                    */
/*                                                                */
/* ========================================================================= */

public class BinaryHeap {
    private int[] heap;
    private int n;

    public BinaryHeap(int capacity) {
        heap = new int[capacity + 1]; // heap[0] is unused
        n = 0;
    }


    public int size() {
        return n;
    }

    public boolean isEmpty() {
        return n == 0;
    }


    public void insert(int value) {
        assert n < heap.length;

        n++; // next free position

        heap[n] = value;
        swim(n);
    }

    public int removeMax() {
        assert n > 0; // heap is not empty

        int max = heap[1];
        heap[1] = heap[n];
        n--;
        sink(1);

        return max;
    }


    private void swim(int i) {
        int parent = i / 2;
        while ((i > 1) && (isLess(parent, i))) {
            swap(parent, i);
            i = parent;
            parent = i / 2;
        }

    }

    private boolean isLess(int i, int j) {
        return heap[i] < heap[j];
    }

    private void swap(int i, int j) {
        int tmp = heap[i];
        heap[i] = heap[j];
        heap[j] = tmp;
    }


    private void sink(int i) {
        int child = i * 2;
        if (child <= n) {
            if ((child < n) && isLess(child, child + 1)) {
                child++; // right child is larger -> sink to the right
            }
            if (isLess(i, child)) {
                swap(i, child);
                sink(child);
            }
        }
    }
}