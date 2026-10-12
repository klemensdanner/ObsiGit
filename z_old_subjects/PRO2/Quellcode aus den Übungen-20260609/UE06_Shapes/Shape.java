/* Shape:                                                     DA, 2026-04-22 */
/* ------                                                                    */
/* Base class for any kind of shape.                                         */
/*                                                                           */
/* StdDraw.java is used to draw shapes.                                      */
/* https://introcs.cs.princeton.edu/java/stdlib/javadoc/StdDraw.html         */
/* ========================================================================= */

import java.awt.Color;

public abstract class Shape {
    
    protected boolean visible;
    protected Color color;
    protected double lineWidth;

    public Shape() {
        visible = false;
        color = StdDraw.TRANSPARENT;
        lineWidth = 0.0;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(this.getClass().getSimpleName() + ": ");
        sb.append(visible ? "visible" : "invisible");
        sb.append(", " + color + ", with line width of " + lineWidth);
        return sb.toString();
    }

    public void describe() {
        IO.println(this.toString());
    }

    public void draw() {
        StdDraw.setPenColor(color);
        StdDraw.setPenRadius(lineWidth);
    }

    public boolean getVisible() {
        return visible;
    }

    public void setVisible(boolean visible) {
        this.visible = visible;
    }

    public Color getColor() {
        return color;
    }

    public void setColor(Color color) {
        this.color = color;
    }

    public double getLineWidth() {
        return lineWidth;
    }

    public void setLineWidth(double lineWidth) {
        this.lineWidth = lineWidth;
    }

}