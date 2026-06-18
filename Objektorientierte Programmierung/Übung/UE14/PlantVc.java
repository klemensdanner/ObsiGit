// Plant

public class PlantVc extends BracketedLSystem {


    protected void moveForward() {
        turtle.moveForward();
    }

    protected void rotate(double alpha) {
        turtle.rotate(alpha);
    }



    public PlantVc(int nMax, double scaleMin, double scaleMax, Turtle turtle) {
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
            case 'F': return "FF-[-F+F+F]+[+F-F-F]";
            default: return String.valueOf(symbol);
        }
    }

}