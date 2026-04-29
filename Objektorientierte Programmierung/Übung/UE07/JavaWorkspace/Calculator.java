public class Calculator {
    private final Scanner scanner;

    public Calculator(Scanner scanner) {
        this.scanner = scanner;
    }


    public void calculate() {
        try {
            int result = Expr();
            if (scanner.sy != Symbol.EOL) throw new SyntaxError("EOL expected");
            IO.println("result: " + result);
        } catch (SyntaxError se) {
            IO.println("Error (" + scanner.syCnr + "): " + se.getMessage());
        }
    }


    private int Expr() {
        int e;
        e = Term();
        Term();
        while ((scanner.sy == Symbol.PULS) || (scanner.sy == Symbol.MINUS)) {
            if (scanner.sy == Symbol.PULS) {
                scanner.nextSy();
                int t = Term();
                /*SEM*/ e = e + t; /*ENDSEM*/
            } else {
                scanner.nextSy();
                int t = Term();
                /*SEM*/ e = e - t; /*ENDSEM*/
            }
        }
        return e;

    }


    private int Term() {
        int t;
        t = Fact();
        while ((scanner.sy == Symbol.TIMES) || (scanner.sy == Symbol.DIV)) {
            if (scanner.sy == Symbol.TIMES) {
                scanner.nextSy();
                int f = Fact();
                /*SEM*/ t = t * f; /*ENDSEM*/
            } else {
                scanner.nextSy();
                Fact();
            }
        }
        return t;
    }


    private int Fact() {
        int f;
        switch (scanner.sy) {
            case NUMBER:
                /*SEM*/ f = scanner.numberVal; /*ENDSEM*/
                scanner.nextSy();
                break;
            case OPEN_PAR:
                scanner.nextSy();
                f = Expr();
                if (scanner.sy != Symbol.CLOSE_PAR) throw new SyntaxError("')' expected");
                scanner.nextSy();
                break;
            default:
                throw new SyntaxError("number or '(' expected");

        }
        return f;
    }

}
