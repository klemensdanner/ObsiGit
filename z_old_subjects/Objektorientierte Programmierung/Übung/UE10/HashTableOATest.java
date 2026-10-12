void main() {
    HashTableOA ht = new HashTableOA();

    String command = "";
    String s;
    do {
        command = IO.readln("command [(a)dd, (r)emove, (p)rint, (q)uit] > ");
        switch (command) {
            case "a": 
                s = IO.readln("s > ");
                ht.add(s);
                break;
            case "r":
                s = IO.readln("s > ");
                ht.remove(s);
                break;
            case "p":
                IO.println(ht);
                break;
        }

    } while (!command.equals("q"));
}