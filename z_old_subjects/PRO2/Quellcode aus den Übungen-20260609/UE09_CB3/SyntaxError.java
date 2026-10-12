/* SyntaxError:                                              HDO, 2025-03-11
   -----------
  Type to report syntax errors during recursive descent parsing.
  Error as base class is used, so neither "throws SyntaxError" for the
  recognition methods nor try blocks are necessary.
============================================================================*/

public class SyntaxError extends Error {

  public SyntaxError() { // simple version without expected symbol(s)}
    // nothing to do
  } // SyntaxError

  public SyntaxError(String expected) { // version with expected symbol(s)
    super(expected);
  } // SyntaxError

} // SyntaxError