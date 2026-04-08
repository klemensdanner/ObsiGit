/* Pet:                                                       DA, 2026-04-08 */
/* ------                                                                    */
/* basic class to represent pets                                             */
/* ========================================================================= */

public abstract class Pet1 {
    private String name;
    private int age;

    public Pet(String name, int age) {
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


    public abstract void greet(); // wenn man sowas verwendet, kann man kein Objekt der Klasse Pet erstellen
    // deshalb muss man die ganze Klasse als abstrakt markiert werden

}