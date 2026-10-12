


void main() {
    Turtle t = new Turtle2d(0,0,0);

    StdDraw.setCanvasSize(300,300);
    StdDraw.setScale(-2,2);


    KochCurve kc = new KochCurve(5,0,400,new Turtle2d(100, 100, 0));

    String code = kc.generate();
    kc.draw(code);
}
