// Plant

public class Plant extends BracketedLSystem {


    protected void moveForward() {
        turtle.moveForward();
    }

    protected void rotate(double alpha) {
        turtle.rotate(alpha);
    }



    public Plant(int nMax, double scaleMin, double scaleMax, Turtle turtle) {
        super(nMax, scaleMin, scaleMax, turtle);
    }


    public String start() {
        return "-X";
    }

    public double angle() {
        return 25;
    }

    public String rewrite(char symbol) {
        switch (symbol) {
            case 'X': return "F+[[X]-X]-F[-FX]+X";
            case 'F': return "FF";
            default: return String.valueOf(symbol);
        }
    }

    @Override
    protected void interpret(char symbol) {
        if (symbol == 'X') { // ignore x
        } else {
            super.interpret(symbol);
        }
    }
}