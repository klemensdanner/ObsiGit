public class ObjPriorityQueue {

    private static class Entry {
        public int priority;
        public Object obj;

        public Entry(int priority, Object obj) {
            assert obj != null;
            this.priority = priority;
            this.obj = obj;
        }
    }

    private Entry[] heap;
    private int n;
    private int capacity;

    private final int INITIAL_CAPACITY = 300;

    public ObjPriorityQueue() {
        this.heap = new Entry[INITIAL_CAPACITY + 1];
        this.capacity = INITIAL_CAPACITY;
        this.n = 0;
    }

    public int size() { return n; }

    public boolean isEmpty() { return n == 0; } 

    public void insert(int prority, Object obj) {
        assert (n < capacity);
        n++;
        heap[n] = new Entry(prority, obj);
        swim(n);
    }

    public Object removeMax() {
        assert !isEmpty();
        Entry max = heap[1];
        heap[1] = heap[n];
        n--;
        sink(1);
        return max.obj;
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
        return heap[i].priority < heap[j].priority;
    }

    private void swap(int i, int j) {
        Entry tmp = heap[i];
        heap[i] = heap[j];
        heap[j] = tmp;
    }
    
}