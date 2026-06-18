// Schneeflockenkurve

public class SierpinskiV2 extends LSystem {


    protected void moveForward() {
        turtle.moveForward();
    }

    protected void rotate(double alpha) {
        turtle.rotate(alpha);
    }



    public SierpinskiV2(int nMax, double scaleMin, double scaleMax, Turtle turtle) {
        super(nMax, scaleMin, scaleMax, turtle);
    }


    public String start() {
        return "F";
    }

    public double angle() {
        return 120;
    }

    public String rewrite(char symbol) {
        switch (symbol) {
            case 'F': return "F-G+F+G-F";
            case 'G': return "GG";
            default: return String.valueOf(symbol);
        }
    }

    @Override
    protected void interpret(char symbol) {
        if (symbol == 'G') {
            moveForward();
        } else {
            super.interpret(symbol);
        }
    }
}