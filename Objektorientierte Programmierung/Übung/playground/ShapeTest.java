/* ShapeTest:                                                SWa, 2026-04-22 */
/* ----------                                                                */
/* Simple test program for OOP shapes.                                       */
/* ========================================================================= */

private void initCanvas() {
    final int CANVAS_WIDTH = 1000;
    final int CANVAS_HEIGHT = 600;

    StdDraw.setCanvasSize(CANVAS_WIDTH, CANVAS_HEIGHT);
    StdDraw.setXscale(0, CANVAS_WIDTH);
    StdDraw.setYscale(0, CANVAS_HEIGHT);

    StdDraw.setTitle("ShapeTest");
}

void main() {
    initCanvas();

    Picture p = new Picture();
    p.add(new Line(10, 10, 50, 50));
    p.add(new Rectangle(100,100, 50, 20));

    p.draw();
}
