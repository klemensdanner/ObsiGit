/* HashTable OA:                                              DA, 2026-05-20 */
/* ------                                                                    */
/* Simple hash table which uses open addressing for collission handling.     */
/* ========================================================================= */


public class HashTableOA {
    private static final int HT_SIZE = 7; // Größe als Primzahl wählen um Kollissionen zu vermeiden
    private static final String DEL_KEY = "***deleted***";

    private String[] ht = null;
    private int size;



    public HashTableOA() {
        ht = new String[HT_SIZE];
        size = 0;
    }

    private int indexOf(String key) {
        int i = HashFunctions.hashCode1(key) % ht.length;
        return (i >= 0) ? i : i + ht.length;
    }


    public boolean add(String key) {
        int h = indexOf(key);
        int i = h;
        int j = 0; // count collissions
        int delPos = -1;
        while ((ht[i] != null) && (j < ht.length)) {
            if (ht[i].equals(key)) return false;
            if ((delPos == -1) && (ht[i].equals(DEL_KEY))) delPos = i; 
            j++;
            i = (i + j) % ht.length;
        }
        if ((ht[i] == null) || (delPos != -1)) {
            i = (delPos != -1) ? delPos : i;
            ht[i] = key;
            size++;
            return true;
        }

        return false;
    }


    public boolean contains(String key) {
        int h = indexOf(key);
        int i = h;
        int j = 0; // count collissions
        while (j < ht.length) {
            if (ht[i] == null) return false;
            if (ht[i].equals(key)) return true;
            j++;
            i = (i + j) % ht.length;
        }
        return false;
    }


    public boolean remove(String key) {
        int h = indexOf(key);
        int i = h;
        int j = 0; // count collissions
        while (j < ht.length) {
            if (ht[i] == null) return false;
            if (ht[i].equals(key)) {
                ht[i] = DEL_KEY;
                size--;
                return true;
            }
            j++;
            i = (i + j) % ht.length;
        }
        return false;
    }

    public int size() {
        return size;
    }


    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("HashTable (open addressing):\n");
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