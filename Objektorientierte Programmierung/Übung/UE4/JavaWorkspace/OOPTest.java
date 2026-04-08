void main() {
    Pet[] pets = new Pet[4];

    pets[0] = new Dog("Waldi", 2); // possible cz Dog "is-a" Pet
    pets[1] = new Cat("Murli", 2); // Cat "is-a" Pet
    pets[2] = new Dog("Bello", 5);
    pets[3] = new Cat("Minki", 5);

/*     for (Pet pet : pets) {
        if (pet instanceof Dog) {
            Dog dog = (Dog)pet;
            dog.greet();
        }

        if (pet instanceof Cat) {
            Cat cat = (Cat)pet;
            cat.greet();
        }
    } */

    for (Pet pet : pets) {
        pet.greet();        // dynamische Bindung
        IO.println("age in human years: " + pet.getAgeInHumanYears());
    }
    
}