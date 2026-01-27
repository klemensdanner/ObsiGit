> [!note]
> Ablauforganisation = Aneinanderreihung systeminterner Elemente (Arbeitsabläufe) zur Zielerreichung

Zweck:
- Arbeitsvorgänge organisieren
- Verantwortlichkeiten formalisieren
	- hier eher nicht "Wer ist der Chef" sondern eher "was macht der Chef"
- Rationalisierung ermöglichen
- Standardisierung anstreben

# Prozess

Definitionen
![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=4&rect=47,119,766,445|SPE 109 ABO v.25.2, p.4]]

![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=4&rect=607,327,959,532|SPE 109 ABO v.25.2, p.4|300]]

## Gesteuerter Prozess vs. geregelter Prozess
![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=5&rect=29,43,821,514|SPE 109 ABO v.25.2, p.5]]

Beispiel:
- Stromheizer auf Stufe 2 ohne Termostat
	- heizt - egal wie heiß es ist
- mit Termostat
	- heißt, prüft ob es warm genug ist und ggf. heißt es weiter oder auch nicht

## Definierter vs. empirischer Prozess

### Definierter Prozess
- Aktivitäten vorab bekannt und verstanden
- Ergebnis vorhersehbar
- Prozess wiederholbar
- Beginn und Ende vorab festlegbar
Beispiel:
- schrittweise Verfeinerung
- Alltagsbeispiel: Auto bauen - man kann einen perfekten Plan haben, den man so umsetzen kann.


### Empirischer Prozess
- komplex und unvorhersehbar
- nicht vollständig verstanden
- nicht durchgehend definierbar

Beispiel: **iterativ-inkrementelles Adaptieren**
- **iterativ**: Bestehendes wird immer weiter verbessert
- **inkrementell**: Bestehendes wird um neue Funktionen erweitert
- **Adaptieren**: Anpassung
Alltagsbeispiel: - neue Art von Auto erfinden (z. B. autonom fahrend) - so komplex und unvorhersehbar dass man immer nur ein paar Schritte gehen kann.

> [!note]
> Auch empirische Prozesse können erfolgreich geregelt werden, selbst wenn sie nicht vollständig verstanden werden!

Im Autobeispiel heißt das, dass immer wieder die Funktionsweise überprüft wird, und die Verarbeitung wiederholt wird, bis das Auto tatsächlich autonom fährt.


Erfolgreiche Regelung durch: 
- häufige Inspektionen
- laufende Anpassung
- Trennung der Streuung der Eingabe von Störfaktoren


### Empirischer Softwareentwicklungsprozess

> Das ist die Übertragung der Theorie vom empirischen Prozess auf die Softwareentwicklung.

Ein großes Softwareprojekt ist komplex und unvorhersehbar --> empirischer Prozess. Wie arbeitet man an so einem Prozess?

- kontinuierlich planen
- frühzeitig realisieren, sobald genügend Anforderungen bekannt; „the art of the possible“
- keine Stabilität erwarten
- auf Änderungen von Anforderungen oder Rahmenbedingungen rasch reagieren

SW-Entwicklung soll ein geregelter Prozess sein.
Also:
> [!info]
> Rückkopplung durch Bewertung der Zwischenprodukte durch den Kunden ist entscheidend für den weiteren Projektverlauf (emergentes Verhalten) sowie die Ausrichtung des Produkts (Value-added Software Development).

Def.:
- emergentes Verhalten (flexibel reagieren auf die Wünsche des Kunden und den Projektverlauf davon abhängig machen)
- Value-added Software Development (Programmiert wird, was dem Kunden einen Nutzen bringt)

### Entwicklung der Prozessbedeutung

![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=11&rect=48,119,908,447|SPE 109 ABO v.25.2, p.11]]

- wertgenerierende Bedeutung
	- der agile Wendepunkt
	- der Wert für den Kunden steht im Vordergrund
	- Das Produkt steuert den Prozess


## Kernaufgaben der Ablauforganisation

**Aufgaben**:
- Prozesse in Gang setzen
- Prozesse analysieren
- Prozesse verbessern

> Prozesse sind produktbezogen (aus Projektsicht statisch) oder prozessbezogen (aus Projektsicht dynamisch).

#frage

#### Prozesse vs. Lebenszyklen
Es gibt unterschiedliche Sichtweisen darauf, wann ein Prozess beendet ist.

- **Projekt-Lebenszyklus**
	- Ordnung der zeitlichen Abfolge der Aktivitäten (von der Entwicklung bis zum Einsatz)
	- Analogie Haus: Hausbau ist mit Schlüsselübergabe abgeschlossen
- **Software-Lebenszyklus**
	- Ordnung der zeitlichen Abfolge der Aktivitäten (von der Entwicklung über den Einsatz bis zum Ende der Benutzung)
	- Analogie Haus: Haus-Prozess dauert vom Bau, über die Wartung bis zum Abriss.
