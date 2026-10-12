/* Circle:                                                    DA, 2025-06-02 */
/* ------                                                                    */
/* The circle is described (according to StdDraw.java) by its center point   */
/* (x,y) and its radius.                                                     */
/* ------                                                                    */
/* todo: implementation of method draw() is currently missing ...            */
/* ========================================================================= */

public class Circle extends Shape {
    
    private double x, y;
    private double radius;

    public Circle(double x, double y, double radius) {
        this.x = x;
        this.y = y;
        this.radius = radius;

        visible = true;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder(super.toString());
        sb.append(String.format("\nx = %f, y = %f, radius = %f", x, y, radius));
        return sb.toString();
    }
}
