---
title: "PRO2 Lernskript - Teil 1: Analyse und Themen 1-5"
subtitle: "Klausurorientiertes Verständnis-Skript auf Basis der bereitgestellten Unterlagen"
author: "Erstellt aus den bereitgestellten PRO2-Unterlagen"
date: "2026-07-09"
lang: de-DE
---

# Arbeitsstand und Relevanzfilter {#arbeitsstand}

Dieses Dokument ist der erste belastbare Zwischenstand des Lernskripts. Es enthält:

1. eine Analyse der bereitgestellten Dateien,
2. eine vollständige Liste der prüfungsrelevanten Themen nach Relevanzfilter aus `PRO_Klausurinfo.md`,
3. ein detailliertes Inhaltsverzeichnis für das Gesamtskript,
4. die ausgearbeiteten Kapitel **1 bis 5**.

Die restlichen Kapitel 6, 7, 8, 9 und 11 werden im nächsten Arbeitsschritt ergänzt. **Thema 10 wird ausgelassen**, weil Backtracking laut Klausurinfo nicht prüfungsrelevant ist.

**Wichtigster Relevanzfilter:** Das Skript orientiert sich zuerst an `PRO_Klausurinfo.md`. Die Folien liefern die fachliche Basis und die Beispielklausur `KLA_PRO2_2025.pdf` liefert das Aufgabenformat.

# Inhaltsverzeichnis {#inhalt}