- **Anwendungs-Lebenszyklus-Management** (Application Lifecycle Management; ALM)
	- Moderne Sicht – Trennung vor/nach Projektende wird unscharf (kontinuierliche Entwicklung und Freigabe während des gesamten Lebenszyklus des Produkts)
	- ständige Verbesserung gemeinsam mit dem Kunden
	- Analogie Haus: Das Haus wird ständig ausgebaut, ständiger Verbesserungsprozess

![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=14&rect=3,69,953,528|SPE 109 ABO v.25.2, p.14]]

> heutzutage verschwimmt der Bereich zwischen Produkt entwickeln und Produkt verwenden; es wird eher die Software immer weiter entwickelt


**Altes Vorgehensmodell**:
Dokumentation der Ablauforganisation -> wurde Ende der Neunziger Jahre immer umfangreicher
- alles wurde geplant, das kostete viel Zeit und ist wenig flexibel
- + kleine Anforderungen können sich ändern
Gegenbewegung war die agile Softwareentwicklung - flexibel, hin zur Kommunikation.

Das **neue Vorgehensmodell** ist die systematische Gliederung einer Lösung.
d.h.
- Projektmanager versuchen zunehmend, aus Prozesserfahrungen zu lernen.
- Prozessmuster (Patterns) sind bewährte Praktiken, die induktiv aus Prozesserfahrungen erarbeitet wurden.
- Es gibt auch Sammlungen von Negativbeispielen (Anti-Patterns).
- *man plant nicht alles bis ins letzte Detail, sondern kann durch Erfahrung auf neue Situationen reagieren*



![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=18&rect=24,36,827,528|SPE 109 ABO v.25.2, p.18]]

### Prozessorientiertes Vorgehen
Prozessmodell unterteilt Vorgehen in überschaubare Abschnitte:
![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=19&rect=45,58,831,445|SPE 109 ABO v.25.2, p.19]]


## Vorgehensmethoden

> Unterscheidung: Vorgehensprozesse werden durch Vorgehensmethoden umgesetzt.
> Oft Erfolg nur durch Kombination verschiedener Methoden!


### Sequenzielles Vorgehen
![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=22&rect=24,54,949,461|SPE 109 ABO v.25.2, p.22]]
Eins nach dem anderen, starr


### Inkrementelles Vorgehen - Wasserfallmodell
> inkrementell: funktionale Teilerweiterung, step by step

> kaum Flexibilität, Änderungswünsche teuer

![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=23&rect=26,44,945,528|SPE 109 ABO v.25.2, p.23]]


### Inkrementelles Vorgehen - Objektorientiertes Modell

> Es sollen, wenn möglich Liberies verwendet werden - diese werden selbst erstellt oder auch zugekauft und ermöglichen die Wiederverwendung von Code für verschiedene Projekte


![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=24&rect=30,51,953,528|SPE 109 ABO v.25.2, p.24]]


### Iteratives Vorgehen - kontinuierliche Verbesserung
> iterativ = wiederholte, schrittweise Verbesserung bereits vorhandener Funktionen

![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=26&rect=25,53,863,519|SPE 109 ABO v.25.2, p.26]]
Praxis: z.B. Suchfunktion
1. sie funktioniert
2. sie funktioniert auch bei Tippfehlern
3. sie funktioniert auch bei Tippfehlern schneller als je zuvor
4. usw.

Man versucht dabei also so schnell wie möglich ein Produkt zum Kunden zu bringen, um schnell herauszufinden, wo nachgebessert werden muss, bzw. ob der Kunde das so richtig gemeint hat.

> Motivation: Fehlerbehebungskosten steigen im Laufe der Projektentwicklung überproportional an.

D.h. je später man einen Fehler findet, desto teurer wird die Behebung.
#### Vorgehensmethoden - Iteratives Vorgehen

![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=28&rect=26,46,893,518|SPE 109 ABO v.25.2, p.28]]

> [!info]
> Daher macht man bei dieser Methode Prototyping. Im Speziellen: **Exploratives Prototyping**, um so schnell wie möglich Feedback zu erhalten, danach kommt eine neue Iteration.

![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=29&rect=30,83,738,518|SPE 109 ABO v.25.2, p.29]]

- Exploratives **revelationäres Prototyoing** (kommt von revail, aufdecken):
	- hierbei geht es vor allem um die Anforderungsklärung -- ein Prototyp, um herauszufinden, was der Kunde will
- Exploratives **experimentelles Prototyping**
	- technische Machbarkeit wird getestet



#### Vorgehensmethoden - Iteratives Vorgehen
![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=30&rect=28,42,948,523|SPE 109 ABO v.25.2, p.30]]


#### Spiralmodell (III): (rein) revolutionäres Prototyping

![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=33&rect=25,44,820,520|SPE 109 ABO v.25.2, p.33]]

