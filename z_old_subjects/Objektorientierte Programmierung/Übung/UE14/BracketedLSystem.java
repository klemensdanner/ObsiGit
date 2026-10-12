
// abstract base class for Lindenmayer systems
import java.util.Stack;

public abstract class BracketedLSystem extends LSystem {

    protected Stack<Turtle> stack;
    protected void push() { stack.push(turtle.copy()); }
    protected void pop() { turtle = stack.pop(); }


    public BracketedLSystem(int nMax, double scaleMin, double scaleMax, Turtle turtle) {
        super(nMax, scaleMin, scaleMax, turtle);
        stack = new Stack<Turtle>();
    }



    protected void interpret(char symbol) {
        switch (symbol) {
            case '[': push(); break;
            case ']': pop(); break;
            default: super.interpret(symbol);
        }

    }
}

