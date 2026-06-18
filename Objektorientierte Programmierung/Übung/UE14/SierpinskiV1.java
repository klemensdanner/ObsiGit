// Schneeflockenkurve

public class SierpinskiV1 extends LSystem {


    protected void moveForward() {
        turtle.moveForward();
    }

    protected void rotate(double alpha) {
        turtle.rotate(alpha);
    }



    public SierpinskiV1(int nMax, double scaleMin, double scaleMax, Turtle turtle) {
        super(nMax, scaleMin, scaleMax, turtle);
    }


    public String start() {
        return "F";
    }

    public double angle() {
        return 60;
    }

    public String rewrite(char symbol) {
        switch (symbol) {
            case 'F': return "G+F+G";
            case 'G': return "F-G-F";
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