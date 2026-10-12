/* InfixParser:                                               DA, 2026-04-29 */
/* -----------                                                               */
/* Parser for infix expressions, grammar:                                    */
/*                                                                           */
/*   Expr = Term { "+" Term | "-" Term } .                                   */
/*   Term = Fact { "*" Fact | "/" Fact } .                                   */
/*   Fact = number | "(" Expr ")" .                                          */
/*                                                                           */
/* ========================================================================= */

public class InfixParser {

    private final Scanner scanner;

    public InfixParser(Scanner scanner) {
        this.scanner = scanner;
    }

    public void parse() {
        try {
            Expr();
            if (scanner.sy != Symbol.EOL) {
                throw new SyntaxError("EOL expected");
            }
            IO.println("expression's syntax is correct");
        } catch (SyntaxError se) {
            IO.print("syntax error in column " + scanner.syCnr);
            if (se.getMessage() != null) {
                IO.print(": " + se.getMessage());
            }
            IO.println();
        }
    }
    
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
            case NUMBER:
                scanner.nextSy();
                break;
            case OPEN_PAR:
                scanner.nextSy();
                Expr();
                if (scanner.sy != Symbol.CLOSE_PAR) {
                    throw new SyntaxError(") expected");
                }
                scanner.nextSy();
                break;
            default:
                throw new SyntaxError("number or ( expected");
        }
    } // Fact

}
