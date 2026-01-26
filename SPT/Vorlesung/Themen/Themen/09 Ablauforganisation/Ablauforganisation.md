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
![[ObsiGit/SPT/Vorlesung/Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=4&rect=47,119,766,445|SPE 109 ABO v.25.2, p.4]]

![[ObsiGit/SPT/Vorlesung/Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=4&rect=607,327,959,532|SPE 109 ABO v.25.2, p.4|300]]

## Gesteuerter Prozess vs. geregelter Prozess
![[ObsiGit/SPT/Vorlesung/Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=5&rect=29,43,821,514|SPE 109 ABO v.25.2, p.5]]

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

![[ObsiGit/SPT/Vorlesung/Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=11&rect=48,119,908,447|SPE 109 ABO v.25.2, p.11]]

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

![[ObsiGit/SPT/Vorlesung/Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=14&rect=3,69,953,528|SPE 109 ABO v.25.2, p.14]]

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



![[ObsiGit/SPT/Vorlesung/Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=18&rect=24,36,827,528|SPE 109 ABO v.25.2, p.18]]

### Prozessorientiertes Vorgehen
Prozessmodell unterteilt Vorgehen in überschaubare Abschnitte:
![[ObsiGit/SPT/Vorlesung/Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=19&rect=45,58,831,445|SPE 109 ABO v.25.2, p.19]]


## Vorgehensmethoden

> Unterscheidung: Vorgehensprozesse werden durch Vorgehensmethoden umgesetzt.
> Oft Erfolg nur durch Kombination verschiedener Methoden!


### Sequenzielles Vorgehen
![[ObsiGit/SPT/Vorlesung/Themen/Themen/09 Ablauforganisation/SPE 109 ABO v.25.2.pdf#page=22&rect=24,54,949,461|SPE 109 ABO v.25.2, p.22]]













