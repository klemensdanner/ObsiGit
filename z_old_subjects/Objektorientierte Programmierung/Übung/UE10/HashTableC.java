/* HashTable C:                                               DA, 2026-05-20 */
/* ------                                                                    */
/* Simple hash table which uses chaining for collission handling.            */
/* ========================================================================= */



public class HashTableC {
    private static final int HT_SIZE = 7; // Größe als Primzahl wählen um Kollissionen zu vermeiden


    private static class Node {
        private String key;
        private Node next;

        public Node(String key, Node next) {
            this.key = key;
            this.next = next;
        }

        @Override
        public String toString() {
            StringBuilder sb = new StringBuilder();
            Node n = this;
            do {
                sb.append(" '")
                    .append(n.key)
                    .append("'");
                n = n.next;

            } while (n != null);

            return sb.toString();
        }

    }

    private Node[] ht = null;
    private int size;

    public HashTableC() {
        ht = new Node[HT_SIZE];
        size = 0;
    }

    private int indexOf(String key) {
        int i = HashFunctions.hashCode1(key) % ht.length;
        return (i >= 0) ? i : i + ht.length;
    }


    public boolean add(String key) {
        int i = indexOf(key);
        Node n = ht[i];
        while (n != null) {
            if (n.key.equals(key)) return false;
            n = n.next;
        }
        ht[i] = new Node(key, ht[i]);
        size++;
        return true;
    }


    public boolean contains(String key) {
        int i = indexOf(key);
        Node n = ht[i];
        while (n != null) {
            if (n.key.equals(key)) return true;
            n = n.next;
        }
        return false;
    }


    public boolean remove(String key) {
        int i = indexOf(key);
        Node n = ht[i];
        Node prev = null;
        while (n != null) {
            if (n.key.equals(key)) {
                // Fall 1: Kopf der Liste entfernen
                if (prev == null) {
                    ht[i] = n.next;
                } else { // Fall 2: Knoten in der Mitte der Liste entfernen
                    prev.next = n.next;
                }
                
                size--;
                return true;
            }
            prev = n;
            n = n.next;
        }
        return false;
    }

    public int size() {
        return size;
    }


    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("HashTable (chaining):\n");
        for (int i = 0; i < ht.length; i++) {
            if (ht[i] != null) {
                sb.append(i)
                    .append(": ")
                    .append(ht[i])
                    .append("\n");
            }
        }
        return sb.toString();           
    }





}