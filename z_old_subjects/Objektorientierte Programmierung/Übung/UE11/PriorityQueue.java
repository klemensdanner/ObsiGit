/* BinaryHeap:                                                 DA, 2026-05-27 */
/* ------                                                                    */
/*                                                                */
/* ========================================================================= */

public class PriorityQueue {
    private static class Entry {
        public int priority;
        public Object object;

        public Entry(int priority, Object object) {
            assert object != null;
            this.priority = priority;
            this.object = object;
        }
    }


    private Entry[] heap;
    private int n;

    public PriorityQueue(int capacity) {
        heap = new Entry[capacity + 1]; // heap[0] is unused
        n = 0;
    }


    public int size() {
        return n;
    }

    public boolean isEmpty() {
        return n == 0;
    }


    public void insert(int priority, Object object) {
        assert n < heap.length;

        n++; // next free position

        heap[n] = new Entry(priority, object);
        swim(n);
    }

    public Object removeMax() {
        assert n > 0; // heap is not empty

        Object max = heap[1].object;
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
        return heap[i].priority < heap[j].priority;
    }

    private void swap(int i, int j) {
        Entry tmp = heap[i];
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