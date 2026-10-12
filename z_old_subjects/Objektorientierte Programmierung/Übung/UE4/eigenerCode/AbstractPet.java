package eigenerCode;
/* Pet:                                                       DA, 2026-04-08 */
/* ------                                                                    */
/* basic class to represent pets                                             */
/* ========================================================================= */

public abstract class AbstractPet implements Nameable { // jedes pet "is-a" namable
                                                // man kann z.B. über Namable Objekte (oder alle Klassen darunter) 
                                                // iterieren und jeweils getName
                                                // und setName aufrufen
    private String name;
    private int age;

    public AbstractPet(String name, int age) {
        setName(name);
        setAge(age);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name != null ? name : "";
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        assert age >= 0: "age must not be negative";
        this.age = age;
    }

    public String toString() {
        return String.format("%s (%d)", name, age);
    }


    public void greet() {
        IO.println(toString() + ": " + getSound()); // template method pattern
        // man will 
    }

    protected abstract String getSound(); // protected: von außen kann niemand getSound aufrufen, aber für alle
    //Unterklassen sichtbar damit sie überschrieben werden kann


    public abstract int getAgeInHumanYears();

}