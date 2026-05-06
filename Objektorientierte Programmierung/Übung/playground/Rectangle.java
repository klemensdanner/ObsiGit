/* Rectangle:                                                SWa, 2026-04-22 */
/* ----------                                                                */
/* A simple 2D rectangle.                                                    */
/* ========================================================================= */

import java.awt.Color;

public class Rectangle extends Shape {
    private double x, y, halfWidth, halfHeight;
    private boolean filled;

    public Rectangle(double x, double y, double halfWidth, double halfHeight) {
        this(x, y, halfWidth, halfHeight, 0.005, StdDraw.BLACK, false);
    }
    public Rectangle(double x, double y, double halfWidth, double halfHeight, double lineWidth, Color color, boolean filled) {
        super(true, lineWidth, color);
        this.x = x;
        this.y = y;
        this.halfWidth = halfWidth;
        this.halfHeight = halfHeight;
        this.filled = filled;
    }

    public boolean getFilled() { return filled; }
    public void setFilled(boolean filled) { this.filled = filled; }

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
            if (filled) {
                StdDraw.filledRectangle(x, y, halfWidth, halfHeight);
            } else {
                StdDraw.rectangle(x, y, halfWidth, halfHeight);
            }
        }
    }
}
