public class Dog extends Pet {


    public Dog(String name, int age) {
        super(name, age);
    }

    protected String getSound() {
        return "Wooof";
    }

    public int getAgeInHumanYears() {
        switch (getAge()) {
            case 0: return 0;
            case 1: return 15;
            case 2: return 24;
            default: return 28 + (getAge() - 3)*4;
        }
    }
}
