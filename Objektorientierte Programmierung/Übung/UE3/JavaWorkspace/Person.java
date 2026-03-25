/* Person:                                                    DA, 2026-03-25 */
/* ------                                                                    */
/* Person class                                                              */
/* ========================================================================= */


public class Person {
    private String name;
    private Date birthDate;

    public Person() { //
        this("UNKNOWN", Date.INVALID_DATE); // immer wenn ein Konstruktor einen Anderen aufruft 
                                                  // auf INVALID_DATE wird mit der Klasse zugegriffen
    }

    public Person(String name, Date birthDate) { //kein Rückgabewert und selber Name wie Klasse
        setName(name); //oder auch this.setName(name) bei Mehrdeutigkeiten
        this.birthDate = birthDate;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        assert name != null;
        this.name = name;
    }

    public String toString() {
        return name + ", geboren am: " + birthDate; //birthDate verwendet automatisch eine Methode toString
    }

    public Date getBirthDate() {
        return birthDate;
    }

}