// abstract base class for Lindenmayer systems


public abstract class LSystem {
    protected double scaleMin;
    protected double scaleMax;
    protected int nMax;
    protected Turtle turtle;

    protected void moveForward() {
        turtle.moveForward();
    }

    protected void rotate(double alpha) {
        turtle.rotate(alpha);
    }



    public LSystem(int nMax, double scaleMin, double scaleMax, Turtle turtle) {
        this.nMax = nMax;
        this.scaleMin = scaleMin;
        this.scaleMax = scaleMax;
        this.turtle = turtle;
    }


    public abstract String start();
    public abstract String rewrite(char symbol);
    public abstract double angle();

    public String generate() {
        StringBuffer sb = new StringBuffer(start());
        for (int n = 0; n < nMax; n++) {
            StringBuffer sbNext = new StringBuffer();
            for (int i = 0; i < sb.length(); i++) {
                sbNext.append(rewrite(sb.charAt(i)));
            }
            sb = sbNext;
        }

        return sb.toString();

    }

    public void draw(String code) {
        StdDraw.setScale(scaleMin, scaleMax);
        StdDraw.clear();
        for (int i = 0; i < code.length(); i++) {
            interpret(code.charAt(i));
        }

        StdDraw.show();
    }




    protected void interpret(char symbol) {
        switch (symbol) {
            case '+': rotate(angle()); break;
            case '-': rotate(-1 * angle()); break;
            case 'F': moveForward(); break;
            default: throw new IllegalArgumentException("syntax error in input");
        }

    }
}
