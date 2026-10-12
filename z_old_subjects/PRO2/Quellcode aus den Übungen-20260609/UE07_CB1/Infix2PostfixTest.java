void main() {
    String line = IO.readln();
    Scanner scanner = new Scanner(line);
    Infix2Postfix p = new Infix2Postfix(scanner);
    p.convert();
}
