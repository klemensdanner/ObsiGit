public class HuffmanEncoding {
    
    private static class TreeNode {
        public char character;
        public int frequency;
        public TreeNode left;
        public TreeNode right;

        public TreeNode(char character, int frequency,
                        TreeNode left, TreeNode right) {
            assert frequency > 0;
            this.character = character;
            this.frequency = frequency;
            this.left = left;
            this.right = right;
        }

        public TreeNode(char character, int frequency) { 
            this(character, frequency, null, null);
        }       
    }


    private static TreeNode createEncoding(int[] freq) {
        ObjPriorityQueue queue = new ObjPriorityQueue();

        for (int i = 0; i < freq.length; i++) {
            if (freq[i] > 0) {
                queue.insert(-freq[i], new TreeNode((char)i, freq[i]));
            }
        }

        // build Huffman tree
        while (queue.size() > 1) {
            TreeNode right = (TreeNode)queue.removeMax();
            TreeNode left = (TreeNode)queue.removeMax();
            TreeNode parent = new TreeNode((char)0, 
                                    left.frequency + right.frequency, 
                                    left, right);
            queue.insert(-parent.frequency, parent);
        }

        return (TreeNode)queue.removeMax();
    }

    // print code
    private static void printCode(TreeNode n) {
        printCode(n, "");
    }

    private static void printCode(TreeNode n, String prefix) {
        if (n == null) return;
        if (n.left == null && n.right == null) {  // leaf found
            IO.println(String.format("%c freq: %3d code: %s",
                n.character, n.frequency, prefix));
        }
        printCode(n.left, prefix + "0");
        printCode(n.right, prefix + "1");
    }

    /* ------------------------ */
    /* Testing Huffman Encoding */
    /* ------------------------ */    
    void main() {
        IO.println("Test Huffman Encoding");
        IO.println("---------------------");
        IO.println();
        IO.print("Test 1: ");
        testHuffman("this is an example of a huffman tree");
        IO.println();
        IO.print("Test 2: ");
        testHuffman("Franz jagt im komplett verwahrlosten Taxi quer durch Bayern"); // https://de.wikipedia.org/wiki/Pangramm
        IO.println();
        IO.print("Test 3: ");
        testHuffman("Wenn das kein Test sein soll, was ist des dann?");                
    }

    private static void testHuffman(String input) {
        IO.println(String.format("input: '%s'", input));

        int[] freqArray = createFrequencyArray(input);

        printCode(HuffmanEncoding.createEncoding(freqArray));
    }

    private static int[] createFrequencyArray(String input) {
        int[] freq = new int[256];  // 256 includes all relevant chars
        for (int i = 0; i < input.length(); i++) {
            freq[input.charAt(i)] += 1;
        }
        return freq;
    }

}