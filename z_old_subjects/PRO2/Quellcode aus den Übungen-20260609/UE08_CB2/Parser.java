/* Parser:                                                    DA, 2026-04-29 */
/* -----------                                                               */
/* Parser for infix expressions, grammar:                                    */
/*                                                                           */
/*   Expr = Term { "+" Term | "-" Term } .                                   */
/*   Term = Fact { "*" Fact | "/" Fact } .                                   */
/*   Fact = number | "(" Expr ")" .                                          */
/*                                                                           */
/* ========================================================================= */

public class Parser {

    private final Scanner scanner;

    private void expect(Symbol expectedSy) {
        if (scanner.sy != expectedSy) {
            throw new SyntaxError(expectedSy.toString().toLowerCase() + "expected");
        }
    } // expect

    public Parser(Scanner scanner) {
        this.scanner = scanner;
    }

    public void parse() {
        IO.println("parsing started ...");
        MiniJava();
        IO.println("... parsing finished.");
    } // parse

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
    } // MiniJava

    private void VarDecl() {
        expect(Symbol.INT); 
        scanner.nextSy();
        expect(Symbol.IDENT); 
        scanner.nextSy();
        while (scanner.sy == Symbol.COMMA) {
            scanner.nextSy();
            expect(Symbol.IDENT); 
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
            scanner.nextSy();
            expect(Symbol.ASSIGN); 
            scanner.nextSy();
            Expr();
        } else if (scanner.sy == Symbol.PRINT) {
            scanner.nextSy();
            expect(Symbol.OPEN_PAR); 
            scanner.nextSy();
            Expr();
            expect(Symbol.CLOSE_PAR); 
            scanner.nextSy();            
        }
        expect(Symbol.SEMICOLON); 
        scanner.nextSy();        
    } // Stat
    
    private void Expr() {
        Term();
        while (scanner.sy == Symbol.PLUS ||
               scanner.sy == Symbol.MINUS) {
            if (scanner.sy == Symbol.PLUS) {
                scanner.nextSy();
                Term();
            } else { // scanner.sy == Symbol.MINUS
                scanner.nextSy();
                Term();
            }
        } // while
    } // Expr

    private void Term() {
        Fact();
        while (scanner.sy == Symbol.TIMES ||
               scanner.sy == Symbol.DIV) {
            if (scanner.sy == Symbol.TIMES) {
                scanner.nextSy();
                Fact();
            } else { // scanner.sy == Symbol.DIV
                scanner.nextSy();
                Fact();
            }            
        } // while
    } // Term

    private void Fact() {
        switch (scanner.sy) {
            case Symbol.NUMBER:
                scanner.nextSy();
                break;
            case Symbol.IDENT: 
                scanner.nextSy();
                break;
            case Symbol.READ: 
                scanner.nextSy();
                expect(Symbol.OPEN_PAR); 
                scanner.nextSy();
                expect(Symbol.CLOSE_PAR); 
                scanner.nextSy();
                break;
            case Symbol.OPEN_PAR:
                scanner.nextSy();
                Expr();
                expect(Symbol.CLOSE_PAR);
                scanner.nextSy();
                break;
            default:
                throw new SyntaxError("number, ident, read or ( expected");
        }
    } // Fact
}