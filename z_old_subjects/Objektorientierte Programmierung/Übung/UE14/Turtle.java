// interface for turtle graphics

public interface Turtle {
    void moveForward();
    void rotate(double angle); // angle in 0 .. 360 degrees    
    Turtle copy();
}