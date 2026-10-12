// turtle implementation for 2D graphics

public class Turtle2d implements Turtle {
    private double x;
    private double y;
    private double a;

    public Turtle2d(double x, double y, double a) {
        this.x = x;
        this.y = y;
        this.a = a;
    }

    public Turtle2d(Turtle2d other) {
        this.x = other.x;
        this.y = other.y;
        this.a = other.a;
    }

    public void moveForward() {
        double xNext = x + Math.cos(Math.PI * a / (double)180);
        double yNext = y + Math.sin(Math.PI * a / (double)180);

        StdDraw.line(x, y, xNext, yNext);

        x = xNext;
        y = yNext;
    }



    public void rotate(double angle) { // angle in 0 .. 360 degrees
        a += angle;
        a = a % 360;
        if (a < 0) a += 360;

    }

    public Turtle copy() {
        return new Turtle2d(this);      
        };


    }