#### Spiralmodell (IV): (rein) revolutionäres Prototyping

![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=34&rect=24,49,853,523|SPE 109 ABO v.25.2, p.34]]

#### Vorgehensmethoden – Iterativ-inkrementelles Vorgehen (I)

> Grundidee: Evolutionäres Vorgehen – Entwicklung in Zyklen, jeweils auf den Ergebnissen des vorherigen Zyklus aufbauend
> 
> Es ist also die Wiederholung (iterativ) von Erweiterungen (inkrimentell) - so zu sagen step-by-step development
> d.h. 1. Planung 2. Durchführung 3. Überprüfung 4. Zieladaptierung ist eine Iteration. Dann kommt ein neues Inkrement.




**iterativ-inkrementelles Adaptieren**
- **iterativ**: Bestehendes wird wiederholt verbessert (wiederholung)
- **inkrementell**: Bestehendes wird um neue Funktionen erweitert
- **Adaptieren**: Anpassung
Alltagsbeispiel: - neue Art von Auto erfinden (z. B. autonom fahrend) - so komplex und unvorhersehbar dass man immer nur ein paar Schritte gehen kann.

![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=35&rect=32,49,948,526|SPE 109 ABO v.25.2, p.35]]

### Iterativ-inkrementelles Vorgehen: Evolutionäres Prototyping

![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=36&rect=30,139,838,517|SPE 109 ABO v.25.2, p.36]]

#### Schablonenmodell
![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=37&rect=24,47,956,518|SPE 109 ABO v.25.2, p.37]]
> z.B. liberies verwenden!
> aber auch bewährte Lösungsstrategien im Kopf haben und anwenden können - man muss das Rad nicht neu erfinden



### Iterativ-inkrementelles Vorgehen: 1. Kunden-Integration
![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=38&rect=28,43,941,527|SPE 109 ABO v.25.2, p.38]]
Das war der XP-Hype um 2000, dabei aber zu große Kundennähe und Einmischung!

man braucht eine Pufferfunktion

![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=39&rect=32,55,803,511|SPE 109 ABO v.25.2, p.39]]

Dazu nimmt man einen Produktverantwortlichen, der mit dem AG kommuniziert

![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=40&rect=24,60,898,514|SPE 109 ABO v.25.2, p.40]]

 Das ist eine ideale Iteration:
1. Planung (gemeinsam mit Produktverantwortlichen und AG)
2. Durchführung (AN (Entwickler))
3. Überprüfung (AN (Entwickler))
4. Zieladaptierung (gemeinsam mit Produktverantwortlichen und AG)
Dann: neues Inkrement je nach Zieladaptierung

#### Iterativ-inkrementeller Entwicklungsprozess
![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=41&rect=28,41,847,518|SPE 109 ABO v.25.2, p.41]]


# Moderne („Agile“) Softwareentwicklung

![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=46&rect=32,72,917,524|SPE 109 ABO v.25.2, p.46]]
- Abersion: Abneigung (Programmierer wollen programmieren und nicht verwalten)

### Agile Softwareentwicklung: Anlass
![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=47&rect=31,45,954,519|SPE 109 ABO v.25.2, p.47]]

![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=48&rect=27,56,801,517|SPE 109 ABO v.25.2, p.48]]

![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=49&rect=21,50,786,520|SPE 109 ABO v.25.2, p.49]]

### Vorteile agiler Vorgehensmethoden
![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=50&rect=28,78,552,517|SPE 109 ABO v.25.2, p.50]]

### Nachteile agiler Vorgehensmethoden
![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=51&rect=31,37,799,519|SPE 109 ABO v.25.2, p.51]]

- natürlich nicht so starker Plan aber das ist genau Agilität

Problem: fehlendes "Big-Picture"-Design (flexible Architektur nötig)


![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=52&rect=26,53,900,531|SPE 109 ABO v.25.2, p.52]]


![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=54&rect=34,83,865,513|SPE 109 ABO v.25.2, p.54]]


## Prozessoptimierung

![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=59&rect=26,54,897,517|SPE 109 ABO v.25.2, p.59]]

### Prozessidentifikation
![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=60&rect=28,41,849,523|SPE 109 ABO v.25.2, p.60]]

> bewegliches Ziel: kleine Anforderungen können sich immer ändern, man muss immer auf Kundenwünsche eingehen


### Prozessverständnis
![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=61&rect=30,42,946,525|SPE 109 ABO v.25.2, p.61]]

### Prozessökonomie: Traditionelles Vorgehen
![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=62&rect=31,47,629,511|SPE 109 ABO v.25.2, p.62|500]]


### Prozessökonomie: Agiles Vorgehen

![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=63&rect=20,46,932,523|SPE 109 ABO v.25.2, p.63]]

### Die Balance: Prozessverbesserung

![[Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=64&rect=31,41,946,516|SPE 109 ABO v.25.2, p.64]]
