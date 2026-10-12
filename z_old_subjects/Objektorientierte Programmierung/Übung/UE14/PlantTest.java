


void main() {
    StdDraw.enableDoubleBuffering();
    StdDraw.setCanvasSize(4000,4000);

   // LSystem s1 = new Plant(8, 0, 700, new Turtle2d(100, 1, 90));

   LSystem s1 = new PlantVc(8, 0, 700, new Turtle2d(100, 1, 90));
    String code = s1.generate();
    s1.draw(code);
}
