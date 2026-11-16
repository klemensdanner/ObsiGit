# SWJ3- BB - WS 2025 Kurztest 1

**Prüfer:** G1: Purgin, MSc; G2: Winkler, MSc

**Datum:** Samstag 25.10.2025, **Dauer:** 15 Min, **erlaubte Unterlagen:** Online-Referenzen: [https://docs.oracle.com/en/java/javase/25/docs/api/](https://docs.oracle.com/en/java/javase/25/docs/api/)

**Name:**  

**Gruppe:**

**Punkte:** ___ von 6

## Aufgabe: OOP & Collections (2 + 2.5 + 1.5 Punkte)

**Hinweis:** Die Angabe von `imports` ist nicht notwendig.

In Objekten der folgenden Klasse können der Name eines Produkts und dessen Preis gespeichert werden.

```java
public class Product implements Comparable<Product> {
    private final String name;
    private double price;
    
    public Product (String name)         { … }
    public String getName()              { … }
    public void   setPrice(double price) { … }
    public double getPrice()             { … }
    …
}
```

**a.** Implementieren Sie die Schnittstelle `Comparable` so, dass Produkte nach ihrem **Preis** verglichen werden können. **Falls der Preis gleich ist**, soll weiter nach dem **Namen** verglichen werden.

```java
@Override
public int compareTo(Product other) 
{
    int priceComp = Double.compare(this.price, other.price);

    if (priceComp != 0) 
    {
        return priceComp;
    }
    return this.name.compareTo(other.name);
}
```

**b.** Gegeben ist folgende Schnittstelle:

```java
public interface Predicate<T> {
  boolean test(T value);
}
```

Implementieren Sie die folgende Methode. Es sollen nur Produkte zurückgegeben werden, welche das **Predikat erfüllen**. Die zurückgegebenen Produkte sollen dabei **aufsteigend nach dem Preis** geordnet sein.

Ersetzen Sie ??? durch ein **geeignetes Interface**:

```java
public static SortedSet<Product> filterProducts(
    Collection<Product> products, Predicate<Product> pred);
```

Implementieren Sie anschließend die Methode. Verwenden Sie dabei eine geeignete **Implementierung** des gewählten Interfaces aus dem **Java Collections Framework**.

```java
public static SortedSet<Product> filterProducts(
        Collection<Product> products, Predicate<Product> pred) 
    {

    SortedSet<Product> set = new TreeSet<>();
    
    for (Product product : products) 
    {   
        if (pred.test(product)) 
        {
            set.add(product);
        }
    }

    return set;
}
```

**c.** Erklären Sie die Funktion der Schnittstellen `Iterable<T>` und `Iterator<T>` in Java. Wie arbeiten diese beiden Schnittstellen zusammen, um die Iteration über Datenstrukturen zu ermöglichen?

```java
Der Iterator ermöglicht es über fast jede Art von Klasse drüber zu iterieren. 
Eine Klasse wird mit extends Iterable<T> erweitert und dann wird ein Iterator in diese Klasse implementiert. 
Dieser kann dann man next() auf das nächste Objekt in zugreifen und mit hasNext() abfragen ob es noch ein nächstes Objekt gibt.

```
