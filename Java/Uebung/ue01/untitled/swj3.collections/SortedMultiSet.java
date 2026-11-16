package swj3.collections;

public interface SortedMultiSet<T> {
    void add(T elem);
    boolean contains(T elem);
    T get(T elem);
    int size();
    default boolean isEmpty() {
        return size() == 0;
    }
}