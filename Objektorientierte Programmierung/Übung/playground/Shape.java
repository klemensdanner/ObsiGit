/* Shape:                                                    SWa, 2026-04-22 */
/* ------                                                                    */
/* An abstract base class to represent geometric shapes.                     */
/* ========================================================================= */

import java.awt.Color;

public abstract class Shape {
    protected boolean visible;
    protected double lineWidth;
    protected Color color;

    public Shape() {
        visible = false;
        lineWidth = 0.0;
        color = StdDraw.TRANSPARENT;
    }
    public Shape(boolean visible, double lineWidth, Color color) {
        setVisible(visible);
        setLineWidth(lineWidth);
        setColor(color);
    }

    public boolean getVisible() { return visible; }
    public void setVisible(boolean visible) { this.visible = visible; }
    public double getLineWidth() { return lineWidth; }
    public void setLineWidth(double lineWidth) {
        if (!Double.isFinite(lineWidth)) throw new IllegalArgumentException("lineWidth must be finite");
        if (lineWidth < 0) throw new IllegalArgumentException("lineWidth must be positive");
        this.lineWidth = lineWidth;
    }
    public Color getColor() { return color; }
    public void setColor(Color color) {
        if (color == null) throw new IllegalArgumentException("color is null");
        this.color = color;
    }

    public void describe() {
        IO.println(toString());
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(this.getClass().getSimpleName() + ": ");
        sb.append((visible ? "visible" : "invisible") + ", ");
        sb.append(color).append(", with line width of ").append(lineWidth);
        return sb.toString();
    }

    public void draw() {
        StdDraw.setPenColor(color);
        StdDraw.setPenRadius(lineWidth);
    }
}
