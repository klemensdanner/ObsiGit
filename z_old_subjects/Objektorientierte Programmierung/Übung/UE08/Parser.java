/* Parser:                                                   SWa, 2026-04-29 */
/* -------                                                                   */
/* Parser for MiniJava.                                                      */
/* ========================================================================= */
public class Parser {
    private final Scanner scanner;

    public Parser(Scanner scanner) {
        this.scanner = scanner;
    }


    private void expect(Symbol expectedSy) {
        if (scanner.sy != expectedSy) {
            throw new SyntaxError(expectedSy.toString().toLowerCase() + " expected");
        }
    }


    public void parse() {
        IO.println("parsing started ...");
        MiniJava();
        IO.println("parsing completed :-)");
    }


    private void MiniJava() {
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
        scanner.nextSy();
        while (scanner.sy == Symbol.COMMA) {
            scanner.nextSy();
            expect(Symbol.IDENT);
            scanner.nextSy();
        }
        expect(Symbol.SEMICOLON);
        scanner.nextSy();
    }

    private void StatSeq() {
        Stat();
        while (scanner.sy == Symbol.IDENT ||
               scanner.sy == Symbol.PRINT ||
               scanner.sy == Symbol.SEMICOLON) {
            Stat();
        }
    }


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
    }






    private void Expr() {
        Term();
        while ((scanner.sy == Symbol.PLUS) || (scanner.sy == Symbol.MINUS)) {
            if (scanner.sy == Symbol.PLUS) {
                scanner.nextSy();
                Term();
            } else {
                scanner.nextSy();
                Term();
            }
        }
    }

    private void Term() {
        Fact();
        while ((scanner.sy == Symbol.TIMES) || (scanner.sy == Symbol.DIV)) {
            if (scanner.sy == Symbol.TIMES) {
                scanner.nextSy();
                Fact();
            } else {
                scanner.nextSy();
                Fact();
            }
        }
    }

    private void Fact() {
        switch (scanner.sy) {
            case NUMBER:
                scanner.nextSy();
                break;
            case IDENT:
                scanner.nextSy();
                break;
            case READ:
                scanner.nextSy();
                expect(Symbol.OPEN_PAR);
                scanner.nextSy();
                expect(Symbol.CLOSE_PAR);
                scanner.nextSy();
                break;
            case OPEN_PAR:
                scanner.nextSy();
                Expr();
                if (scanner.sy != Symbol.CLOSE_PAR) throw new SyntaxError("')' expected");
                scanner.nextSy();
                break;
            default:
                throw new SyntaxError("number, ident, read expected");
        }
    }
}