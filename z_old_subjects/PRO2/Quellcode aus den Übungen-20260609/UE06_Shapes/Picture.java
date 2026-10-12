import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;

public class Picture extends Shape {
    private List<Shape> shapes;

    public Picture() {
        super();
        shapes = new ArrayList<Shape>();
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder(super.toString() + "\n");

        Iterator<Shape> it = shapes.iterator();
        while (it.hasNext()) {
            Shape s = it.next();
            sb.append("   " + s.toString() + "\n");
        }
        return sb.toString();
    }

    @Override
    public void draw() {
        Iterator<Shape> it = shapes.iterator();
        while (it.hasNext()) {
            Shape s = it.next();
            s.draw();
        }
    }

    public void add(Shape shape) {
        assert shape != null : "shape must not be null";
        shapes.add(shape);
    }
}
