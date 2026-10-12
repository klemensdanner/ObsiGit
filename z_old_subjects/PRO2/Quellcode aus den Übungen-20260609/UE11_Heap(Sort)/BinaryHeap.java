public class BinaryHeap {

    private int[] heap;
    private int n;
    private int capacity;

    public BinaryHeap(int capacity) {
        this.heap = new int[capacity + 1];
        this.capacity = capacity;
        this.n = 0;
    }

    public int size() { return n; }

    public boolean isEmpty() { return n == 0; } 

    public void insert(int e) {
        assert (n < capacity);
        n++;
        heap[n] = e;
        swim(n);
    }

    public int removeMax() {
        assert !isEmpty();
        int max = heap[1];
        heap[1] = heap[n];
        n--;
        sink(1);
        return max;
    }

    private void swim(int i) {
        while (i > 1 && isLess(i/2, i)) {
            swap(i/2, i);
            i = i/2;
        }
    }

    private void sink(int i) {
        int j = 2 * i;
        if (j <= n) {
            if (j < n && isLess(j, j+1)) {
                j++;
            }
            if (isLess(i, j)) {
                swap(i, j);
                sink(j);
            }
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
    
}