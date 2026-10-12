/* Rectangle:                                                 DA, 2026-04-22 */
/* ------                                                                    */
/* Rectangle is described by its center (x, y), its half horizontal size     */
/* left and right from center (halfWidth) and half its vertical size up and  */
/* down from its center (halfHeight).                                        */
/* ========================================================================= */

import java.awt.Color;

public class Rectangle extends Shape {

    private double x, y; // center of the rectangle
    private double halfWidth, halfHeight; 
    private boolean filled;

    public Rectangle(double x, double y, double halfWidth, double halfHeight) {
        this.x = x;
        this.y = y;
        this.halfWidth = halfWidth;
        this.halfHeight = halfHeight;

        // default values
        visible = true; 
        color = StdDraw.BOOK_BLUE;
        lineWidth = 0.007;      
        filled = false;  
    }

    public Rectangle(double x, double y, double halfWidth, double halfHeight,
            boolean visible, Color color, double lineWidth, boolean filled) {
        this(x, y, halfWidth, halfHeight); // use of other constructor of Rect.

        this.visible = visible;
        this.color = color;
        this.lineWidth = lineWidth;     
        this.filled = filled;  
    }    


    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder(super.toString());
        sb.append(", " + (filled ? "filled" : "unfilled") + ", ");    
        sb.append(String.format("\nx = %f, y = %f, halfWidth = %f, halfHeight = %f", 
            x, y, halfWidth, halfHeight));
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

    public boolean getFilled() {
        return filled;
    }

    public void setFilled(boolean filled) {
        this.filled = filled;
    }

}