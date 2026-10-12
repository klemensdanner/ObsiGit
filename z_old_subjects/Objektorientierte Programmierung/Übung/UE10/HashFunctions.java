/* HashFunctions:                                             DA, 2026-05-20 */
/* ------                                                                    */
/* different hash functions for strings                                      */
/* ========================================================================= */

public class HashFunctions {
    public static int hashCode1(String key) {
        return (int)key.charAt(0);
    }
    

    public static int hashCode2(String key) {
        return (int)key.charAt(0) + key.length();
    }


    public static int hashCode3(String key) {
        if (key.length() == 1) {
            return ((int)key.charAt(0) * 7 + 1) * 17; // +1: Länge
        } else {
            return ((int)key.charAt(0) * 7 + (int)key.charAt(1) + key.length()) * 17;
        }
        
    }

    public static int hashCode4(String key) {
        int h = 0;
        int n = key.length();

        for (int i = 0; i < n; i++) {
            h = 31 * h + (int)key.charAt(i); // kann evtl. negativ werden, wenn der integer positivbereich überschritten wird
        }
        key.hashCode();

        return h;
    }




}