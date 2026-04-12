package eigenerCode;



public class Cat extends Pet {

    public Cat(String name, int age) {
        super(name, age); // ruft Konstruktor der Basisklasse auf
        //Konstruktoren werden nicht vererbt
    }

    protected String getSound() {
        return "MEOW";
    }

    public int getAgeInHumanYears() {
        switch (getAge()) {
            case 0: return 0;
            case 1: return 15;
            case 2: return 21;
            case 3: return 27;
            default: return 31 + (getAge())*4;
        }
    }

}
