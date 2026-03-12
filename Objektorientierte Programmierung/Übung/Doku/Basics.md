- void: kein Datentyp
- Methoden starten mit Kleinbuchstaben
- Klassen starten mit Großbuchstaben
- ansonsten camelCasing

- Konstanten: SCREAMING_SNAKE_CASE


# Datentypen

**Ganzzahldatentypen**

|       |     | Wertebereich    |
| ----- | --- | --------------- |
| byte  | 1B  |                 |
| short | 2B  |                 |
| int   | 4B  | -2^31 .. 2^31-1 |
| long  | 8B  |                 |

| float  | 4B  |
| ------ | --- |
| double | 8B  |

boolean
char

---
void: "leerer Datentyp"


# Spezialoperationen

0 / 0 --> Double.NaN (Not a Number)
1.0 / 0 --> Double.POSITIVE_INFINITY
-1.0 / 0 --> Double.NEGATIVE_INFINITY
Diese Werte können von double Variablen angenommen werden.

----
``` java
char ch = 'A';
```




``` java
IO.println("count: " + count); //implizite Typumwandlung
```


```java
while (value != 0) {
	sum += value;
	count++;
	value = readInt();
}
```

**Unterschied count++ und ++count**
count++: Ausdruck hat den Wert count, aber wird danach um 1 erhöht
++count: Ausdruck hat den bereits um 1 erhöhten Wert

> [!info]
> Lesbarkeit: wir verwenden count++ als einfache Anweisung.


### Explizite Typumwandlung

``` java
double result = sum / count;
```
Ausdruck rechts wird zuerst ausgewertet, zwei integer dividiert ergeben einen integer, welcher dann result zugeordnet wird.

``` java
double result = (double)sum / count;
```


``` java
int i = value > 0 ? 17 : 18;
```

