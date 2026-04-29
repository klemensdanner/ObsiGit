void main() {
    IO.print("expr > ");
    String line = IO.readln();
    Scanner scanner = new Scanner(line);
    Calculator calculator = new Calculator(scanner);

    calculator.calculate();
}