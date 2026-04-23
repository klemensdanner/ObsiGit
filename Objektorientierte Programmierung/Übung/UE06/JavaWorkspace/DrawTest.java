void main() {
    StdDraw.setTitle("Draw");
    StdDraw.setCanvasSize(1000, 600);
    StdDraw.setXscale(0, 999);
    StdDraw.setYscale(0,599);

    StdDraw.rectangle(500, 300, 100, 100);
    

    StdDraw.setPenColor(StdDraw.ORANGE);
    StdDraw.setPenRadius(0.02);
    StdDraw.ellipse(500, 300, 100, 50);
    StdDraw.setPenColor(StdDraw.GREEN);
    StdDraw.filledEllipse(500, 300, 100, 50);
}