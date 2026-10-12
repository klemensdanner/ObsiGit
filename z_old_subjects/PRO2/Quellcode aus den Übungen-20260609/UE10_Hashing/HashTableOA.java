/* HashTableOA:                                               DA, 2026-05-20 */
/* ------                                                                    */
/* Hash table based on the open addressing strategy.                         */
/* Extensions for the probing strategies which we just discussed, but not    */
/* implemented in the course are marked with "*ext-probing*" in the code     */
/* ========================================================================= */

public class HashTableOA {

    private static final int HT_SIZE = 7;
    private static final String DEL_KEY = "**deleted_key**";

    private String[] ht = null;
    private int size;
    private int probingStrategy; // *ext-probing*: see constructor and nextProbeIndex
    private HashStatistic stat;

    public HashTableOA() {
        ht = new String[HT_SIZE];
        size = 0;
        probingStrategy = 1; // *ext-probing* // set the probing strategy see nextProbeIndex
        stat = new HashStatistic();
    }

    private int indexOf(int hc) {
        hc = hc % ht.length;
        return (hc >= 0) ? hc : (hc + ht.length);
    }

    // *ext-probing*
    // provide the next probing index according to the selected probing strategy
    private int nextProbeIndex(int h, int h2, int j) {
        final int c = 3; // step size for strategy 2, no common divisor with lenght of hashtable

        switch (probingStrategy) {
            case 1: // linear probing
                return indexOf(h + j);
            case 2: // linear probing improved - step size c 
                return indexOf(h + c * j);
            case 3: // quadratic probing
                return indexOf(h + j * j);
            case 4: // double hashing
                return indexOf(h + j * h2);
            default:
                System.out.println("error: unknown command");
                return indexOf(h + j);
        }
    }    

    public boolean add(String key) {
        int h = indexOf(HashFunction.hashCode(key));
        int h2 = indexOf(HashFunction.hashCode3(key));  // *ext-probing*

        int i = h;
        int j = 0; // number of search steps
        int delPos = -1;
        while ((j < ht.length) && (ht[i] != null)) {
            if (ht[i].equals(key)) { return false; }
            if ((delPos == -1) && ht[i].equals(DEL_KEY)) { delPos = i; }
            j++;  // single steps
            stat.incCollisions();
            // i = indexOf(h + j);        // *ext-probing*
           i = nextProbeIndex(h, h2, j);  // *ext-probing*
             
        }
        if ((ht[i] == null) || (delPos != -1)) {
            i = (delPos != -1) ? delPos : i; // reuse index of deleted element if available
            ht[i] = key;
            size++;
            return true; // key added to ht
        }
        return false; // // hash table is full - can't add key
    }

    public boolean contains(String key) {
        int h = indexOf(HashFunction.hashCode(key));
        int h2 = indexOf(HashFunction.hashCode3(key));  // *ext-probing*

        int i = h;
        int j = 0; // number of search steps
        while (j < ht.length) {
            if (ht[i] == null) { return false; }
            if (ht[i].equals(key)) { return true; }
            j++;  // single steps
            // i = indexOf(h + j);        // *ext-probing*
           i = nextProbeIndex(h, h2, j);  // *ext-probing*
        }
        return false; // key not found
    }

    /*
     * remove
     * as open addressing demands that there are no gaps in the sequences of 
     * finding the index of a certain key, a key cannot be just removed from 
     * the hashtable. Its index must be marked. We use the special final
     * String DEL_KEY for this purpose.
     */
    public boolean remove(String key) {
        int h = indexOf(HashFunction.hashCode(key));
        int h2 = indexOf(HashFunction.hashCode3(key)); // *ext-probing*
        
        int i = h;
        int j = 0;
        while ((j < ht.length)) {
            if (ht[i] == null) return false; // key not found
            if (ht[i].equals(key)) {
                ht[i] = DEL_KEY;
                size--;
                return true; // key found and removed
            }
            j++;
            // i = indexOf(h + j);        // *ext-probing*
           i = nextProbeIndex(h, h2, j);  // *ext-probing*
        }
        return false; //  key not found
    }    

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Hashtable (open addressing)\n");
        for (int i = 0; i < ht.length; i++) {
            if (ht[i] != null) {
                sb.append(i + ":\t");
                sb.append(ht[i]);
                sb.append("\n");    
            }
        }
        sb.append("\nSize = " + size + "\n");
        sb.append(stat.toString());
        return sb.toString();
    }

}