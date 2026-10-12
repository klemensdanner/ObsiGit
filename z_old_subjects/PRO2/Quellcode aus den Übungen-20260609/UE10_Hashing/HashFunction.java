public class HashFunction {

    public static int hashCode(String key) {
        return hashCode4(key);
    }

    public static int hashCode1(String key) {
        return (int)key.charAt(0);
    }

    public static int hashCode2(String key) {
        return (int)key.charAt(0) + key.length();
    }    

    public static int hashCode3(String key) {
        if (key.length() == 1) {
            return ((int)key.charAt(0) * 7 + 1) * 17;            
        } else {
           return ((int)key.charAt(0) * 7 + 
               (int)key.charAt(1) + key.length()); 
        }
    }      

    public static int hashCode4(String key) {
        int h = 0;
        int n = key.length();
        for (int i = 0; i < n; i++) {
            h = 31 * h + (int)key.charAt(i);
        }
        return h;
    } 

}