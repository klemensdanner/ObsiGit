/* Stack:                                                     DA, 2026-04-15 */
/* ------                                                                    */
/* Stack that uses an array                                                  */
/* ========================================================================= */

public class SafeArrayStack extends ArrayStack {

    public SafeArrayStack(int capacity) {
        super(capacity);
    }
    
    public void push(Integer value) {
        if (isFull()) throw new IllegalStateException("stack is full");
        super.push(value);
    }
    
    public Integer pop() {
        if (isEmpty()) throw new IllegalStateException("stack is empty");
        return super.pop();
        
    }

}