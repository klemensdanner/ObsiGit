


void main() {
    StdDraw.enableDoubleBuffering();
    Turtle t = new Turtle2d(0,0,0);
    StdDraw.setCanvasSize(800,800);

    LSystem s = new SierpinskiV1(9, 0, 700, new Turtle2d(100, 1, 90));
    LSystem s1 = new SierpinskiV2(9, 0, 700, new Turtle2d(100, 1, 90));
    String code = s1.generate();
    s1.draw(code);
}
