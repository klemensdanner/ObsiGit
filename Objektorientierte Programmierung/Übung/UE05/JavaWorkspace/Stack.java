/* Stack:                                                     DA, 2026-04-15 */
/* ------                                                                    */
/* generic interface for a stack                                                     */
/* ========================================================================= */

public interface Stack<E> { // Parameter zum Typ festlegen - Elementdatentyp
    void push(E value);
    E pop();
    boolean isEmpty();
    boolean isFull();
    int size();
}