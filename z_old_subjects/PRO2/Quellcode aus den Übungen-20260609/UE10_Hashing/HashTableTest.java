/* HashTableTest:                                             DA, 2025-02-07 */
/* ------                                                                    */
/* Test class with class functions to test the hash functions as well as     */
/* the two hash table implementations (open addressing and chaining).        */
/* ========================================================================= */
public class HashTableTest {

    void main() {
        //hashFunction();
        //hashTableC();
        hashTableOA();
    }

    private static void hashFunction() {
        String s = "Muehlviertel"; 
        IO.println("s.length() = " + s.length());
        int n = s.length();
        IO.println("n = " + n);
        IO.println("0: " + HashFunction.hashCode(s) % n);
        IO.println("1: " + HashFunction.hashCode1(s) % n);
        IO.println("2: " + HashFunction.hashCode2(s) % n);
        IO.println("3: " + HashFunction.hashCode3(s) % n);
        IO.println("4: " + HashFunction.hashCode4(s) % n);                
    } // hashFunction

    private static void hashTableC() {
        HashTableC hashTable = new HashTableC();
        boolean result;
        IO.println("Test: Hashtable with chaining");
        IO.println("-----------------------------");        
        IO.println("Commands: a(dd), c(ontains), r(emove)), p(rint), e(xit)");
        char cmd = 'e';
        do {
            IO.print("enter command > ");
            cmd = IO.readln().charAt(0);
            String key;               
            switch (cmd) {
                case 'a': // add
                    IO.print("enter key > ");
                    key = IO.readln();                
                    result = hashTable.add(key);
                    IO.println(result ? "done" : "key already in hashtable or hash table overflow");
                    break;
                case 'c': // contains
                    IO.print("enter key > ");
                    key = IO.readln();                   
                    result = hashTable.contains(key);
                    IO.println(result ? "found" : "key not found");
                    break;
                case 'r': // remove
                    IO.print("enter key > ");
                    key = IO.readln();                   
                    result = hashTable.remove(key);
                    IO.println(result ? "removed" : "key not found");
                    break;
                case 'p': // print
                    IO.println(hashTable.toString());
                    break;
                case 'e': // exit
                    IO.println("Good bye");
                    break;                    
                default:
                    IO.println("error: unknown command");
            }      
        } while (cmd != 'e'); 
    } 

    private static void hashTableOA() {
        HashTableOA hashTable = new HashTableOA();
        boolean result;
        IO.println("Test: Hashtable with open addressing");
        IO.println("------------------------------------");        
        IO.println("Commands: a(dd), c(ontains), r(emove)), p(rint), e(xit)");
        char cmd = 'e';
        do {
            IO.print("enter command > ");
            cmd = IO.readln().charAt(0);
            String key;               
            switch (cmd) {
                case 'a': // add
                    IO.print("enter key > ");
                    key = IO.readln();                
                    result = hashTable.add(key);
                    IO.println(result ? "done" : "key already in hashtable or hash table overflow");
                    break;
                case 'c': // contains
                    IO.print("enter key > ");
                    key = IO.readln();                   
                    result = hashTable.contains(key);
                    IO.println(result ? "found" : "key not found");
                    break;
                case 'r': // remove
                    IO.print("enter key > ");
                    key = IO.readln();                   
                    result = hashTable.remove(key);
                    IO.println(result ? "removed" : "key not found");
                    break;
                case 'p': // print
                    IO.println(hashTable.toString());
                    break;
                case 'e': // exit
                    IO.println("Good bye");
                    break;                    
                default:
                    IO.println("error: unknown command");
            }      
        } while (cmd != 'e'); 
    } 
    
}