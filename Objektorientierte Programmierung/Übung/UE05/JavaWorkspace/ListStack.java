/* Stack:                                                     DA, 2026-04-15 */
/* ------                                                                    */
/* Stack that uses an array                                                  */
/* ========================================================================= */

public class ListStack implements Stack<Integer> {

    private static class Node {
        int value;
        Node next;

        Node(int value, Node next) {
            this.value = value;
            this.next = next;
        }
    }

    private Node head;
    private int size;

    public ListStack() {
        head = null;
        size = 0;
    }

    @Override
    public void push(Integer value) {
        head = new Node(value, head);
        size++;

    }

    @Override
    public Integer pop() {
        if (isEmpty()) throw new IllegalStateException("stack is empty");
        int value = head.value;
        head = head.next;
        size--;
        return value;
    }


    @Override public boolean isEmpty() {return head == null;}
    @Override public boolean isFull() {return false;}
    @Override public int size() {
        return size;
    }
    


}