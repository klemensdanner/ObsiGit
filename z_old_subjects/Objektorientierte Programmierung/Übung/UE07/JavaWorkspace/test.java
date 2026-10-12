void a(int input) {
    input++;
    IO.println(input);
    a(input);
}

void main() {
   a(1);
}