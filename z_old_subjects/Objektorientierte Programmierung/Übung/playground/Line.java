/* Line:                                                     SWa, 2026-04-22 */
/* -----                                                                     */
/* A simple 2D line.                                                         */
/* ========================================================================= */

import java.awt.Color;

public class Line extends Shape {
    private double x1, y1, x2, y2;

    public Line(double x1, double y1, double x2, double y2) {
        this(x1, y1, x2, y2, 0.005, StdDraw.BLACK);
    }
    public Line(double x1, double y1, double x2, double y2, double lineWidth, Color color) {
        super(true, lineWidth, color);
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder(super.toString());
        sb.append(String.format("\nx1 = %f, y1 = %f, x2 = %f, y2 = %f\n", x1, y1, x2, y2));
        return sb.toString();
    }

    @Override
    public void draw() {
        if (visible) {
            super.draw();
            StdDraw.line(x1, y1, x2, y2);
        }
    }
}
