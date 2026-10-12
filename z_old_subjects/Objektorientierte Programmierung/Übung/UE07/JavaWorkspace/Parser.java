public class Parser {
    private final Scanner scanner;

    public Parser(Scanner scanner) {
        this.scanner = scanner;
    }


    public void parse() {
        try {
            Expr();
            if (scanner.sy != Symbol.EOL) throw new SyntaxError("EOL expected");
            IO.println("parsing completed");
        } catch (SyntaxError se) {
            IO.println("Error (" + scanner.syCnr + "): " + se.getMessage());
        }
    }


    private void Expr() {
        Term();
        while ((scanner.sy == Symbol.PULS) || (scanner.sy == Symbol.MINUS)) {
            if (scanner.sy == Symbol.PULS) {
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
            case OPEN_PAR:
                scanner.nextSy();
                Expr();
                if (scanner.sy != Symbol.CLOSE_PAR) throw new SyntaxError("')' expected");
                scanner.nextSy();
                break;
            default:
                throw new SyntaxError("number or '(' expected");

        }
    }

}
