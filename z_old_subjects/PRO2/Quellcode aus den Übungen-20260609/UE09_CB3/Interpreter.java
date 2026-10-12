/* Interpreter:                                               DA, 2026-04-29 */
/* -----------                                                               */
/* Parser for infix expressions, grammar:                                    */
/*                                                                           */
/*   Expr = Term { "+" Term | "-" Term } .                                   */
/*   Term = Fact { "*" Fact | "/" Fact } .                                   */
/*   Fact = number | "(" Expr ")" .                                          */
/*                                                                           */
/* ========================================================================= */

public class Interpreter {

    private final Scanner scanner;
    private final SymbolTable symbolTable;

    private void expect(Symbol expectedSy) {
        if (scanner.sy != expectedSy) {
            throw new SyntaxError(expectedSy.toString().toLowerCase() + "expected");
        }
    } // expect

    private void semanticError(String msg) {
        System.err.println("semantic error: " + msg + " in " +
                           scanner.syLnr + ", column " + scanner.syCnr);
    } // semanticError    

    public Interpreter(Scanner scanner) {
        this.scanner = scanner;
        this.symbolTable = new SymbolTable();
    }

    public void interpret() {
        IO.println("parsing started ...");
        MiniJava();
        IO.println("... parsing finished.");
    } // interpret

    public void MiniJava() {
        expect(Symbol.VOID); 
        scanner.nextSy();
        expect(Symbol.MAIN); 
        scanner.nextSy();
        expect(Symbol.OPEN_PAR); 
        scanner.nextSy();
        expect(Symbol.CLOSE_PAR); 
        scanner.nextSy();
        expect(Symbol.OPEN_BRACE); 
        scanner.nextSy();
        if (scanner.sy == Symbol.INT) {
            VarDecl();
        }
        StatSeq();
        expect(Symbol.CLOSE_BRACE); 
        scanner.nextSy();
        expect(Symbol.EOF);
    }

    private void VarDecl() {
        expect(Symbol.INT); 
        scanner.nextSy();
        expect(Symbol.IDENT); 
        /*sem*/ symbolTable.declVar((scanner.identStr)); /*endsem*/
        scanner.nextSy();
        while (scanner.sy == Symbol.COMMA) {
            scanner.nextSy();
            expect(Symbol.IDENT); 
            /*sem*/
            if (!symbolTable.declVar(scanner.identStr)) {
                semanticError("multiple declaration");
            }
            /*endsem*/
            scanner.nextSy();
        }
        expect(Symbol.SEMICOLON); 
        scanner.nextSy();
    } // VarDecl

    private void StatSeq() {
        Stat();
        while (scanner.sy == Symbol.IDENT || 
               scanner.sy == Symbol.PRINT ||
               scanner.sy == Symbol.SEMICOLON) {
            Stat();
        }
    } // StatSeq

    private void Stat() {
        if (scanner.sy == Symbol.IDENT) {
            /*sem*/
            String destId = scanner.identStr;
            boolean isDecl = symbolTable.isDecl(destId);
            if (!isDecl) {
                semanticError("variable not declared");
            }
            /*endsem*/
            scanner.nextSy();
            expect(Symbol.ASSIGN); 
            scanner.nextSy();
            int e = Expr();
            /*sem*/
            if (isDecl) {
                symbolTable.setVal(destId, e);
            }
            /*endsem*/
        } else if (scanner.sy == Symbol.PRINT) {
            scanner.nextSy();
            expect(Symbol.OPEN_PAR); 
            scanner.nextSy();
            int e = Expr();
            /*sem*/ IO.println(e); /*endsem*/
            expect(Symbol.CLOSE_PAR); 
            scanner.nextSy();            
        }
        expect(Symbol.SEMICOLON); 
        scanner.nextSy();        
    } // Stat
    
    private int Expr() {
        int e = Term();
        while (scanner.sy == Symbol.PLUS ||
               scanner.sy == Symbol.MINUS) {
            if (scanner.sy == Symbol.PLUS) {
                scanner.nextSy();
                int t = Term();
                /*sem*/ e = e + t; /*endsem*/
            } else { // scanner.sy == Symbol.MINUS
                scanner.nextSy();
                int t = Term();
                /*sem*/ e = e - t; /*endsem*/
            }
        } // while
        return e;
    } // Expr

    private int Term() {
        int t = Fact();
        while (scanner.sy == Symbol.TIMES ||
               scanner.sy == Symbol.DIV) {
            if (scanner.sy == Symbol.TIMES) {
                scanner.nextSy();
                int f = Fact();
                /*sem*/ t = t * f; /*endsem*/
            } else { // scanner.sy == Symbol.DIV
                scanner.nextSy();
                int f = Fact();
                /*sem*/ 
                t = t / f; // with f == 0 ArithmeticException will be raised 
                /*endsem*/ 
            }            
        } // while
        return t;
    } // Term

    private int Fact() {
        int f = 0;
        switch (scanner.sy) {
            case Symbol.NUMBER:
                /*sem*/ f = scanner.numberVal; /*endsem*/
                scanner.nextSy();
                break;
            case Symbol.IDENT: 
                /*sem*/
                if (!symbolTable.isDecl(scanner.identStr)) {
                    semanticError("variable not declared");
                } else {
                    f = symbolTable.getVal(scanner.identStr);
                }
                /*endsem*/
                scanner.nextSy();
                break;
            case Symbol.READ: 
                scanner.nextSy();
                expect(Symbol.OPEN_PAR); scanner.nextSy();
                /*sem*/
                IO.print(" > ");
                f = Integer.parseInt(IO.readln());
                /*endsem*/
                expect(Symbol.CLOSE_PAR); scanner.nextSy();
                break;
            case Symbol.OPEN_PAR:
                scanner.nextSy();
                f = Expr();
                if (scanner.sy != Symbol.CLOSE_PAR) {
                    throw new SyntaxError(") expected");
                }
                scanner.nextSy();
                break;
            default:
                throw new SyntaxError("number, ident, read or ( expected");
        }
        return f;
    } // Fact

}