public class SyntaxError extends Error {
    
    public SyntaxError() {
        // do nothing
    }

    public SyntaxError(String expected) { // version with expected symbol(s)
        super(expected);
    }
}