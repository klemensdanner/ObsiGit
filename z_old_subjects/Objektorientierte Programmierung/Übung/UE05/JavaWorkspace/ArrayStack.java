/* Stack:                                                     DA, 2026-04-15 */
/* ------                                                                    */
/* Stack that uses an array                                                  */
/* ========================================================================= */

public class ArrayStack implements Stack<Integer> {
    protected int[] data;
    private int top;
    protected int capacity;

    public ArrayStack(int capacity) {
        if (capacity <= 0) throw new IllegalArgumentException("capacity must be larger than 0");
        this.capacity = capacity;
        this.data = new int[capacity];
        this.top = 0;
    }
    

    @Override // wenn man Methoden absichtlich überschreibt, schreibt man @Override
    public void push(Integer value) {
        data[top] = value;
        top++;

    }
    
    @Override
    public Integer pop() {
        top--;
        return data[top];
        
    }


    @Override
    public boolean isEmpty() {
        return top == 0;
    }


    @Override
    public boolean isFull() {
        return top == capacity;
    }


    @Override
    public int size() {
        return top;
    }
}