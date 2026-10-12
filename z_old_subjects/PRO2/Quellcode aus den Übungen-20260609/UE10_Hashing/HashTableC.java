/* HashTableC:                                                DA, 2026-05-20 */
/* ------                                                                    */
/* Hash table is implemented using the chaining strategy.                    */
/* ========================================================================= */

public class HashTableC {

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
                sb.append(" '");
                sb.append(n.key);
                sb.append("'");
                n = n.next;
            } while (n != null);
            return sb.toString();
        }
    }

    private static final int HT_SIZE = 7; // should be a prime

    private Node[] ht = null;
    private int size;
    private HashStatistic stat;

    public HashTableC() {
        ht = new Node[HT_SIZE];
        size = 0;
        stat = new HashStatistic();
    }

    private int indexOf(int hc) {
        hc = hc % ht.length;
        return (hc >= 0) ? hc : (hc + ht.length);
    }

    public boolean add(String key) {
        int i = indexOf(HashFunction.hashCode(key));
        Node n = ht[i];
        while (n != null) {
            if (key.equals(n.key)) { return false; }
            stat.incCollisions();
            n = n.next;
        }
        ht[i] = new Node(key, ht[i]);
        size++;
        return true;
    }
    
    public boolean contains(String key) {
        int i = indexOf(HashFunction.hashCode(key));
        Node n = ht[i];
        while (n != null) {
            if (key.equals(n.key)) { return true; }
            n = n.next;
        }
        return false;
    }

    public boolean remove(String key) {
        int i = indexOf(HashFunction.hashCode(key));
        Node n = ht[i];
        Node prev = null;
        while (n != null) {
            if (key.equals(n.key)) {
                if (prev == null) {
                    ht[i] = n.next;
                } else {
                    prev.next = n.next;
                }
                size--;
                return true;
            }
            prev = n;
            n = n.next;
        }
        return false; // key not found
    }

    public int size() {
        return size;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Hashtable (chaining)\n");
        for (int i = 0; i < ht.length; i++) {
            if (ht[i] != null) {
                sb.append(i + ":\t");
                sb.append(ht[i].toString());
                sb.append("\n");    
            }
        }
        sb.append("\nSize = " + size + "\n");
        sb.append(stat.toString());
        return sb.toString();
    }

}
