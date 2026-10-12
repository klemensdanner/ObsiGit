/* Pet:                                                      SWa, 2026-04-08 */
/* ----                                                                      */
/* A simple base class to represent characteristics of pets to demonstrate   */
/* the basic principles of OOP.                                             */
/* ========================================================================= */
public abstract class AbstractPet implements Pet {
    private String name;
    private int age;

    public AbstractPet(String name, int age) {
        setName(name);
        setAge(age);
    }

    public String getName() { return name; }
    public void setName(String name) { this.name = name != null ? name : ""; }

    public int getAge() { return age; }
    public void setAge(int age) {
        assert age >= 0 : "age must not be negative";
        this.age = age;
    }

    public String toString() {
        return String.format("%s (%d)", name, age);
    }

    public void greet() {  // template method pattern
        IO.println(toString() + ": " + getSound());
    }

    protected abstract String getSound();
    
    public abstract int getAgeInHumanYears();
}
