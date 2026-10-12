/* Dog:                                                      SWa, 2026-04-08 */
/* ----                                                                      */
/* A simple class to represent dogs to demonstrate the basic                 */
/* principles of OOP.                                                        */
/* ========================================================================= */
public class Dog extends AbstractPet {
    public Dog(String name, int age) {
        super(name, age);
    }

    protected String getSound() { return "WOOF"; }

    public int getAgeInHumanYears() {
        switch (getAge()) {
            case 0: return 0;                         // newborn = 0
            case 1: return 15;                        // first year = 15
            case 2: return 24;                        // second year = 9
            default: return 28 + (getAge() - 3) * 4;  // each year after = 4
        }
    }
}
