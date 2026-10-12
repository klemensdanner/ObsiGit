void main() {
    IO.print("expr > ");
    String line = IO.readln();
    Scanner scanner = new Scanner(line);
    Parser parser = new Parser(scanner);

    parser.parse();
}