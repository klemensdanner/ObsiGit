package swj3.collections;

import java.util.Iterator;

public class BSTMultiSet<T extends Comparable<T>> implements SortedMultiSet<T> implements Iterable{

	private final Deque<Node<T>> unvisitedParents = new ArrayDeque<>();

	BSTIterator(Node<T> root) {
		Node<T> next = root;
		while(next != null) {
			unvisitedParents.add(next);
			next = next.left;
		}
	}

	@Override
	public boolean hasNext() {
		return !unvisitedParents.isEmpty();
	}

	@Override
	public T next() {
		if(!hasNext()) {
			throw new NoSuchElementException();
		}

		Node<T> current = unvisitedParents.pop();
		Node<T> next = current.right;

		while (next != null) {
			unvisitedParents.push(next);
			next = next.left;
		}

		return current.value;
	}
}

@Override
public Iterator<T> iterator() {
	return new BSTIterator<>(root);
}

private static class Node<T> {
	private final T value;
	private Node<T> left, right;

	Node(T value, Node<T> left, Node<T> right) {
		this.value = value;
		this.left = left;
		this.right = right;

	}
}

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

		if (element.compareTo(parent.value) < 0) {
			parent.left = addRecursive(parent.left, element);
		} else {
			parent.right = addRecursive(parent.right, element);
		}


        return parent; //stimmt das?
    }



	@Override
	public void add(T elem) {
		root = addRecursive(root, elem);
	}

	@Override
	public boolean contains(T elem) {
		return get(elem) != null;

	}

	@Override
	public T get(T elem) {
		Node<T> t = root;
		while (t != null) {
			int cmp = t.value.compareTo(elem);
			if (cmp == 0) {
				return t.value;
			} else if (cmp > 0) {
				t = t.left;
			} else {
				t = t.right;
			}
		}

		return null;
	}

	@Override
	public int size() {
		return size;

	}


	@Override
	public T first() throws EmptySetException {
		if (root == null) {
			throw new EmptySetException("first is undefined for empty set");
		}

		Node<T> t = root;
		while (t.left != null) {
			t = t.left;
		}
		return t.value;
	}


	public T last() throws EmptySetException {
		if (root == null) throw new EmptySetException("last is undefined for empty set");
		Node<T> t = root;
		while (t.right != null) {
			t = t.right;
		}
		return t.value;
	}
}