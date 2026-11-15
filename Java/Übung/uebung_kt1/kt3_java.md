# SWJ3 – Übungskurztest 3

**Datum:** __________, **Dauer:** 15 Min, **erlaubte Unterlagen:** Online-Referenzen: [https://docs.oracle.com/en/java/javase/25/docs/api/](https://docs.oracle.com/en/java/javase/25/docs/api/)

**Name:**

**Gruppe:**

**Punkte:** ___ von 6

## Aufgabe: OOP & Collections (2 + 2.5 + 1.5 Punkte)

**Hinweis:** Die Angabe von `imports` ist nicht notwendig. Sie dürfen davon ausgehen, dass alle übergebenen Referenzen, Collection-Elemente und Zeichenketten ungleich `null` sind. Die mit `…` abgekürzten Konstruktoren und Zugriffsmethoden sind bereits implementiert.

In Objekten der folgenden Klasse werden der Titel, die Priorität und der Erledigungsstatus einer Aufgabe gespeichert. Eine höhere Zahl bedeutet eine höhere Priorität. Die Klasse implementiert **nicht** `Comparable`.

```java
public class Task {
    private final String title;
    private final int priority;
    private final boolean completed;

    public Task(String title, int priority, boolean completed) { … }
    public String getTitle()                                  { … }
    public int getPriority()                                  { … }
    public boolean isCompleted()                              { … }
}
```

**a.** Implementieren Sie die folgende Klasse mit der Schnittstelle `Comparator<Task>`. Aufgaben sollen nach ihrer **Priorität absteigend** verglichen werden. **Falls die Priorität gleich ist**, soll weiter nach dem **Titel alphabetisch aufsteigend** verglichen werden. Bei gleicher Priorität und gleichem Titel soll der Vergleich `0` ergeben.

```java
public class TaskComparator implements Comparator<Task> {
    …
}
```

**b.** Implementieren Sie die folgende Methode. Es sollen nur Aufgaben zurückgegeben werden, die **noch nicht erledigt** sind. Die zurückgegebenen Aufgaben sollen gemäß dem **übergebenen Comparator** geordnet sein.

Das Ergebnis soll ein **Set** sein. Aufgaben, für die der übergebene Comparator beim Vergleich `0` liefert, sollen darin nur einmal vorkommen. Die übergebene Collection soll unverändert bleiben.

Ersetzen Sie ??? durch ein **geeignetes Interface einschließlich der Typparameter**:

```java
public static ??? selectOpenTasks(
    Collection<Task> tasks, Comparator<Task> order);
```

Implementieren Sie anschließend die Methode. Verwenden Sie dabei eine geeignete **Implementierung** des gewählten Interfaces aus dem **Java Collections Framework**. Die Methode soll mit jedem passenden übergebenen Comparator funktionieren.

**c.** Implementieren Sie die folgende Methode. Sie soll alle **bereits erledigten Aufgaben** aus der übergebenen Collection entfernen. Verwenden Sie dazu ausdrücklich einen **`Iterator<Task>` und dessen Methoden**. Die Verwendung von `removeIf`, Streams oder einer zusätzlichen Collection ist nicht erlaubt.

Sie dürfen davon ausgehen, dass die Collection das Entfernen von Elementen über ihren Iterator unterstützt.

```java
public static void removeCompleted(Collection<Task> tasks);
```
