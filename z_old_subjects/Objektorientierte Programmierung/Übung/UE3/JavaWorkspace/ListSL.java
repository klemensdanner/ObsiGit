/* ListSL:                                                    DA, 2026-03-25 */
/* ------                                                                    */
/* singly linked list                                                        */
/* ========================================================================= */



public class ListSL {
    
    private static class Node { // ohne Static hat jeder Knoten eine Referenz auf die äußere Klasse
                                 // - kann also auf private Variablen der äußeren Klasse zugreifen.
        private String value;
        private Node next;
        
        public Node(String value) {
            assert value != null;
            this.value = value;
            this.next = null;
        }
        
    }

    private Node first;

    public ListSL() {
        first = null;
    }

    public void addFirst(String s) {
        Node n = new Node(s);
        n.next = first;
        first = n;
    }

    public void addLast(String s) {
        if (first == null) {
            first = new Node(s);
        } else {
            Node n = first;
            while (n.next != null) {
                n = n.next;
            }
            n.next = new Node(s);
        }
    }

    public int size() {
        Node n = first;
        int count = 0;
        while (n != null) {
            n = n.next;
            count++;
        }
        return count;
    }

    public boolean contains(String s) {
        Node n = first;
        while (n != null) {
            if (n.value.equals(s)) { // s.equals(n.value) würde auch gehen. Falls aber s null ist, führt das zu einer Exeption
                                     // 
                return true;
            }
            n = n.next;
        }
        return false;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        Node n = first;
        while (n != null) {
            sb.append("'").append(n.value).append("' ");
            n = n.next;
        }
        return sb.toString();
    }
}
