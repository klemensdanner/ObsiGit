/* StackTest:                                                 DA, 2026-04-15 */
/* ------                                                                    */
/* cass for stacks                                                           */
/* ========================================================================= */




void main() {
    Stack<Integer> s = new FlexibleArrayStack();


    try { // try catch block, wenn darin eine Ausnahme entsteht, wird die danach gecatched
        for (int i = 0; i < 100; i++) {
            s.push(i);
        }
    }

    catch(IllegalStateException e) {
        IO.println("Error: something went wrong - " + e.getMessage());
    }


    while (!s.isEmpty()) {
        IO.println(s.pop());
    }
}