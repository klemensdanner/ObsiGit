import swj3.collections.SortedMultiSet;

public class BSTMultiSet<T> implements SortedMultiSet<T> {

    private static class Node<T> {
        private final T value;
        private Node<T> left, right;

        Node(T value, Node<T> left, Node<T> right) {
            this.value = value;
            this.left = left;
            this.right = right;

        }
    }


    private Node<T> root;
    private int size;

    public BSTMultiSet() {
        this.root = null;
        this.size = 0;
    }

    private Node<T> addRecursive(Node<T> parent, T element) {
        if (parent == null) {
            size++;
            return new Node<>(element, null, null);
        }
    }













    @Override
    public void add(T elem) {

    }

    @Override
    public boolean contains(T elem) {
        return false;
    }

    @Override
    public T get(T elem) {
        return null;
    }

    @Override
    public int size() {
        return 0;
    }
}