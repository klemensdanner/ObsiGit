void main() {
    IO.print("n > ");
    int n = readInt();

    IO.print("exp > ");
    int exp = readInt();

    int p = 1;
    for (int i = 0; i < exp; i++) {
        //p = p * n;
        p *= n;
    }

    IO.println(n + " ^ " + exp + " = " + p);
}

int readInt() {
    String line = IO.readln();
    return Integer.parseInt(line);
}