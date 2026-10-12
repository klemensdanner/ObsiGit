// Shape
// an abstract base class to represent geometric shapes
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
        this.visible = visible;
        this.lineWidth = lineWidth;
        this.color = color;
    }

    public boolean getVisible() {return visible;}
    public void setVisible(boolean visible) {this.visible = visible;}

    public double getLineWidth() {return lineWidth;}
    public void setLineWidth(double lineWidth) {
        if (!Double.isFinite(lineWidth)) throw new IllegalArgumentException("line must be finite");
        
    this.lineWidth = lineWidth;}
   


    public Color getColor() {return color;}
    public void setColor(Color color) {this.color = color;}




    public void describe() {
        IO.println(toString());
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(this.getClass().getSimpleName() + ": ");
        sb.append(visible ? "visible" : "invisible");

        return sb.toString();
    }

   public void draw() {
       StdDraw.setPenColor(color);
       StdDraw.setPenRadius(lineWidth);
   }
}