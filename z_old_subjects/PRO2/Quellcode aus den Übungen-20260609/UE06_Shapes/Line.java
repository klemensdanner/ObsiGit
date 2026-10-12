/* Line:                                                      DA, 2026-04-22 */
/* ------                                                                    */
/* Line between start point (x0, y0) and end point(x1, y1).                  */
/* ========================================================================= */

import java.awt.Color;

public class Line extends Shape {
    
    private double x1, y1, x2, y2;

    public Line(double x1, double y1, double x2, double y2) {
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;

        visible = true; // default
        color = StdDraw.GREEN;
        lineWidth = 0.04;
    }

    public Line(double x1, double y1, double x2, double y2,
            boolean visible, Color color, double lineWidth) {
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;

        this.visible = visible;
        this.color = color;
        this.lineWidth = lineWidth;
    }    

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder(super.toString());
        sb.append(String.format("\nx1 = %f, y1 = %f, x2 = %f, y2 = %f", x1, y1, x2, y2));
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