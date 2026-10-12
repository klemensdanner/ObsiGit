void main() {
    Pet[] pets = new Pet[4];
    pets[0] = new Dog("Waldi", 2);
    pets[1] = new Cat("Murli", 2);
    pets[2] = new Dog("Bello", 5);
    pets[3] = new Cat("Minki", 5);

    for (Nameable nameable : pets) {
        IO.println(nameable.getName());
    }
    IO.println();
    
    for (Pet pet : pets) {
        pet.greet();
    }
    IO.println();

    Object o = new Dog("Wuffi", 10);
    IO.println(o);

    ArrayList list = new ArrayList();
    list.add(new Cat("Schnurli", 4));
    list.add(new Dog("Schnauzi", 6));

    for (Object obj : list) {
        IO.println(obj);
    }
}
