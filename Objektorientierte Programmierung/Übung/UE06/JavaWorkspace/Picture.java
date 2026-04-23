// Shape
// an abstract base class to represent geometric shapes
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Picture extends Shape {
    private List<Shape> shapes;

    public Picture() {
        super();
        shapes = new ArrayList<Shape>();
    }

    public void add(Shape shape) {
        if (shape == null) {throw new IllegalArgumentException("shape is null");}
        shapes.add(shape);
    }

    public boolean remove(Shape shape) {
        if (shape == null) return false;
        return shapes.remove(shape);
    }

    
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(this.getClass().getSimpleName() + ": ");
        sb.append(visible ? "visible" : "invisible");

        return sb.toString();
    }

   public void draw() {
    Iterator<Shape> it = shapes.iterator(); // universal Iterator -- can be used for arraylist as well as for a linked list
    while (it.hasNext()) {
        Shape s = it.next();
        s.draw();
    } 
   }

/*    public String toString() {
        StringBuilder sb = new StringBuilder(super.toString());
        Iterator<Shape> it = shapes.iterator(); // universal Iterator -- can be used for arraylist as well as for a linked list
        while (it.hasNext()) {
            Shape s = it.next();
            s.describe();
   } */
}