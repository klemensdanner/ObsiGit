/* PersonTest:                                                DA, 2026-03-25 */
/* ------                                                                    */
/* Test the Person class                                                     */
/* ========================================================================= */

void main() {
    Person p = new Person();
    IO.println(p.getName());

    Person ludwig = new Person("Ludwig v. Beethoven", new Date(16,9,1770));
    IO.println(ludwig);



    String myString = new String("myString");
    String anotherString = new String("myString");
    String myString2 = "myString";
    String myString3 = "myString";

    IO.println("myString == anotherString: " + (myString == anotherString)); //Referenzen vergleichen, Klammer wichtig!!

    //Inhaltliche Gleichheit
    IO.println(myString.equals(anotherString));

    //compareTo gibt 0 - sie sind gleich, wenn zahl < 0; ist a kleiner, sonst ist zweiter String größer
    IO.println("myStringA".compareTo("myStringB"));

    int[] intValues = new int[10];

    String intValueString = "";
    for (int i = 0; i < intValues.length; i++) { //hier werden viele neue Zeichenketten erstellt und müssen immer wieder gedroppt werden - ineffizient
        intValueString += intValues[i];          // stattdessen macht man das mit StringBuilder
        intValueString += " ";
    }
    IO.println(intValueString);

    StringBuilder intValuesStringBuilder = new StringBuilder(); // der StringBuilder ist veränderbar
    for (int i = 0; i < intValues.length; i++) {
        intValuesStringBuilder.append(i);
        intValuesStringBuilder.append(" ");
    }
    IO.println(intValuesStringBuilder.toString());

    for (int i = 0; i < myString.length(); i++) {
        IO.println(myString.charAt(i));
    }

}