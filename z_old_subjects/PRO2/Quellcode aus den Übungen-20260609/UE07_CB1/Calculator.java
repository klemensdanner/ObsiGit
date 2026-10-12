/* Calculator:                                                DA, 2026-04-29 */
/* -----------                                                               */
/* Parser for calculator, grammar:                                           */
/*                                                                           */
/*   Expr = Term { "+" Term | "-" Term } .                                   */
/*   Term = Fact { "*" Fact | "/" Fact } .                                   */
/*   Fact = number | "(" Expr ")" .                                          */
/*                                                                           */
/* For attributes and semantic actions check slide 5 in pdf file             */
/* "Arithmetische Ausdrücke (V1).pdf"                                        */
/* ========================================================================= */

public class Calculator {

    private final Scanner scanner;

    public Calculator(Scanner scanner) {
        this.scanner = scanner;
    }

    public void calculate() {
        try {
            int e = Expr();
            if (scanner.sy != Symbol.EOL) {
                throw new SyntaxError("EOL expected");
            }
            IO.println("result = " + e);
        } catch (SyntaxError se) {
            IO.print("syntax error in column " + scanner.syCnr);
            if (se.getMessage() != null) {
                IO.print(": " + se.getMessage());
            }
            IO.println();
        }
    }
    
    private int Expr() {
        int e = Term();
        while (scanner.sy == Symbol.PLUS ||
               scanner.sy == Symbol.MINUS) {
            if (scanner.sy == Symbol.PLUS) {
                scanner.nextSy();
                int t = Term();
                /*SEM*/ e = e + t; /*SEM*/
            } else { // scanner.sy == Symbol.MINUS
                scanner.nextSy();
                int t = Term();
                /*SEM*/ e = e - t; /*SEM*/
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
                /*SEM*/ t = t * f; /*SEM*/
            } else { // scanner.sy == Symbol.DIV
                scanner.nextSy();
                int f = Fact();
                /*SEM*/ t = t / f;   // we ignore division by 0 /*SEM*/
            }            
        } // while
        return t;
    } // Term

    private int Fact() {
        int f;
        switch (scanner.sy) {
            case NUMBER:
                /*SEM*/ f = scanner.numberVal; /*SEM*/
                scanner.nextSy();
                break;
            case OPEN_PAR:
                scanner.nextSy();
                f = Expr();
                if (scanner.sy != Symbol.CLOSE_PAR) {
                    throw new SyntaxError(") expected");
                }
                scanner.nextSy();
                break;
            default:
                throw new SyntaxError("number or ( expected");
        }
        return f;
    } // Fact

}
