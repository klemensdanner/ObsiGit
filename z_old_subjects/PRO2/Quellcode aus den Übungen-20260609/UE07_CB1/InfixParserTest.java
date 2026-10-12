void main() {
    String line = IO.readln();
    Scanner scanner = new Scanner(line);
    InfixParser infixParser = new InfixParser(scanner);
    infixParser.parse();
}
