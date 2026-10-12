void main() {

    int n = 100;
    java.util.Random rand = new java.util.Random(3141);

    BinaryHeap heap = new BinaryHeap(n);
    for (int i = 0; i < n; i++) {
        heap.insert(rand.nextInt(100));
    }

    while (!heap.isEmpty()) {
        IO.print(heap.removeMax() + " ");
    }
}