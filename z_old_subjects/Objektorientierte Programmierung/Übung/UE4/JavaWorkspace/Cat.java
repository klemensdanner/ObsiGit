/* Cat:                                                      SWa, 2026-04-08 */
/* ----                                                                      */
/* A simple class to represent cats to demonstrate the basic                 */
/* principles of OOP.                                                        */
/* ========================================================================= */
public class Cat extends AbstractPet {
    public Cat(String name, int age) {
        super(name, age);
    }

    protected String getSound() { return "MEOW"; }

    public int getAgeInHumanYears() {
        switch (getAge()) {
            case 0: return 0;                         // newborn = 0
            case 1: return 15;                        // first year = 15
            case 2: return 21;                        // second year = 6
            case 3: return 27;                        // third year = 4
            default: return 31 + (getAge() - 4) * 4;  // each year after = 4
        }
    }

    public boolean equals(Object obj) {
        if (obj instanceof Cat) {
            Cat otherCat = (Cat)obj;
            return otherCat.getName().equals(getName()) && otherCat.getAge() == getAge();
        }
        return super.equals(obj);
    }
}
