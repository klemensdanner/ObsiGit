void main() {

    //test1();
    setCanvasSizeAndScaling();
    test3();

}

static void test1() {

    Line l = new Line(1.0, 4.5, 15.9, 34.3);
    l.describe();

    Rectangle r = new Rectangle(5.4, 7.9, 1.0, 5.2);
    r.describe();

    Circle c = new Circle(4.5, 2.3, 0.9);
    c.describe();

    Shape[] shapes = new Shape[3];
    shapes[0] = l;
    shapes[1] = r;
    shapes[2] = c;

    IO.println();
    for (Shape shape : shapes) {
        shape.describe();
    }

}

static void test2() {

    StdDraw.setPenColor(StdDraw.BOOK_RED);
    StdDraw.setPenRadius(0.01);
    StdDraw.line(200, 120, 800, 300);

    StdDraw.rectangle(200, 300, 70, 200);
    StdDraw.circle(320, 320, 80);
}

static void test3() {
    Picture p = new Picture();

    Line l = new Line(10, 45, 159, 343);
    Rectangle r = new Rectangle(450, 320, 120, 95);

    p.add(l);
    p.add(r);
    p.draw();
}

static void setCanvasSizeAndScaling() {

    final int CANVAS_WIDTH = 1000;
    final int CANVAS_HEIGHT = 600;

    StdDraw.setCanvasSize(CANVAS_WIDTH, CANVAS_HEIGHT);

    StdDraw.setXscale(0, CANVAS_WIDTH);
    StdDraw.setYscale(0, CANVAS_HEIGHT);

    StdDraw.setTitle("My Shapes");
    StdDraw.setVisible(true);    
}