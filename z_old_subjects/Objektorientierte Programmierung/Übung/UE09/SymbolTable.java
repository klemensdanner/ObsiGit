/* SymbolTable:                                               HDO, 2025-03-11
   -----------
  Symbol table for interpreter and compiler for MiniJava.
============================================================================*/

public class SymbolTable {

  private static final int MAX_SYMBOLS = 20;

  private static class VarInfo {

    public String ident;
    public int    val;   // for interpreter only
    public int    addr;  // for compiler    only

    VarInfo(String ident, int val, int addr) {
      this.ident = ident;
      this.val   = val;
      this.addr  = addr;
    } // VarInfo

  } // VarInfo

  private final VarInfo[] st = new VarInfo[MAX_SYMBOLS];
  private int n = 0; // number of entries in st

  private VarInfo varInfoFor(String ident) { // returns null for unknown ident
    int i = 0;
    while ( (i < n) && !ident.equals(st[i].ident) )
      i++;
    return (i < n) ? st[i] : null;
  } // varInfoFor

  public SymbolTable() {
    // nothing to do
  } // SymbolTable

  public boolean declVar(String ident) {
    if (varInfoFor(ident) == null) { // new ident
      st[n] = new VarInfo(ident, 0, n);
      n++;
      return true;  // declaration done
    } else // ident already declared
      return false;
  } // declVar

  public boolean isDecl(String ident) {
    return varInfoFor(ident) != null;
  } // isDecl

  public void setVal(String ident, int val) {
    varInfoFor(ident).val = val;
  } // setVal

  public int getVal(String ident) {
   return varInfoFor(ident).val;
  } // getVal

   public int addrOf(String ident) {
    return varInfoFor(ident).addr;
   } // addrOf

} // SymbolTable
