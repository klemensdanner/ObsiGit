// Schneeflockenkurve

public class KochCurve extends LSystem {


    protected void moveForward() {
        turtle.moveForward();
    }

    protected void rotate(double alpha) {
        turtle.rotate(alpha);
    }



    public KochCurve(int nMax, double scaleMin, double scaleMax, Turtle turtle) {
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
            case 'F': return "F+F--F+F";
            default: return String.valueOf(symbol);
        }
    }
}