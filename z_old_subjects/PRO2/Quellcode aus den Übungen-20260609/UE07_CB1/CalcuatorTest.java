void main() {
    String line = IO.readln();
    Scanner scanner = new Scanner(line);
    Calculator c = new Calculator(scanner);
    c.calculate();
}
