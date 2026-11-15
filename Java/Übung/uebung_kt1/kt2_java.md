# SWJ3 – Übungskurztest 2

**Datum:** __________, **Dauer:** 15 Min, **erlaubte Unterlagen:** Online-Referenzen: [https://docs.oracle.com/en/java/javase/25/docs/api/](https://docs.oracle.com/en/java/javase/25/docs/api/)

**Name:**

**Gruppe:**

**Punkte:** ___ von 6

## Aufgabe: OOP & Collections (2 + 2.5 + 1.5 Punkte)

**Hinweis:** Die Angabe von `imports` ist nicht notwendig. Sie dürfen davon ausgehen, dass alle übergebenen Referenzen, Collection-Elemente und Zeichenketten ungleich `null` sind. Die mit `…` abgekürzten Konstruktoren und Zugriffsmethoden sind bereits implementiert.

In Objekten der folgenden Klasse werden der Name eines Studierenden, die besuchte Lehrveranstaltung und die erreichte Punktezahl gespeichert.

```java
public class Student implements Comparable<Student> {
    private final String name;
    private final String course;
    private final int points;

    public Student(String name, String course, int points) { … }
    public String getName()                               { … }
    public String getCourse()                             { … }
    public int getPoints()                                { … }
    …
}
```

**a.** Implementieren Sie die Schnittstelle `Comparable` so, dass Studierende nach ihrer **Punktezahl absteigend** verglichen werden: Eine höhere Punktezahl soll zuerst kommen. **Falls die Punktezahl gleich ist**, soll weiter nach dem **Namen alphabetisch aufsteigend** verglichen werden.

**b.** Implementieren Sie die folgende Methode. Sie soll für jede vorkommende **Lehrveranstaltung** ermitteln, **wie viele Studierende** diese besuchen.

Die Rückgabe soll jeder Lehrveranstaltung ihre Anzahl zuordnen. Jede Lehrveranstaltung soll dabei genau einmal als Schlüssel vorkommen. Die Schlüssel sollen **alphabetisch aufsteigend** geordnet sein. Jedes Element der übergebenen Collection wird einmal gezählt; bei einer leeren Collection soll das Ergebnis leer sein.

Ersetzen Sie ??? durch ein **geeignetes Interface einschließlich der Typparameter**:

```java
public static ??? countStudentsByCourse(Collection<Student> students);
```

Implementieren Sie anschließend die Methode. Verwenden Sie dabei eine geeignete **Implementierung** des gewählten Interfaces aus dem **Java Collections Framework**.

**c.** Erklären Sie die Funktion der Schnittstellen `Iterable<T>` und `Iterator<T>`. Welche Rolle spielen die Methoden `iterator()`, `hasNext()` und `next()`, wenn eine Datenstruktur mit einer **erweiterten `for`-Schleife** durchlaufen wird? Ordnen Sie jede dieser Methoden der passenden Schnittstelle zu.
