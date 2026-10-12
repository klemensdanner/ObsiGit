/* SyntaxError:                                               DA, 2026-04-29 */
/* ------                                                                    */
/* class to indicate errors                                                               */
/* ========================================================================= */



public class SyntaxError extends Error {
    public SyntaxError() { }

    public SyntaxError(String expected) {
        super(expected);
    }
    
}
