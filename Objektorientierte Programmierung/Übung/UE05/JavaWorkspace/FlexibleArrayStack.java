/* Stack:                                                     DA, 2026-04-15 */
/* ------                                                                    */
/* Stack that can grow in size                                               */
/* ========================================================================= */

public class FlexibleArrayStack extends SafeArrayStack {
    private static final int DEFAULT_CAPACITY = 5;

    public FlexibleArrayStack() {
        super(DEFAULT_CAPACITY);
    }


    @Override
    public void push(Integer value) {
        if (super.isFull()) {
            grow();
        }
        super.push(value);
    }

    private void grow() {
        int newCapacity = capacity * 2;
        int[] newData = new int[newCapacity];
        System.arraycopy(data, 0, newData, 0, capacity);
        data = newData;
        capacity = newCapacity;
    }
    


    @Override
    public boolean isFull() {
        return false;
    }
}