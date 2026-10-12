
private void initCanvas() {
    final int CANVAS_WIDTH = 100;
    final int CANVAS_HEIGHT = 100;



}












void main() {
    Shape[] shapes = new Shape[2];
    shapes[0] = new Line(10,10,50,50);
    shapes[1] = new Rectangle(100,100,50,20);

    for (Shape s : shapes) {
        s.draw();
    }
}