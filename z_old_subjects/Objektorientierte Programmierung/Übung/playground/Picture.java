/* Picture:                                                  SWa, 2026-04-22 */
/* --------                                                                  */
/* A picture is a collection of shapes.                                      */
/* ========================================================================= */

import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;

public class Picture extends Shape {
    private List<Shape> shapes;

    public Picture() {
        super();
        shapes = new ArrayList<Shape>(); // composite pattern:
        // Liste von shapes. Picture ist auch ein Shape. Dadurch kann die Methode draw
        // von jeder abgeleiteten Klasse ausgeführt werden wenn man über eine Liste von shapes iteriert
        // auch in picture. die Klasse Picture gruppiert also verschiedene Shapes und bietet genau die 
        // Shape funktionalität draw(). Picture würde bei einem Aufruf von draw() einfach alle Shapes zeichenen,
        // indem es die draw() methode der anderen Klassen aufruft. (was einfach geht wegen Polymorphismus und dynamischer Bindung)
    }

    public void add(Shape shape) {
        if (shape == null) throw new IllegalArgumentException("shape is null");
        shapes.add(shape);
    }
    public boolean remove(Shape shape) {
        if (shape == null) return false;
        return shapes.remove(shape);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder(super.toString());
        Iterator<Shape> it = shapes.iterator();
        while (it.hasNext()) {
            Shape s = it.next();
            sb.append("    " + s.toString() + "\n");
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
}
