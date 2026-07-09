- Praxisaufgaben, Theoriefragen, 50/50 aber schwerpunkt coding
- alle themen können coding aufgaben kommen; aber backtracking wird er keine kurze aufgabe finden, kommt gar nicht
- wenn man behälter wie listen, stack etc braucht, gibt er diese an
- Methoden wie Integer.parseInt darf man verwenden und soll man wissen
- es kommt sicher ein ATG beispiel, aber nicht interpreter/parser, Voraussetzung für rekursiven Abstieg (LL1-Konformität)
- Größe der Aufgaben: lösbar in 20 min
- einfache Klassen implementieren mit Konstruktor und einfache Methoden
- Zeit: 90 Minuten, direkt auf Papier
- ATG: number und ident verwenden aber man muss Terminalklassen zumindest sprachlich oder mit regex beschreiben

Kapitel:
- Einführung in Java --- Unterschied Pascal / Java, also kompillierte Sprache vs. Bytecode der mit Java VM ausgeführt wird
	- Gemeinsamkeit: statisch typisiert (alles hat einen Datentyp)
	- dadurch kann der Compiler Programmierfehler erkennen vorm ausführen
	- was ist robuster, Java / Pascal? Java - durch die gute Ausnahmebehandlung etc
- Zeichenkettenvergleich
	- s == p vs. s.equals(p) --> erste version robust aber vergleicht halt nur die Referenz, zweite geht nur wenn s ungleich null
- default-werte! Klassenvariablen haben default werte, lokale variablen sind nicht by default initialisiert
- Wissen wie Felder funktionieren; z.B.


``` 
String s = "Hallo";

String[] a = new String[5];
a[0] = s;
a[2] = s;
a[4] = a[0] + "Hallo";

// dabei gehts darum

```

- Begriffe Methoden und Klassenmethoden (static mathod, aber Begriff Klassenmethoden machen)
- Aus einem Konstruktor einen anderen Konstrkutor aufrufen
- private bezieht sich immer auf die Klasse und nicht nur auf das Objekt und public klar auseinanderhalten
- einfache Klassen implementieren (z.B. für Punkte, Dreiecke oder z.B. color, oder eine Klasse für Bruchzahlen)

z.B. Gesucht ist eine Klasse für rationale Zahlen mit Zähler und Nenner, die folgende Operationen bereitstellen
- Multiplizieren von zwei rationalen Zahlen

```
public class Rational {
	private int nom;
	private int denom;
	
	public Rational(int nom, int denom) {}
	
	
	// Version 1
	public void multiply(Rational r) {}
	
	// Version 2
	public Rational multiply(Rational r) {}


	// Version 3
	public static Rational multiply(Rational r1, Rational r2) {}
	// das ist nicht objektorientiert, wäre also keine gute Lösung
}


```


- Vererbung erklären können, überschreiben und überladen von Methoden
- Klasse Object mit toString, equals und hashCode, equal / hashCode sinnvoll überschreiben; d.h. z.B. eine vernünftige hashCodeimplementierung
	- zumindest alles zusammenzählen, besser mit einer konstanten Primzahl multiplizieren

Aufgabe mit dynamischer Bindung
---Jede Methode wird dynamisch gebunden

```
class A {
	void m1() {IO.print("A"); }
	void m2() {this.m1(); }
	void m3() { m1(); }
}

class B extends A {
	void m1() { IO.print("B"); }
	void m3() { super}

}


was passiert wenn verschiedenes aufgerufen wird?
Alles ist dynamisch gebunden, auch this.m1() kann das m1 in B aufrufen

```


Unterschied Interface, abstrakte Klassen, Klassen
- abstrakte Klassen können Datenkomponenten haben, Interfaces nicht (weil es dafür Mehrfachvererbung gibt)

Eingabevalidierung bei Methoden:
- wenn er drauf wertlegt dass eingangsparameter validiert werden, dann steht das explizit dabei. Wenns nicht explizit dabei steht muss 
- alles was von Exception abgeletiet ist muss man oben deklarieren (mit thorws IOException)
- alles was von Runtimeexception abgeleitet ist, muss man das oben nicht zwingend angeben (prüfen!)
- nur für public Methoden, für private Methoden kann man selbst sicherstellen damit die Eingabewerte passen

- Begriff Faktorisierung
- UML-Klassendiagramme zeichnen und lesen können (v.a. Klassen und Vererbungsbeziehungen)

- beim Überschreiben von .equals braucht man instanceof und typecast --- **warum**?

- Nachbilden von Mehrfachvererbung nachbilden


Designpatterns:
- composite pattern sollte man kennen, die anderen nicht


Annahmen machen wenn man sich bei der Aufgabenstellung nicht sicher ist

#### Grammatiken
was kann man nicht in rekursivem Abstieg umsetzen?
LL(1) Bedingung checken
z.b.: B = C | C "." C.          --> erfüllt nicht LL(1) Bedingung
Wie kann man die Regel umschreiben, damit die LL(1) Bedingung erfüllt ist?
z.B. C \["." C].
- Punkt nicht vergessen

Terminalklassen richtig angeben (sprachlich oder mit REGEX)

cm /m / min sind terminalsymbole

#### Ausnahmebehandlung
try - catch - finally --- finally?? **anschauen** -- finally wird IMMER ausgeführt, auch wenn schon was anderes ausgeführt wurde


Generische Typen kommt nix; nur minimal besprochen

#### Hashing Datenstruktur
- warum man Kollissionen nicht weg bekommt,
- Möglichkeiten zu Kollissionsbehandlung
- In welchen Situationen kommt man an O(1) (Füllstand der Tabelle)
- Wann ist eine Hashfunktion gut?
	- schnell
	- gleich verteilte Fragen


#### Heap Datenstruktur
- heap sort kommt nicht
- Feld zu Baum zeichnen, Baum zu Feld zeichnen
- (position 0 ist freizuhalten)
Biespiel: Heap gezeichnet, welcher Knoten erfüllt die Heap eigenschaft nicht; wie kann der wieder hergestellt werden



#### Graphen
- vll irgendeine Methode zum Adjazenzlistenrepräsentation

#### Bracktracking
- kommt gar nicht, acuh nicht theoretisch

#### Objektorientierter Entwurf
- gibt einen Text, erster Klassenentwurf machen, kleine Aufgabenstellung