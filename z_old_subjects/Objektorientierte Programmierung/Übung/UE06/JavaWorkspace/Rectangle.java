// Line
// a simple 2D line
import java.awt.Color;
public class Rectangle extends Shape {
    private double x, y, halfWidth, halfHeight;
    private boolean filled;


    public Rectangle(double x, double y, double halfWidth, double halfHeight) {
        this(x, y, halfWidth, halfHeight, 0.05, StdDraw.BLACK, false);
    }

    public Rectangle(double x, double y, double halfWidth, double halfHeight, double lineWidth, Color color, boolean filled) {
        super(true, lineWidth, color);
        this.x = x;
        this.y = y;
        this.halfWidth = halfWidth;
        this.halfHeight = halfHeight;
        this.filled = filled;
    }


    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder(super.toString());
        sb.append(String.format("\nx = %f, y = %f, halfWidth = %f, halfHeight = %f\n", x, y, halfWidth, halfHeight));

        return sb.toString();
    }

    @Override
    public void draw() {
        if (visible) {
            super.draw();
            StdDraw.line(x, y, halfWidth, halfHeight);
        }
    }
}