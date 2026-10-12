import java.io.BufferedReader;

void main() {
    BufferedReader sourceFileReader = null;
    try {
        sourceFileReader = new BufferedReader(new FileReader("svp.mj"));
    } catch (Exception e) {
        IO.println("error: source file not found");
    }

    Scanner scanner = new Scanner(sourceFileReader);
    /* 
    Parser parser = new Parser(scanner);
    parser.parse();
    */
    Interpreter i = new Interpreter(scanner);
    i.interpret();
}