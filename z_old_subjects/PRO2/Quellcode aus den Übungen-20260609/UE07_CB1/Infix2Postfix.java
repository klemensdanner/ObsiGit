/* InfixParser:                                               DA, 2026-04-29 */
/* -----------                                                               */
/* Parser for infix expressions converted to postfix, grammar:               */
/*                                                                           */
/*   Expr = Term { "+" Term | "-" Term } .                                   */
/*   Term = Fact { "*" Fact | "/" Fact } .                                   */
/*   Fact = number | "(" Expr ")" .                                          */
/*                                                                           */
/* For attributes and semantic actions check slide 4 in pdf file             */
/* "Arithmetische Ausdrücke (V1).pdf"                                        */
/* ========================================================================= */

public class Infix2Postfix {

    private final Scanner scanner;

    public Infix2Postfix(Scanner scanner) {
        this.scanner = scanner;
    }

    public void convert() {
        try {
            Expr();
            if (scanner.sy != Symbol.EOL) {
                throw new SyntaxError("EOL expected");
            }
            IO.println("\n expression's conversion is correct");
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
                /* SEM */ IO.print("+ "); /* SEM */
            } else { // scanner.sy == Symbol.MINUS
                scanner.nextSy();
                Term();
                /* SEM */ IO.print("- "); /* SEM */
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
                /* SEM */ IO.print("* "); /* SEM */
            } else { // scanner.sy == Symbol.DIV
                scanner.nextSy();
                Fact();
                /* SEM */ IO.print("/ "); /* SEM */                
            }            
        } // while
    } // Term

    private void Fact() {
        switch (scanner.sy) {
            case NUMBER:
                /* SEM */ IO.print(scanner.numberVal + " "); /* SEM */
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