Dieses manuelle Inhaltsverzeichnis ist in ODT und PDF klickbar. Zusätzlich sind innerhalb des Skripts Querverweise gesetzt, zum Beispiel von [`String.equals`](#kapitel-1-strings) zu [`equals/hashCode`](#kapitel-3-object) oder von [`Integer.parseInt`](#kapitel-1-eingabe) zu [`Ausnahmebehandlung`](#kapitel-5).

- [Arbeitsstand und Relevanzfilter](#arbeitsstand)
- [1. Quellenanalyse](#quellenanalyse)
- [2. Vollständige Liste der prüfungsrelevanten Themen](#themenliste)
- [3. Detailliertes Inhaltsverzeichnis für das Gesamtskript](#kapitelplan)
  - [Kapitel 1 - Einführung in Java](#kapitelplan-1)
  - [Kapitel 2 - Klassen und Objekte](#kapitelplan-2)
  - [Kapitel 3 - Objektorientierte Programmierung](#kapitelplan-3)
  - [Kapitel 4 - Attributierte Grammatiken](#kapitelplan-4)
  - [Kapitel 5 - Ausnahmebehandlung](#kapitelplan-5)
  - [Kapitel 6 - Pakete, Generics und Bibliothek](#kapitelplan-6)
  - [Kapitel 7 - Hashing](#kapitelplan-7)
  - [Kapitel 8 - Heap](#kapitelplan-8)
  - [Kapitel 9 - Graphen](#kapitelplan-9)
  - [Kapitel 11 - Objektorientierter Entwurf](#kapitelplan-11)
- [Kapitel 1 - Einführung in Java](#kapitel-1)
  - [Strings: `==` vs. `equals`](#kapitel-1-strings)
  - [Klassenmethoden](#kapitel-1-klassenmethoden)
  - [Parameterübergabe / call-by-value](#kapitel-1-call-by-value)
  - [Felder](#kapitel-1-felder)
- [Kapitel 2 - Klassen und Objekte](#kapitel-2)
  - [Geheimnisprinzip](#kapitel-2-geheimnis)
  - [Konstruktoren](#kapitel-2-konstruktoren)
  - [Beispielklasse `Rational`](#kapitel-2-rational)
- [Kapitel 3 - Objektorientierte Programmierung](#kapitel-3)
  - [Vererbung und Faktorisierung](#kapitel-3-vererbung)
  - [Dynamische Bindung](#kapitel-3-dynamische-bindung)
  - [`Object`, `equals`, `hashCode`](#kapitel-3-object)
  - [Abstrakte Klassen und Interfaces](#kapitel-3-abstrakt-interface)
- [Kapitel 4 - Datenorientierter Systementwurf und ATG](#kapitel-4)
  - [Terminalklassen](#kapitel-4-terminalklassen)
  - [LL(1)-Bedingung](#kapitel-4-ll1)
  - [Attributierte Grammatiken](#kapitel-4-atg)
- [Kapitel 5 - Ausnahmebehandlung](#kapitel-5)
  - [`try`, `catch`, `finally`](#kapitel-5-try-catch-finally)
  - [Checked vs. unchecked](#kapitel-5-checked)
- [Prüfungsstrategie Themen 1-5](#pruefungsstrategie-1-5)
- [Checkliste gegen typische Punkteverluste](#checkliste)
- [Offene Arbeitsschritte](#offene-arbeitsschritte)

# 1. Quellenanalyse {#quellenanalyse}

## 1.1 `PRO_Klausurinfo.md` - maßgeblicher Klausurfilter {#quellenanalyse-klausurinfo}

Die Klausur ist nach den Notizen eine Mischung aus Theorie- und Praxisaufgaben, aber mit deutlichem Coding-Schwerpunkt. Kleine Implementierungen auf Papier sind realistisch. Eine Aufgabe soll ungefähr in 20 Minuten lösbar sein. Besonders wichtig sind daher nicht nur Definitionen, sondern das sichere Anwenden in kurzen Codeaufgaben.

Zentrale Hinweise aus der Klausurinfo:

- Praxis und Theorie etwa 50/50, Schwerpunkt Coding.
- Alle Themen können grundsätzlich Codingaufgaben enthalten.
- Falls Listen, Stacks oder ähnliche Behälter gebraucht werden, werden sie in der Aufgabe angegeben.
- `Integer.parseInt` darf verwendet werden und sollte bekannt sein.
- **ATG kommt sicher**, aber nicht als vollständige Parser-/Interpreter-Implementierung. Wichtig ist die Voraussetzung für rekursiven Abstieg, also LL(1)-Konformität.
- ATG-Aufgaben verwenden häufig `number` und `ident`; Terminalklassen müssen zumindest sprachlich oder als Regex beschrieben werden können.
- Einfache Klassen mit Konstruktoren und Methoden sind sehr wahrscheinlich.
- Backtracking kommt gar nicht, auch nicht theoretisch.
- Generics kommen nicht bzw. nur minimal.
- Heapsort kommt nicht; die Heap-Datenstruktur selbst ist relevant.
- Bei Entwurfsmustern ist **Composite** relevant, andere Patterns nicht.

## 1.2 Folien 01-11 - fachliche Basis {#quellenanalyse-folien}

Die Folien geben die fachlichen Details. Für das Skript werden sie aber nicht ungefiltert übernommen. Stattdessen werden die Inhalte auf Klausurtauglichkeit reduziert:

- **01 Einführung in Java:** Java-Plattform, statische Typisierung, primitive und Referenztypen, Strings, Eingabe/Konvertierung, Anweisungen, Klassenmethoden, call-by-value, Felder.
- **02 Klassen und Objekte:** Objekt-/Klassenbegriff, Methoden, Konstruktoren, `this`, constructor chaining, Sichtbarkeit, Geheimnisprinzip, einfache Klassen wie Stack/Color.
- **03 OOP:** Vererbung, Überschreiben, `super`, Konstruktorverkettung, `Object`, Polymorphismus, dynamische Bindung, abstrakte Klassen, Interfaces, `instanceof`/Cast, Vererbungsarten.
- **04 ATG:** Datenorientierter Entwurf, Grammatiknotation, LL(1), attributierte Grammatiken, Terminalklassen, semantische Aktionen, Entwurfsweg vom Problem zur ATG.
- **05 Ausnahmebehandlung:** Exception-Objekte, `try`/`catch`/`finally`, checked/unchecked, `throws`, eigene Exceptions.
- **06 Java-Bibliothek:** Pakete/Importe und ausgewählte Bibliotheksmethoden, Generics nur minimal.
- **07 Hashing:** Hashfunktion, Kollisionen, Verkettung/offene Adressierung, Lastfaktor, `equals`/`hashCode`.
- **08 Heap:** Priority Queue, binärer Heap, Feld-Baum-Abbildung, Heap-Ordnung, `swim`/`sink`; Heapsort nicht.
- **09 Graphen:** Begriffe, Adjazenzmatrix/-liste, gerichtete Graphen in Java, einfache Methoden auf Adjazenzlisten.
- **11 OO Entwurf:** UML-Klassendiagramme, erster Klassenentwurf aus Text, Faktorisierung, Composite Pattern.

## 1.3 Beispielklausur `KLA_PRO2_2025.pdf` - typisches Aufgabenformat {#quellenanalyse-klausur}

Die Beispielklausur bestätigt den Stil der Klausur: kurze, punktgenaue Aufgaben, die Verständnis und kleine Implementierungen kombinieren. Enthalten sind:

1. **Felder:** Array-/Referenzstruktur zeichnen und eine `join`-Klassenmethode implementieren.
2. **Methoden und Klassenmethoden:** Unterschiede erklären und Parameterübergabe an primitiven Typen, `String` und Arrays skizzieren.
3. **Heap-Datenstruktur:** Feld-Baum-Abbildung und Wiederherstellung der Heap-Ordnung.
4. **Attributierte Grammatiken:** ATG für eine Hotelbewertungs-Sprache entwickeln.
5. **Klasse Polygon:** einfache Klasse implementieren und `equals(Object o)` überschreiben.
6. **Vererbung:** Begriff, Zweck und Java-Vererbungsarten erklären.
7. **Ausnahmebehandlung:** Ausgabe bei verschiedenen Exception-Fällen bestimmen.

Daraus folgt für die Vorbereitung: **Zeichnen, kleine Methoden, kleine Klassen, ATG und Code-Tracing** müssen aktiv geübt werden. Reines Auswendiglernen reicht nicht.

# 2. Vollständige Liste der prüfungsrelevanten Themen {#themenliste}

## Thema 1 - Einführung in Java {#themenliste-1}

**Relevant:** Java vs. Pascal/klassisch kompilierte Sprache; Bytecode und JVM; statische Typisierung; robuste Programme; primitive und Referenztypen; Strings; `==` vs. `equals`; Defaultwerte; lokale Variablen; Eingabe und `Integer.parseInt`; Anweisungen; Klassenmethoden; call-by-value; Überladen; Felder.

**Typische Aufgaben:** Ausgaben vorhersagen, Speicher-/Referenzdiagramme zeichnen, eine Klassenmethode wie `join`, `reverse`, `max`, `count` oder `parse` schreiben, Parameterübergabe skizzieren.

## Thema 2 - Klassen und Objekte {#themenliste-2}

**Relevant:** Objektbegriff, Klassenbegriff, Datenkomponenten/Methoden, Konstruktoren, `this`, constructor chaining mit `this(...)`, Geheimnisprinzip, `private` vs. `public`, einfache Klassenimplementierung.

**Typische Aufgaben:** Klasse für Punkt, Farbe, Bruchzahl, Dreieck, Stack oder Polygon entwerfen; Konstruktoren und Methoden implementieren; invariantenbewusst programmieren.

## Thema 3 - Objektorientierte Programmierung {#themenliste-3}

**Relevant:** Vererbung, Faktorisierung, Überschreiben vs. Überladen, `super`, Konstruktoren bei Vererbung, `Object`, `toString`, `equals`, `hashCode`, Polymorphismus, statischer/dynamischer Typ, dynamische Bindung, abstrakte Klassen, Interfaces, `instanceof` und Casts, Nachbilden von Mehrfachvererbung.

**Typische Aufgaben:** Code-Tracing mit dynamischer Bindung, Vererbungsfragen erklären, `equals/hashCode` implementieren, UML lesen/zeichnen, abstrakte Klasse vs. Interface begründen.

## Thema 4 - Datenorientierter Systementwurf / ATG {#themenliste-4}

**Relevant:** Grammatiknotation, Terminalsymbole/Terminalklassen, Nichtterminale, EBNF-Operatoren, LL(1)-Bedingung, Umformen nicht-LL(1)-konformer Regeln, attributierte Grammatiken, Eingangs-/Ausgangsattribute, semantische Aktionen.

**Nicht relevant im Detail:** vollständige Parser-/Interpreter-Implementierung.

**Typische Aufgaben:** Eine Grammatik/ATG für ein kleines Textformat entwickeln; `number` und `ident` als Terminalklassen beschreiben; LL(1)-Probleme erkennen und Regeln umschreiben.

## Thema 5 - Ausnahmebehandlung {#themenliste-5}

**Relevant:** Exception-Objekte, Exception-Hierarchie, `try`/`catch`/`finally`, checked vs. unchecked Exceptions, `throws`, Catch-Reihenfolge, `finally`-Ablauf, eigene Exceptions, Eingabevalidierung.

**Typische Aufgaben:** Ausgabe eines Codefragments bestimmen; entscheiden, ob `throws` nötig ist; robuste Methode mit Validierung schreiben.

## Thema 6 - Pakete, Generics und Java-Bibliothek {#themenliste-6}

**Relevant:** Pakete, Sichtbarkeit über Paketgrenzen, `public`, `import`, wichtige Bibliotheksklassen/-methoden, insbesondere Konvertierungsmethoden wie `Integer.parseInt`.

**Reduziert:** Generische Typen kommen laut Klausurinfo nicht bzw. nur minimal.

## Thema 7 - Hashing-basierte Suche {#themenliste-7}

**Relevant:** Hashing-Idee, Hashcodes, Kollisionen, warum Kollisionen unvermeidbar sind, Kollisionsbehandlung durch Verkettung und offene Adressierung, Lastfaktor/Füllstand, gute Hashfunktion, Zusammenhang mit `equals/hashCode`.

## Thema 8 - Heap-Datenstruktur {#themenliste-8}

**Relevant:** Priority Queue, kompletter Binärbaum, Feld-Baum-Abbildung mit freier Position 0, Heap-Eigenschaft, `swim`, `sink`, `insert`, `removeMax`, Fehler in Heap erkennen und beheben.

**Nicht relevant:** Heapsort.

## Thema 9 - Graphen {#themenliste-9}

**Relevant:** Graphbegriffe, gerichtete Graphen, Grad/Eingangsgrad/Ausgangsgrad, Weg/Zyklus/Zusammenhang, Adjazenzmatrix vs. Adjazenzliste, einfache Java-Methoden auf Adjazenzlisten.

## Thema 10 - Backtracking {#themenliste-10}

**Nicht prüfungsrelevant.** Wird vollständig ausgelassen.

## Thema 11 - Objektorientierter Entwurf {#themenliste-11}

**Relevant:** Textanalyse für ersten Klassenentwurf, UML-Klassendiagramme lesen/zeichnen, Klassen/Methoden/Datenkomponenten identifizieren, Beziehungen, Faktorisierung, Composite Pattern.

**Reduziert:** andere Design Patterns werden nicht vertieft.

# 3. Detailliertes Inhaltsverzeichnis für das Gesamtskript {#kapitelplan}

## Kapitel 1 - Einführung in Java {#kapitelplan-1}

**Relevante Dateien/Folien:** `01 Einführung in Java (V 11.1).pdf`, `PRO_Klausurinfo.md`, `KLA_PRO2_2025.pdf` Aufgaben 1 und 2.

**Klausurwichtige Konzepte:** Java = Sprache + JVM + Bibliothek; Bytecode; statische Typisierung; primitive vs. Referenztypen; Strings; Defaultwerte; lokale Variablen; Klassenmethoden; call-by-value; Felder.

**Typische Fragen:**

- Warum ist Java robuster als eine einfache statisch typisierte Sprache ohne Exception-Konzept?
- Was ist der Unterschied zwischen `s == p` und `s.equals(p)`?
- Was passiert bei `int[] b = a; b[5] = 2;`?
- Warum kann eine Methode ein Array-Inhalt ändern, aber nicht die Variable des Aufrufers auf ein anderes Array „umhängen“?

## Kapitel 2 - Klassen und Objekte {#kapitelplan-2}

**Relevante Dateien/Folien:** `02 Klassen und Objekte.pdf`, `PRO_Klausurinfo.md`, `KLA_PRO2_2025.pdf` Aufgabe 5.

**Klausurwichtige Konzepte:** Objekt als Daten + Operationen; Klasse als Bauplan; Konstruktoren; `this`; constructor chaining; `private` ist klassenbezogen; einfache Klassen implementieren.

**Typische Fragen:**

- Implementieren Sie eine Klasse `Rational` mit Konstruktor und Multiplikation.
- Welche Unterschiede haben Objektmethode und Klassenmethode?
- Warum schützt `private` nicht vor Zugriffen durch andere Objekte derselben Klasse?

## Kapitel 3 - Objektorientierte Programmierung {#kapitelplan-3}

**Relevante Dateien/Folien:** `03 OOP (V 11.1).pdf`, `PRO_Klausurinfo.md`, `KLA_PRO2_2025.pdf` Aufgabe 6.

**Klausurwichtige Konzepte:** Vererbung, Faktorisierung, Überschreiben, Überladen, `super`, `Object`, `equals/hashCode`, Polymorphismus, dynamische Bindung, abstrakte Klassen, Interfaces.

**Typische Fragen:**

- Welche Methode wird bei dynamischer Bindung aufgerufen?
- Warum benötigt `equals(Object o)` meist `instanceof` und Cast?
- Wie kann Java Mehrfachvererbung nachbilden?

## Kapitel 4 - Attributierte Grammatiken {#kapitelplan-4}

**Relevante Dateien/Folien:** `04 ATG.pdf`, `PRO_Klausurinfo.md`, `KLA_PRO2_2025.pdf` Aufgabe 4.

**Klausurwichtige Konzepte:** Grammatiknotation, Terminalklassen, LL(1), attributierte Grammatik, semantische Aktionen, einfache Transformationen von Eingabedatenströmen.

**Typische Fragen:**

- Ist die Regel `B = C | C "." C.` LL(1)-tauglich? Falls nein: umformen.
- Beschreiben Sie `ident` und `number` sprachlich oder per Regex.
- Entwickeln Sie eine ATG, die eine Zähl- oder Summenaufgabe löst.

## Kapitel 5 - Ausnahmebehandlung {#kapitelplan-5}

**Relevante Dateien/Folien:** `05 Ausnahmebehandlung.pdf`, `PRO_Klausurinfo.md`, `KLA_PRO2_2025.pdf` Aufgabe 7.

**Klausurwichtige Konzepte:** Exception-Hierarchie, checked/unchecked, `try`/`catch`/`finally`, `throw`, `throws`, Catch-Reihenfolge.

**Typische Fragen:**

- Welche Ausgabe erzeugt ein Codefragment mit `try`, mehreren `catch` und `finally`?
- Muss eine Methode `throws IOException` deklarieren?
- Welche Validierung gehört in public Methoden?

## Kapitel 6 - Pakete, Generics und Bibliothek {#kapitelplan-6}

**Relevante Dateien/Folien:** `06 Java-Bibliothek.pdf`, `PRO_Klausurinfo.md`.

**Klausurwichtige Konzepte:** Paketgrenzen, `public`, Import, Java-Bibliothek, `Integer.parseInt`; Generics nur minimal.

**Typische Fragen:** Sichtbarkeit über Paketgrenzen, richtige Verwendung einfacher Bibliotheksmethoden.

## Kapitel 7 - Hashing {#kapitelplan-7}

**Relevante Dateien/Folien:** `07 Hashing.pdf`, `PRO_Klausurinfo.md`.

**Klausurwichtige Konzepte:** Hashfunktion, Kollision, Verkettung, offene Adressierung, Lastfaktor, gute Hashfunktion.

**Typische Fragen:** Warum sind Kollisionen unvermeidbar? Wann ist Suche annähernd `O(1)`? Wie implementiert man `hashCode` passend zu `equals`?

## Kapitel 8 - Heap {#kapitelplan-8}

**Relevante Dateien/Folien:** `08 Heap.pdf`, `PRO_Klausurinfo.md`, `KLA_PRO2_2025.pdf` Aufgabe 3.

**Klausurwichtige Konzepte:** Heap als kompletter Binärbaum im Feld, Index 0 frei, Heap-Ordnung, `swim`, `sink`.

**Typische Fragen:** Feld zu Baum zeichnen; Baum zu Feld zeichnen; verletzte Heap-Ordnung finden und beheben.

## Kapitel 9 - Graphen {#kapitelplan-9}

**Relevante Dateien/Folien:** `09 Graphen.pdf`, `PRO_Klausurinfo.md`.

**Klausurwichtige Konzepte:** Graphbegriffe, gerichtete Graphen, Adjazenzlistenrepräsentation, einfache Methoden.

**Typische Fragen:** Methode `addEdge`, `removeEdge`, `outdegree`, `indegree`, `reverse` skizzieren.

## Kapitel 11 - Objektorientierter Entwurf {#kapitelplan-11}

**Relevante Dateien/Folien:** `11 OO Entwurf.pdf`, `PRO_Klausurinfo.md`.

**Klausurwichtige Konzepte:** UML lesen/zeichnen, Klassen aus Text identifizieren, Faktorisierung, Composite Pattern.

**Typische Fragen:** Aus einer Aufgabenbeschreibung einen ersten Klassenentwurf ableiten; Klassenhierarchie und Beziehungen als UML skizzieren.

\newpage

# Kapitel 1 - Einführung in Java {#kapitel-1}

[Zurück zur Kapitelübersicht](#kapitelplan)

## 1.1 Klausurfokus {#kapitel-1-fokus}

Dieses Kapitel ist vor allem relevant für kurze Verständnisfragen und kleine Codingaufgaben. Besonders klausurnah sind:

- Unterschied zwischen Java und Pascal bzw. klassisch kompilierten Sprachen,
- statische Typisierung und Fehlererkennung durch den Compiler,
- Robustheit durch Laufzeitprüfungen und Ausnahmebehandlung,
- primitive Typen vs. Referenztypen,
- Zeichenkettenvergleich,
- Defaultwerte und lokale Variablen,
- Klassenmethoden und Parameterübergabe,
- Felder, insbesondere Referenzen und Alias-Effekte.

Die Beispielklausur enthält genau diese Richtung: Array-Strukturen zeichnen, eine `join`-Methode schreiben und Parameterübergabe erklären.

## 1.2 Java als Ausführungsmodell: Quelltext, Bytecode, JVM {#kapitel-1-bytecode}

Java besteht nicht nur aus der Programmiersprache. Für die Klausur ist wichtig, Java als Kombination aus **Sprache, virtueller Maschine und Bibliothek** zu verstehen.

```text
Java-Quelltext (.java)
      ↓ Compiler javac
Java-Bytecode (.class)
      ↓ Java Virtual Machine
Maschinenausführung auf konkretem Rechner
```

Der Compiler übersetzt Java-Quelltext nicht direkt in nativen Maschinencode für genau einen Prozessor, sondern in **Bytecode**. Dieser Bytecode wird von der **Java Virtual Machine (JVM)** ausgeführt. Dadurch ist Java architekturneutraler und portabler: derselbe Bytecode kann auf verschiedenen Plattformen laufen, solange dort eine passende JVM vorhanden ist.

![Vom Quellcode zur Programmausführung. Quelle: 01 Einführung in Java, Folie 9.](pro2_assets/fig01_java_ausfuehrung.png){width=85%}

**Prüfungsverständnis:**

- Pascal wurde in den Grundlagen oft als Beispiel für eine klassisch kompilierte Sprache betrachtet: Quellcode wird in maschinennahen Code übersetzt.
- Java trennt stärker zwischen Kompilierung und Ausführung: Der Compiler erzeugt Bytecode; die JVM führt Bytecode aus.
- Beide Sprachen sind statisch typisiert: Der Typ eines Ausdrucks/Objekts ist zur Übersetzungszeit kontrollierbar.

## 1.3 Statische Typisierung und Robustheit {#kapitel-1-typisierung}

**Statisch typisiert** bedeutet: Jede Variable, jeder Ausdruck und jede Methode hat einen Typ, der vom Compiler geprüft wird. Dadurch erkennt der Compiler viele Fehler vor dem Start des Programms.

Beispiele:

```java
int x = 3;
String s = "Hallo";
x = s;              // Compilerfehler: String passt nicht in int
```

Java ist zusätzlich robust, weil viele gefährliche Situationen zur Laufzeit definiert behandelt werden:

- Zugriff auf Array-Index außerhalb der Grenzen löst eine Exception aus.
- Division durch 0 bei Integer-Werten löst eine `ArithmeticException` aus.
- `null`-Zugriff löst eine `NullPointerException` aus.
- Es gibt automatische Speicherbereinigung statt manuellem `delete`.
- Ausnahmebehandlung ermöglicht kontrolliertes Reagieren auf Fehler. Mehr dazu in [Kapitel 5](#kapitel-5).

**Klausurformulierung:** Wenn gefragt wird, ob Java oder Pascal robuster ist, ist die erwartete Richtung: Java, insbesondere wegen Ausnahmebehandlung, Laufzeitprüfungen und automatischer Speicherbereinigung. Statische Typisierung allein haben beide.

## 1.4 Primitive Typen vs. Referenztypen {#kapitel-1-typen}

Java unterscheidet zwischen primitiven Typen und Referenztypen.

**Primitive Typen** speichern den Wert direkt:

```java
int a = 5;
boolean ok = true;
char c = 'x';
```

**Referenztypen** speichern eine Referenz auf ein Objekt oder Array am Heap:

```java
String s = "Hallo";
int[] a = new int[7];
Rational r = new Rational(1, 2);
```

Das ist entscheidend für viele Klausuraufgaben. Eine Variable vom Typ `int[]` enthält nicht das ganze Array, sondern eine Referenz auf das Array.

```java
int[] a = new int[7];
int[] b = a;
a[3] = 1;
b[5] = 2;
```

Nach diesen Anweisungen zeigen `a` und `b` auf dasselbe Array. Deshalb stehen im einen Array an Index 3 der Wert `1` und an Index 5 der Wert `2`. Es gibt **kein zweites Array**.

## 1.5 Defaultwerte und lokale Variablen {#kapitel-1-defaultwerte}

Bei Arrays und Objekt-Datenkomponenten gibt es Defaultwerte. Lokale Variablen sind dagegen nicht automatisch sinnvoll initialisiert.

| Ort / Art | Initialisierung |
|---|---|
| `int[] a = new int[5]` | alle Elemente `0` |
| `boolean[] b = new boolean[5]` | alle Elemente `false` |
| `String[] s = new String[5]` | alle Elemente `null` |
| Datenkomponente `private int x;` | `0` |
| lokale Variable `int x;` | nicht verwendbar, bis explizit initialisiert |

![Felder werden beim Erzeugen mit Defaultwerten initialisiert. Quelle: 01 Einführung in Java, Folie 67.](pro2_assets/fig02_felder_defaultwerte.png){width=85%}

**Typischer Fehler:**

```java
public static int f(boolean b) {
    int x;
    if (b) {
        x = 1;
    }
    return x;       // Compilerfehler: x ist eventuell nicht initialisiert
}
```

Der Compiler verlangt, dass lokale Variablen auf jedem möglichen Ausführungspfad initialisiert sind.

## 1.6 Zeichenketten: Referenzvergleich vs. Inhaltsvergleich {#kapitel-1-strings}

`String` ist ein Referenztyp. Deshalb muss man zwei Ebenen unterscheiden:

```java
String s = "Hallo";
String p = "Hallo";
```

- `s == p` vergleicht Referenzen: Zeigen beide Variablen auf dasselbe Objekt?
- `s.equals(p)` vergleicht Inhalte: Haben beide Strings dieselbe Zeichenfolge?

**Robustheitsfalle:**

```java
if (s.equals(p)) { ... }
```

Dieser Ausdruck ist korrekt, falls `s != null`. Falls `s == null`, führt der Methodenaufruf zu einer `NullPointerException`.

Robuster ist oft:

```java
if (p != null && p.equals(s)) { ... }
```

oder bei Vergleich mit Konstante:

```java
if ("Hallo".equals(s)) { ... }
```

**Klausurpunkt:** `s == p` ist nicht „falsch“ im Sinn eines Laufzeitfehlers. Es ist robust gegen `null`, prüft aber nur Referenzgleichheit, nicht Inhaltsgleichheit.

Siehe dazu auch [`equals(Object o)` in Kapitel 3](#kapitel-3-object), wo die Methode für eigene Klassen überschrieben wird.

## 1.7 Eingabe, Konvertierung und `Integer.parseInt` {#kapitel-1-eingabe}

Eingabe kommt häufig als Zeichenkette. Soll daraus eine Zahl werden, wird konvertiert:

```java
String line = IO.readln("Zahl = ");
int value = Integer.parseInt(line);
```

`Integer.parseInt` ist klausurrelevant. Es darf verwendet werden und sollte bekannt sein. Die Methode kann eine `NumberFormatException` auslösen, wenn der Text keine gültige ganze Zahl enthält.

```java
int a = Integer.parseInt("42");      // 42
int b = Integer.parseInt("abc");     // NumberFormatException
```

Die Exception-Seite dazu steht in [Kapitel 5](#kapitel-5).

## 1.8 Anweisungen und Kontrollfluss {#kapitel-1-anweisungen}

Die grundlegenden Anweisungen aus PRO1 bleiben relevant, aber meist eingebettet in Java-Code:

```java
if (x > 0) {
    IO.println("positiv");
} else {
    IO.println("nicht positiv");
}

for (int i = 0; i < a.length; i++) {
    IO.println(a[i]);
}

while (i < a.length && a[i] != value) {
    i++;
}
```

Für eine sehr gute Note ist wichtig, Schleifen nicht nur syntaktisch zu können, sondern **Invarianten** und Grenzen sauber zu behandeln:

- Beginnt der Index bei `0`?
- Ist die Abbruchbedingung `< a.length` und nicht `<= a.length`?
- Wird `null` korrekt übersprungen?
- Wird ein Trennzeichen nur zwischen Elementen geschrieben und nicht am Ende?

## 1.9 Klassenmethoden und Aufbau einer Methode {#kapitel-1-klassenmethoden}

Eine Klassenmethode ist mit `static` deklariert und wird auf der Klasse aufgerufen:

```java
public static int max(int a, int b) {
    return (a > b) ? a : b;
}

int m = Math.max(3, 7);
```

Eine Methode besteht aus:

- Rückgabetyp,
- Name,
- Parameterliste,
- Rumpf,
- optionalem `return`.

```java
public static int gcd(int p, int q) {
    int r = p % q;
    while (r != 0) {
        p = q;
        q = r;
        r = p % q;
    }
    return q;
}
```

**Überladen** bedeutet: mehrere Methoden haben denselben Namen, aber verschiedene Parameterlisten.

```java
public static int max(int a, int b) { ... }
public static int max(int a, int b, int c) { ... }
public static double max(double a, double b) { ... }
```

Der Compiler entscheidet anhand der Argumenttypen, welche Methode gemeint ist.

## 1.10 Parameterübergabe: Java verwendet call-by-value {#kapitel-1-call-by-value}

Java übergibt Parameter immer **by value**. Das gilt auch bei Referenztypen. Entscheidend ist: Bei Referenztypen wird der Referenzwert kopiert.

### Primitive Werte

```java
public static void swap(int a, int b) {
    int t = a;
    a = b;
    b = t;
}

int x = 1;
int y = 2;
swap(x, y);
// x == 1, y == 2
```

`swap` vertauscht nur die lokalen Kopien `a` und `b`.

### Referenzen auf unveränderliche Objekte wie `String`

```java
public static void swap(String a, String b) {
    String t = a;
    a = b;
    b = t;
}
```

Auch hier werden nur die lokalen Referenzkopien vertauscht. Die Variablen des Aufrufers ändern sich nicht.

### Arrays

```java
public static void swapFirst(int[] a, int[] b) {
    int t = a[0];
    a[0] = b[0];
    b[0] = t;
}
```

Hier werden zwar die Referenzen selbst nur kopiert, aber beide Kopien zeigen auf dieselben Array-Objekte wie beim Aufrufer. Deshalb ändern sich die Array-Inhalte.

**Merksatz:** Eine Methode kann nicht die Variable des Aufrufers neu binden, aber sie kann über eine kopierte Referenz das referenzierte Objekt verändern.

## 1.11 Felder: Erzeugen, Zugriff, Referenzen {#kapitel-1-felder}

Felder sind Objekte am Heap. Die Feldvariable enthält eine Referenz.

```java
int[] a = new int[5];
a[0] = 10;
a[4] = 20;
IO.println(a.length);      // 5
```

Zugriffe werden zur Laufzeit geprüft:

```java
a[-1] = 3;       // ArrayIndexOutOfBoundsException
a[5] = 3;        // ArrayIndexOutOfBoundsException
```

### Referenzdiagramme verstehen

```java
String s = "Hallo";
String[] a = new String[5];
a[0] = s;
a[2] = s;
a[4] = a[0] + "Hallo";
```

Nachher gilt:

- `a[0]` und `a[2]` referenzieren dasselbe String-Objekt wie `s`.
- `a[1]` und `a[3]` sind `null`.
- `a[4]` referenziert ein neues String-Objekt mit Inhalt `"HalloHallo"`.
- `a[0] == a[2]` ist sehr wahrscheinlich `true`, weil beide dieselbe Referenz aus `s` erhalten haben.
- `a[4].equals("HalloHallo")` ist `true`.

## 1.12 Klausurnahe Methode: `join` {#kapitel-1-join}

Eine typische Aufgabe ist die Implementierung einer Klassenmethode, die ein Array verarbeitet. Beispiel aus der Klausurform:

```java
String[] words = {"Eins", "Zwei", null, "Drei"};
String result = join(words, ',');
IO.println(result);       // Eins,Zwei,Drei
```

Eine saubere Lösung:

```java
public static String join(String[] text, char delimiter) {
    String result = "";
    boolean first = true;

    for (int i = 0; i < text.length; i++) {
        if (text[i] != null) {
            if (!first) {
                result = result + delimiter;
            }
            result = result + text[i];
            first = false;
        }
    }

    return result;
}
```

Warum ist `first` wichtig? Das Trennzeichen soll **zwischen** den gültigen Elementen stehen, nicht am Anfang und nicht am Ende. `null`-Elemente sollen übersprungen werden.

Alternative mit `StringBuilder`:

```java
public static String join(String[] text, char delimiter) {
    StringBuilder result = new StringBuilder();

    for (int i = 0; i < text.length; i++) {
        if (text[i] != null) {
            if (result.length() > 0) {
                result.append(delimiter);
            }
            result.append(text[i]);
        }
    }

    return result.toString();
}
```

Die erste Variante ist für Papierklausuren oft einfacher. Die zweite ist effizienter, weil nicht bei jeder Verkettung ein neuer String entsteht.

## 1.13 Mini-Check Kapitel 1 {#kapitel-1-check}

1. Zeichne die Speicherstruktur nach:

```java
int[] a = new int[7];
int[] b = a;
a[3] = 1;
b[5] = 2;
```

2. Erkläre den Unterschied:

```java
s == p
s.equals(p)
```

3. Was gibt folgender Code aus?

```java
public static void m(int[] a) {
    a[0] = 99;
    a = new int[3];
    a[0] = 42;
}

int[] x = new int[2];
m(x);
IO.println(x[0]);
```

**Lösungsidee:** Ausgabe `99`, weil nur der lokale Parameter `a` auf ein neues Array gesetzt wird. Das ursprüngliche Array wurde vorher aber verändert.

\newpage

# Kapitel 2 - Klassen und Objekte {#kapitel-2}

[Zurück zur Kapitelübersicht](#kapitelplan)

## 2.1 Klausurfokus {#kapitel-2-fokus}

Hier geht es um das Implementieren kleiner Klassen. Aus der Klausurinfo sind besonders wichtig:

- einfache Klassen mit Konstruktor und Methoden,
- Konstruktor ruft anderen Konstruktor mit `this(...)` auf,
- `private` und `public` sauber unterscheiden,
- `private` bezieht sich auf die Klasse, nicht nur auf ein Objekt,
- objektorientierte statt unnötig statische Lösung wählen.

## 2.2 Objekt und Klasse {#kapitel-2-objekt-klasse}

Ein Objekt ist eine Laufzeitkomponente mit:

- Datenkomponenten, also Zustand,
- Methoden, also Operationen auf diesem Zustand.

Eine Klasse ist der Bauplan für solche Objekte.

```java
public class Point {
    private int x;
    private int y;

    public Point(int x, int y) {
        this.x = x;
        this.y = y;
    }

    public void moveBy(int dx, int dy) {
        x = x + dx;
        y = y + dy;
    }
}
```

Die Objektvariable enthält wieder nur eine Referenz:

```java
Point p = new Point(3, 4);
```

`new Point(3, 4)` erzeugt ein Objekt. `p` referenziert dieses Objekt.

## 2.3 Datenkapselung und Geheimnisprinzip {#kapitel-2-geheimnis}

Das Geheimnisprinzip besagt: Der direkte Zugriff auf den inneren Zustand eines Objekts soll verhindert werden. Von außen soll man nur über die öffentliche Schnittstelle arbeiten.

![Geheimnisprinzip und Zugriff über öffentliche Methoden. Quelle: 02 Klassen und Objekte, Folie 16.](pro2_assets/fig03_geheimnisprinzip.png){width=85%}

```java
public class Account {
    private int balance;

    public void deposit(int amount) {
        if (amount > 0) {
            balance = balance + amount;
        }
    }

    public int getBalance() {
        return balance;
    }
}
```

Warum nicht `public int balance;`? Weil dann jeder fremde Code beliebige, auch ungültige Zustände erzeugen könnte:

```java
account.balance = -1_000_000;     // bei public möglich, fachlich unsinnig
```

## 2.4 `private` ist klassenbezogen {#kapitel-2-private}

Ein häufiger Denkfehler ist: `private` bedeute „nur dieses Objekt darf zugreifen“. In Java bedeutet es aber: **nur Code innerhalb derselben Klasse darf zugreifen**. Dieser Code darf auch auf private Komponenten anderer Objekte derselben Klasse zugreifen.

```java
public class Point {
    private int x;
    private int y;

    public boolean samePosition(Point other) {
        return this.x == other.x && this.y == other.y;
    }
}
```

`other.x` ist erlaubt, weil der Code in der Klasse `Point` steht.

## 2.5 Konstruktoren und `this` {#kapitel-2-konstruktoren}

Ein Konstruktor initialisiert ein Objekt beim Erzeugen.

```java
public class Rectangle {
    private int x;
    private int y;
    private int width;
    private int height;

    public Rectangle(int x, int y, int width, int height) {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
    }
}
```

`this` bezeichnet das aktuelle Empfängerobjekt. Es ist besonders wichtig, wenn Parameter gleich heißen wie Datenkomponenten.

### Constructor chaining

Ein Konstruktor kann einen anderen Konstruktor derselben Klasse mit `this(...)` aufrufen. Der Aufruf muss die erste Anweisung im Konstruktor sein.

```java
public class Rectangle {
    private int x;
    private int y;
    private int width;
    private int height;

    public Rectangle(int width, int height) {
        this(0, 0, width, height);
    }

    public Rectangle(int x, int y, int width, int height) {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
    }
}
```

**Klausurpunkt:** Konstruktoren dürfen überladen werden. `this(...)` vermeidet Codeverdopplung bei Initialisierung.

## 2.6 Objektmethoden vs. Klassenmethoden {#kapitel-2-methoden-static}

Eine **Objektmethode** arbeitet auf einem konkreten Objekt und hat implizit `this`.

```java
r.moveBy(3, 5);
```

Eine **Klassenmethode** ist `static` und gehört zur Klasse, nicht zu einem Objekt.

```java
int x = Math.max(3, 5);
```

Für fachliche Datentypen ist eine Objektmethode oft die bessere OO-Lösung:

```java
public Rational multiply(Rational other) {
    return new Rational(this.nom * other.nom, this.denom * other.denom);
}
```

Eine rein statische Lösung ist manchmal möglich, aber weniger objektorientiert:

```java
public static Rational multiply(Rational r1, Rational r2) {
    return new Rational(r1.nom * r2.nom, r1.denom * r2.denom);
}
```

## 2.7 Beispielklasse `Rational` {#kapitel-2-rational}

Eine klausurnahe Klasse für rationale Zahlen:

```java
public class Rational {
    private int nom;
    private int denom;

    public Rational(int nom, int denom) {
        if (denom == 0) {
            throw new IllegalArgumentException("denom must not be 0");
        }
        this.nom = nom;
        this.denom = denom;
        normalizeSign();
    }

    public Rational multiply(Rational r) {
        return new Rational(this.nom * r.nom, this.denom * r.denom);
    }

    public void multiplyInPlace(Rational r) {
        this.nom = this.nom * r.nom;
        this.denom = this.denom * r.denom;
        normalizeSign();
    }

    private void normalizeSign() {
        if (denom < 0) {
            nom = -nom;
            denom = -denom;
        }
    }
}
```

**Verständnis:**

- `multiply` mit Rückgabe ist funktionaler: Das Original bleibt unverändert.
- `multiplyInPlace` verändert das aktuelle Objekt.
- Eine statische `multiply(r1, r2)`-Methode ist möglich, aber weniger objektorientiert, weil die Operation nicht als Nachricht an ein Rational-Objekt modelliert ist.

## 2.8 Invarianten und Validierung {#kapitel-2-invarianten}

Eine Invariante ist eine Bedingung, die für jedes gültige Objekt immer gelten soll.

Bei `Rational`:

```text
denom != 0
```

Bei `Color`:

```text
0 <= red, green, blue <= 255
```

Bei `Polygon`:

```text
0 <= size <= 100
```

Validierung ist besonders bei public Methoden wichtig, weil fremder Code sie mit ungültigen Werten aufrufen kann. Bei privaten Methoden kann man oft voraussetzen, dass sie nur kontrolliert aus der Klasse selbst aufgerufen werden. Wenn die Aufgabe ausdrücklich Validierung verlangt, muss sie eingebaut werden.

## 2.9 Mini-Check Kapitel 2 {#kapitel-2-check}

1. Warum ist `private` trotzdem mit `other.x` vereinbar, wenn `other` ein Objekt derselben Klasse ist?
2. Implementiere einen Konstruktor `Point()` der `Point(0, 0)` aufruft.
3. Was ist objektorientierter?

```java
r1.multiply(r2)
Rational.multiply(r1, r2)
```

**Lösungsidee:** `r1.multiply(r2)`, weil die Operation als Nachricht an ein Objekt modelliert ist.

\newpage

# Kapitel 3 - Objektorientierte Programmierung {#kapitel-3}

[Zurück zur Kapitelübersicht](#kapitelplan)

## 3.1 Klausurfokus {#kapitel-3-fokus}

Dieses Kapitel ist klausurstark. Rechnen muss man vor allem mit:

- Vererbung erklären,
- Überschreiben und Überladen unterscheiden,
- dynamische Bindung in Codebeispielen auswerten,
- `Object`-Methoden sinnvoll überschreiben,
- `equals` und `hashCode` korrekt zusammendenken,
- abstrakte Klassen und Interfaces unterscheiden,
- Mehrfachvererbung durch Interfaces nachbilden,
- UML-Grundnotation verstehen.

## 3.2 Vererbung und Faktorisierung {#kapitel-3-vererbung}

Vererbung erlaubt, Gemeinsamkeiten in eine Basisklasse zu ziehen. Das nennt man **Faktorisierung**.

```java
public class Person {
    private String name;

    public Person(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}

public class Student extends Person {
    private String id;

    public Student(String name, String id) {
        super(name);
        this.id = id;
    }
}
```

`Student` erbt die Eigenschaften und Methoden von `Person` und ergänzt die Matrikelnummer.

**Wozu?**

- Codeverdopplung vermeiden,
- gemeinsame Schnittstelle definieren,
- getesteten Code wiederverwenden,
- Systeme leichter erweitern.

## 3.3 Überschreiben vs. Überladen {#kapitel-3-overloading-overriding}

**Überladen**: gleicher Methodenname, andere Parameterliste. Entscheidung durch Compiler.

```java
void print(int x) { ... }
void print(String s) { ... }
```

**Überschreiben**: abgeleitete Klasse definiert eine Methode mit gleicher Signatur neu. Entscheidung bei Objektmethoden dynamisch zur Laufzeit.

```java
class A {
    void m() { IO.print("A"); }
}

class B extends A {
    @Override
    void m() { IO.print("B"); }
}
```

```java
A x = new B();
x.m();          // B
```

Warum? Statischer Typ von `x` ist `A`, dynamischer Typ ist `B`. Bei dynamischer Bindung entscheidet der dynamische Typ.

## 3.4 `super` und Konstruktoren bei Vererbung {#kapitel-3-super}

Ein Konstruktor der abgeleiteten Klasse muss die Basisklasse initialisieren. Das geschieht mit `super(...)`.

```java
public class ColoredRectangle extends Rectangle {
    private Color color;

    public ColoredRectangle(int x, int y, int w, int h, Color color) {
        super(x, y, w, h);
        this.color = color;
    }
}
```

`super(...)` muss die erste Anweisung im Konstruktor sein. Mit `super.m()` kann eine überschriebene Basismethode aufgerufen werden.

```java
@Override
public int hashCode() {
    return 31 * super.hashCode() + color.hashCode();
}
```

## 3.5 Polymorphismus: statischer und dynamischer Typ {#kapitel-3-polymorphismus}

Polymorphismus bedeutet: Eine Variable vom Typ einer Basisklasse kann Objekte der Basisklasse und aller abgeleiteten Klassen referenzieren.

![Statischer und dynamischer Datentyp. Quelle: 03 OOP, Folie 31.](pro2_assets/fig04_statischer_dynamischer_typ.png){width=85%}

```java
Shape s;
s = new Circle();
s.draw();
s = new Rectangle();
s.draw();
```

Der statische Typ ist `Shape`. Er bestimmt, welche Methoden der Compiler erlaubt. Der dynamische Typ ist zur Laufzeit `Circle` oder `Rectangle`. Er bestimmt, welche überschreibende Methode tatsächlich ausgeführt wird.

```java
Shape s = new Circle();
s.draw();       // erlaubt, wenn draw in Shape deklariert ist
s.radius();     // Compilerfehler, wenn radius nicht in Shape steht
```

## 3.6 Dynamische Bindung wirklich verstehen {#kapitel-3-dynamische-bindung}

Klausuraufgaben zur dynamischen Bindung sehen oft so aus:

```java
class A {
    void m1() { IO.print("A"); }
    void m2() { this.m1(); }
    void m3() { m1(); }
}

class B extends A {
    @Override
    void m1() { IO.print("B"); }
}
```

```java
A x = new B();
x.m2();
```

Ausgabe: `B`.

Warum? `x.m2()` ruft zwar die in `A` definierte Methode `m2` auf, aber innerhalb von `m2` ist `this` das tatsächliche `B`-Objekt. Der Aufruf `this.m1()` wird dynamisch gebunden und landet bei `B.m1()`.

**Merksatz:** Auch ein Methodenaufruf innerhalb einer Basisklassenmethode kann dynamisch an eine überschreibende Methode der abgeleiteten Klasse gebunden werden.

## 3.7 Klasse `Object`, `toString`, `equals`, `hashCode` {#kapitel-3-object}

Alle Klassen erben letztlich von `Object`. Besonders relevant sind:

```java
public String toString()
public boolean equals(Object obj)
public int hashCode()
```

### `toString`

```java
@Override
public String toString() {
    return "Color(r=%d,g=%d,b=%d)".formatted(red, green, blue);
}
```

`toString` wird oft automatisch verwendet, z. B. bei String-Verkettung.

### `equals(Object o)`

Eine saubere `equals`-Methode prüft:

1. Ist es dasselbe Objekt?
2. Hat das andere Objekt überhaupt den passenden Typ?
3. Stimmen alle gleichheitsrelevanten Daten überein?

```java
@Override
public boolean equals(Object o) {
    if (this == o) {
        return true;
    }
    if (!(o instanceof Color)) {
        return false;
    }
    Color other = (Color) o;
    return red == other.red
        && green == other.green
        && blue == other.blue;
}
```

Warum `instanceof` und Cast? Die Signatur lautet `equals(Object o)`, nicht `equals(Color o)`. Der Parameter kann also jedes Objekt oder `null` sein. Erst nach der Typprüfung darf man auf `red`, `green`, `blue` zugreifen.

### `hashCode`

Wenn `equals` überschrieben wird, muss `hashCode` passend dazu überschrieben werden. Gleiche Objekte müssen denselben Hashcode haben.

```java
@Override
public int hashCode() {
    int result = 17;
    result = 31 * result + red;
    result = 31 * result + green;
    result = 31 * result + blue;
    return result;
}
```

Die Multiplikation mit einer Primzahl wie `31` verteilt typische Werte besser als bloßes Addieren. Das wird in [Kapitel 7 Hashing](#kapitelplan-7) vertieft.

## 3.8 Abstrakte Klassen und Interfaces {#kapitel-3-abstrakt-interface}

Eine abstrakte Klasse kann nicht direkt instanziiert werden und kann abstrakte Methoden enthalten.

```java
public abstract class Shape {
    public abstract void draw();
}
```

Eine abgeleitete konkrete Klasse muss die abstrakten Methoden implementieren:

```java
public class Circle extends Shape {
    @Override
    public void draw() { ... }
}
```

Ein Interface beschreibt eine Schnittstelle. Klassen können mehrere Interfaces implementieren.

```java
public interface Drawable {
    void draw();
}

public interface Movable {
    void moveBy(int dx, int dy);
}

public class Sprite implements Drawable, Movable {
    public void draw() { ... }
    public void moveBy(int dx, int dy) { ... }
}
```

**Unterschied für die Klausur:** Eine abstrakte Klasse kann gemeinsamen Zustand und gemeinsame Implementierung bündeln. Interfaces dienen vor allem der gemeinsamen Schnittstelle und erlauben eine Form von Mehrfachtypisierung.

## 3.9 Nachbilden von Mehrfachvererbung {#kapitel-3-mehrfachvererbung}

Java erlaubt keine Mehrfachvererbung von Klassen:

```java
class C extends A, B { }       // nicht erlaubt
```

Aber eine Klasse kann mehrere Interfaces implementieren:

```java
class C extends A implements X, Y { ... }
```

Damit kann ein Objekt in mehreren Rollen auftreten:

```java
Drawable d = new Sprite();
Movable m = new Sprite();
```

Das ist häufig die gewünschte Lösung, wenn mehrere unabhängige Fähigkeiten modelliert werden sollen.

## 3.10 Typtest und Typumwandlung {#kapitel-3-instanceof}

Wenn der statische Typ zu allgemein ist, benötigt man manchmal einen Typcheck und Cast.

```java
Shape s = getShape();
if (s instanceof Circle) {
    Circle c = (Circle) s;
    c.radius();
}
```

Ohne `instanceof` kann ein falscher Cast zur `ClassCastException` führen. In `equals(Object o)` ist der Typcheck besonders wichtig, weil der Parameter laut Signatur jedes Objekt sein kann.

## 3.11 Mini-Check Kapitel 3 {#kapitel-3-check}

1. Was gibt folgender Code aus?

```java
class A {
    void m() { IO.print("A"); }
    void n() { m(); }
}
class B extends A {
    void m() { IO.print("B"); }
}
A x = new B();
x.n();
```

**Lösung:** `B`.

2. Warum ist `boolean equals(Color c)` kein korrektes Überschreiben von `Object.equals`?

**Lösung:** Andere Signatur. Es ist Überladen, nicht Überschreiben. Korrekt ist `boolean equals(Object o)`.

\newpage

# Kapitel 4 - Datenorientierter Systementwurf und ATG {#kapitel-4}

[Zurück zur Kapitelübersicht](#kapitelplan)

## 4.1 Klausurfokus {#kapitel-4-fokus}

ATG ist laut Klausurinfo sicher klausurrelevant. Nicht erwartet wird eine vollständige Parser-/Interpreter-Implementierung. Erwartet wird dagegen:

- Grammatiknotation sicher lesen und schreiben,
- Terminalklassen wie `number` und `ident` beschreiben,
- LL(1)-Bedingung prüfen,
- nicht-LL(1)-konforme Regeln umformen,
- Attribute und semantische Aktionen passend einsetzen,
- einfache ATG-Aufgaben entwickeln.

## 4.2 Denkmodell: strukturierter Eingabestrom wird transformiert {#kapitel-4-denkmodell}

Beim datenorientierten Systementwurf geht man von einem strukturierten Eingabedatenstrom aus. Zuerst wird seine Syntax beschrieben, dann seine Bedeutung und Verarbeitung.

Beispiele:

```text
Hotel Mühlviertlerhof: ****
Anna: ****
Marco: ******
```

oder:

```text
10 L (500,100,100)
20 C (700,300,100)(500,500,100)
E
```

Die typische Architektur besteht aus Scanner, Parser und Semantikauswerter.

![Referenzarchitektur datenorientierter Systeme: Scanner, Parser, Semantikauswerter. Quelle: 04 ATG, Folie 8.](pro2_assets/fig05_atg_grobarchitektur.png){width=85%}

Für die Klausur reicht meistens: Syntax erkennen, Attribute definieren und semantische Aktionen an den richtigen Stellen eintragen.

## 4.3 Grammatikgrundlagen {#kapitel-4-grammatik}

Eine Grammatik beschreibt gültige Sätze einer Sprache.

```text
Expr = Term { "+" Term }.
Term = Fact { "*" Fact }.
Fact = number | "(" Expr ")".
```

Wichtige Begriffe:

| Begriff | Bedeutung |
|---|---|
| Terminalsymbol | direktes Symbol im Eingabetext, z. B. `"+"`, `"("`, `"cm"` |
| Terminalklasse | Menge ähnlicher Terminals, z. B. `number`, `ident`, `digit` |
| Nichtterminal | syntaktische Kategorie, z. B. `Expr`, `Term`, `Fact` |
| Startsymbol | Nichtterminal, mit dem die Analyse beginnt |
| Alternative | Auswahl mit `|` |
| Option | null- oder einmal mit `[ ... ]` |
| Wiederholung | null- oder mehrmals mit `{ ... }` |

**Punkt nicht vergessen:** Regeln enden in der verwendeten Notation mit `.`

## 4.4 Terminalklassen beschreiben {#kapitel-4-terminalklassen}

Die Klausurinfo betont, dass Terminalklassen zumindest sprachlich oder mit Regex beschrieben werden können müssen.

Beispiele:

```text
digit  = "0" | "1" | ... | "9"
number = digit { digit }
ident  = letter { letter | digit }
```

Als Regex:

```text
number: [0-9]+
ident:  [A-Za-z][A-Za-z0-9]*
```

Wenn `cm`, `m` und `min` als Einheiten vorkommen, sind das **Terminalsymbole**, keine Nichtterminale:

```text
Unit = "cm" | "m" | "min".
```

## 4.5 LL(1)-Bedingung {#kapitel-4-ll1}

Für rekursiven Abstieg muss der Parser anhand des nächsten Eingabesymbols entscheiden können, welche Alternative zu wählen ist.

**LL(1)-Intuition:** In jeder Alternative müssen unterschiedliche Anfangsterminalsymbole möglich sein.

Problematisch:

```text
B = C | C "." C.
```

Beide Alternativen beginnen mit `C`. Mit nur einem Lookahead kann man nicht entscheiden, welche Alternative gemeint ist.

Umformung:

```text
B = C [ "." C ].
```

Jetzt wird zuerst `C` erkannt. Danach entscheidet das nächste Symbol, ob noch `"." C` folgt.

**Klausurstrategie:** Gemeinsamen Anfang herausziehen.

## 4.6 Attributierte Grammatiken {#kapitel-4-atg}

Eine kontextfreie Grammatik beschreibt nur die Syntax. Eine attributierte Grammatik ergänzt Werte und Aktionen.

Notation aus den Folien:

```text
Number ↑n = digit ↑d          (. n := d .)
           { digit ↑d         (. n := 10*n + d .) }.
```

- Ausgangsattribute (`↑`) werden berechnet und nach außen geliefert.
- Eingangsattribute (`↓`) werden von außen in ein Nichtterminal hineingegeben.
- Semantische Aktionen stehen an der Stelle, an der ihre Werte verfügbar sind.

## 4.7 Beispiel: Anzahl von Bewertungen zählen {#kapitel-4-beispiel-hotel}

Aufgabenformat ähnlich der Beispielklausur:

```text
Hotel Mühlviertlerhof: ****
Anna: ****
Marco: ******
Julia: ***
Thomas: *******
Herbert: *
```

Gesucht: Wie viele Gäste haben mindestens so viele Sterne vergeben wie das Hotel selbst?

Eine mögliche Grammatikstruktur:

```text
Ratings ↑count =
    "Hotel" ident ":" Stars ↑hotelStars
    { GuestRating ↓hotelStars ↑ok }      (. count := count + ok .)
    .

GuestRating ↓hotelStars ↑ok =
    ident ":" Stars ↑guestStars          (. ok := guestStars >= hotelStars ? 1 : 0 .)
    .

Stars ↑n =
    "*"                                  (. n := 1 .)
    { "*"                                (. n := n + 1 .) }
    .
```

Eine vollständig saubere ATG müsste die Initialisierung von `count` explizit setzen:

```text
Ratings ↑count =
    "Hotel" ident ":" Stars ↑hotelStars  (. count := 0 .)
    { GuestRating ↓hotelStars ↑ok        (. count := count + ok .) }
    .
```

**Verständnis:** `hotelStars` wird nach unten weitergegeben, weil jede Gästebewertung diesen Vergleichswert benötigt. `ok` kommt aus der einzelnen Gästebewertung zurück.

## 4.8 Typische Fehler bei ATG-Aufgaben {#kapitel-4-fehler}

1. **Terminalklassen vergessen:** `number` oder `ident` muss definiert oder beschrieben werden.
2. **Punkt am Ende der Regel vergessen.**
3. **LL(1)-Konflikt übersehen:** Alternativen beginnen gleich.
4. **Aktion zu früh:** Ein Wert wird verwendet, bevor er berechnet wurde.
5. **Eingangs-/Ausgangsattribute vertauscht:** Vergleichswert muss hinein, Ergebnis kommt heraus.
6. **Interpreter statt ATG:** Nicht unnötig Java-Parsercode schreiben, wenn eine Grammatik gefragt ist.

## 4.9 Mini-Check Kapitel 4 {#kapitel-4-check}

1. Warum ist folgende Regel nicht LL(1)-geeignet?

```text
A = ident | ident "=" number.
```

2. Forme sie um.

**Lösung:**

```text
A = ident [ "=" number ].
```

3. Beschreibe `number` als Terminalklasse.

**Lösung:** Eine nichtleere Folge von Ziffern, z. B. Regex `[0-9]+`.

\newpage

# Kapitel 5 - Ausnahmebehandlung {#kapitel-5}

[Zurück zur Kapitelübersicht](#kapitelplan)

## 5.1 Klausurfokus {#kapitel-5-fokus}

Ausnahmebehandlung ist klausurrelevant, aber oft in kleinen Tracing-Aufgaben. Man muss sicher wissen:

- Wann entsteht eine Exception?
- Welche `catch`-Klausel passt?
- Wird `finally` ausgeführt?
- Läuft das Programm danach weiter?
- Muss eine Exception mit `throws` deklariert werden?

## 5.2 Warum Exceptions? {#kapitel-5-motivation}

Ausnahmen treten auf, wenn während der Ausführung etwas Besonderes oder Fehlerhaftes passiert:

- Division durch 0,
- ungültiges Zahlenformat bei `Integer.parseInt`,
- Datei nicht gefunden,
- Zugriff auf `null`,
- Array-Index außerhalb der Grenzen.

Statt undefiniert weiterzulaufen, erzeugt Java ein Exception-Objekt und wirft es. Wird es nicht behandelt, wird es an die Aufrufer weitergereicht. Wenn niemand reagiert, bricht das Programm ab.

## 5.3 Exception-Hierarchie {#kapitel-5-hierarchie}

![Exception-Hierarchie. Quelle: 05 Ausnahmebehandlung, Folie 11.](pro2_assets/fig06_exception_hierarchie.png){width=85%}

Grob:

```text
Throwable
├─ Error
└─ Exception
   ├─ RuntimeException
   │  ├─ ArithmeticException
   │  ├─ NullPointerException
   │  └─ NumberFormatException
   └─ IOException
      └─ FileNotFoundException
```

- `RuntimeException` und Unterklassen sind unchecked.
- Viele andere `Exception`-Unterklassen sind checked und müssen behandelt oder deklariert werden.
- `Error` steht für schwere Fehler, die man normalerweise nicht behandelt.

## 5.4 `try`, `catch`, `finally` {#kapitel-5-try-catch-finally}

Grundform:

```java
try {
    // riskanter Code
} catch (NumberFormatException e) {
    // Behandlung
} catch (IOException e) {
    // Behandlung
} finally {
    // Abschlussarbeiten
}
```

Ablauf:

1. Der `try`-Block wird ausgeführt.
2. Wenn keine Exception entsteht, werden die `catch`-Blöcke übersprungen.
3. Wenn eine Exception entsteht, wird der erste passende `catch`-Block ausgeführt.
4. `finally` wird immer ausgeführt: ohne Exception, mit behandelter Exception und auch dann, wenn eine Exception weitergeworfen wird.
5. Nach `finally` geht es nur weiter, wenn keine unbehandelte Exception übrig ist.

## 5.5 Klausurtyp: Ausgabe bestimmen {#kapitel-5-ausgabe}

Beispiel:

```java
try {
    System.out.print("1");
    m();
    System.out.print("2");
} catch (NumberFormatException e) {
    System.out.print("3");
} catch (FileNotFoundException e) {
    System.out.print("4");
} finally {
    System.out.print("5");
}
System.out.print("6");
```

Fälle:

| Fall | Ausgabe | Erklärung |
|---|---|---|
| `m()` wirft keine Exception | `1256` | `try` vollständig, kein `catch`, dann `finally`, dann weiter |
| `m()` wirft `FileNotFoundException` | `1456` | nach `m()` springt Ausführung in passenden `catch`, dann `finally`, dann weiter |
| `m()` wirft `ArithmeticException` | `15` plus Programmabbruch | kein passender `catch`; `finally` läuft, danach wird Exception weitergeworfen; `6` wird nicht erreicht |

**Warum nicht `2`?** Sobald `m()` eine Exception wirft, wird der restliche `try`-Block übersprungen.

## 5.6 Checked vs. unchecked und `throws` {#kapitel-5-checked}

Unchecked Exceptions sind `RuntimeException` und Unterklassen. Sie müssen nicht in der Methodensignatur stehen.

```java
public static int div(int a, int b) {
    return a / b;       // ArithmeticException möglich, aber kein throws nötig
}
```

Checked Exceptions müssen behandelt oder deklariert werden.

```java
public static void readFile(String path) throws IOException {
    // Dateioperation, die IOException auslösen kann
}
```

Wenn eine Methode eine checked Exception nicht selbst abfängt, muss sie diese mit `throws` deklarieren.

## 5.7 `throw` und eigene Exceptions {#kapitel-5-throw}

Mit `throw` wird ein Exception-Objekt aktiv ausgelöst.

```java
if (denom == 0) {
    throw new IllegalArgumentException("denom must not be 0");
}
```

Eigene Exceptions können definiert werden, wenn ein fachlicher Fehler präzise modelliert werden soll.

```java
public class InvalidDigitException extends NumberFormatException {
    private final int position;

    public InvalidDigitException(int position) {
        super("invalid digit at position " + position);
        this.position = position;
    }

    public int getPosition() {
        return position;
    }
}
```

Für Klausuraufgaben reicht oft, vorhandene Exceptions sinnvoll zu verwenden, außer die Aufgabe verlangt explizit eine eigene Exception.

## 5.8 Eingabevalidierung bei Methoden {#kapitel-5-validierung}

Die Klausurinfo sagt sinngemäß: Wenn Eingangsparameter validiert werden sollen, steht es oft ausdrücklich dabei. Trotzdem gilt für gute Lösungen:

- Public Methoden sollten ungültige Eingaben nicht stillschweigend akzeptieren.
- Private Methoden können stärker auf interne Vorbedingungen vertrauen.
- Bei klarer Invariante sollte der Konstruktor validieren.

Beispiel:

```java
public Rational(int nom, int denom) {
    if (denom == 0) {
        throw new IllegalArgumentException("denom must not be 0");
    }
    this.nom = nom;
    this.denom = denom;
}
```

## 5.9 Mini-Check Kapitel 5 {#kapitel-5-check}

1. Wird `finally` ausgeführt, wenn im `try` eine nicht gefangene Exception entsteht?

**Ja.** Danach wird die Exception weitergereicht.

2. Muss `NumberFormatException` mit `throws` deklariert werden?

**Nein.** Sie ist eine `RuntimeException`.

3. Muss `IOException` mit `throws` deklariert oder gefangen werden?

**Ja**, wenn sie entstehen kann und nicht im selben Methodenrumpf behandelt wird.

# 4. Prüfungsstrategie für Themen 1-5 {#pruefungsstrategie-1-5}

Für eine sehr gute Note sollten diese Aufgabenarten aktiv geübt werden:

1. **Speicherbilder zeichnen:** Arrays, Strings, Objektvariablen, Aliasing.
2. **Kurze Methoden schreiben:** Schleifen sauber, `null` beachten, keine falschen Trennzeichen.
3. **Klassen implementieren:** Konstruktor, Datenkapselung, Objektmethoden, Invarianten.
4. **OOP-Code tracen:** statischer/dynamischer Typ, dynamische Bindung, `super`.
5. **ATG entwickeln:** Grammatik zuerst, Attribute danach, Aktionen an richtige Stellen.
6. **Exception-Abläufe tracen:** Was wird übersprungen? Welcher Catch? Läuft `finally`? Geht es danach weiter?

# 5. Checkliste gegen typische Punkteverluste {#checkliste}

- Bei `equals` immer Signatur `equals(Object o)` verwenden, nicht `equals(Color c)`.
- Bei `equals` `instanceof`/Typcheck vor Cast verwenden.
- Bei `hashCode` alle gleichheitsrelevanten Daten einbeziehen.
- Bei Strings Inhaltsvergleich mit `equals`, nicht versehentlich Referenzvergleich.
- Bei Arrays Alias-Effekte beachten: zwei Variablen können dasselbe Array referenzieren.
- Bei Konstruktorverkettung muss `this(...)` bzw. `super(...)` erste Anweisung sein.
- Bei ATG Terminalklassen beschreiben und Regelpunkt nicht vergessen.
- Bei LL(1) gemeinsame Präfixe herausziehen.
- Bei Exceptions: `finally` wird ausgeführt, aber danach geht es nur ohne unbehandelte Exception weiter.

# 6. Offene Arbeitsschritte {#offene-arbeitsschritte}

Dieser Zwischenstand enthält die vollständig ausgearbeiteten Themen 1-5. Noch zu ergänzen:

- Kapitel 6: Pakete, minimale Generics, Bibliotheksnutzung.
- Kapitel 7: Hashing.
- Kapitel 8: Heap-Datenstruktur ohne Heapsort.
- Kapitel 9: Graphen und Adjazenzlisten.
- Kapitel 11: Objektorientierter Entwurf, UML und Composite.
- Gesamtprüfung auf Redundanzen, fachliche Konsistenz, Klausurfilter und Hyperlinks.
- Finale ODT/PDF-Version mit allen Kapiteln.
