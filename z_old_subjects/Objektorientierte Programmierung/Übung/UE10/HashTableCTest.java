void main() {
    HashTableC ht = new HashTableC();

    IO.print("s > ");
    String s = IO.readln();

    while (!s.isEmpty()) {
        ht.add(s);
        IO.println(ht);
        IO.println();
        IO.print("s > ");
        s = IO.readln();
    }
}