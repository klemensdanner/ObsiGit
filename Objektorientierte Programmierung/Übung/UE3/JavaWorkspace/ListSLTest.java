/* ListSLTest:                                                DA, 2026-03-25 */
/* ------                                                                    */
/* Test the class ListSL                                                     */
/* ========================================================================= */

void main() {
    ListSL list = new ListSL();
    list.addFirst("A");
    list.addFirst("B");
    list.addLast("C");
    list.addLast("D");
    list.addLast("E");
    list.addLast("F");

    IO.println(list);

}