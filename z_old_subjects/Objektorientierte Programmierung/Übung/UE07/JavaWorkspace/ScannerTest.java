void main() {
    IO.print("expr > ");
    String line = IO.readln();
    Scanner scanner = new Scanner(line);

    while ((scanner.sy != Symbol.EOL) && (scanner.sy != Symbol.ERROR)) {
        IO.print(scanner.sy);
        if (scanner.sy == Symbol.NUMBER) {
            IO.println(" (" + scanner.numberVal + ") ");
        } else {
            IO.println();
        }
        scanner.nextSy();
    }
}