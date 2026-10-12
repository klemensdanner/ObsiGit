import java.util.Random;




void main() {
    Random rand = new Random(1234);
    int n = 100;
    BinaryHeap heap = new BinaryHeap(1000);

    for (int i = 0; i < n; i++) {
        heap.insert(rand.nextInt(n));
    }

    while (!heap.isEmpty()) {
        IO.print(heap.removeMax() + " ");
    }
}