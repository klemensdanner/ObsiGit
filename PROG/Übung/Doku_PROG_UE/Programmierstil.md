#programmierstil 

wichtig weil: Programm wird öfter gelesen als geschrieben.

- Zusammenfassen nach
	- logische Kriterien? - eher logisch
		- z.B. logische Variablen und Testvariablen getrennt
	- oder alphabetisch?
- Ausrichten der Typen oder nicht? (eher nicht)
- Gliederung von Parametern: Zuerst Eingangs- dann Übergangs- und Ausgangsparameter 
  (E-Ü-A)
- Schreibweise von Formalparameter (vgl. Formal- und Aktualparameter)
- Nicht zu weit einrücken - 2 Zeichen
	- dadurch sind Strukturen leichter zu erkennen
- Kommentare nur wenn umbedingt notwendig, weil die schnell veraltern

- Testvariablen unterhalb der Prozeduren/Funktionen deklarieren
- Prozeduren / Funktionen logisch strukturieren, damit z.B. grundlegende Prozeduren später verwendet werden können
	- wenn die vom Compailer erwartete Reihenfolge nicht der logischen entspricht, soll man Forward-Deklarationen verwenden
- Zeilen nicht zu lang machen - Verständnis
## Namenwahl

>so kurz wie möglich, so lange wie nötig, um ausreichend genau zu beschreiben

- einheitliche Sprachenwahl - Englisch oder Deutsch
- nur allgemein verständliche Abkürzungen
	- z.B. i, j sind etablierte Laufvariablen
	- min oder PrintS könnte z.B. alles sein
- CamelCasing verwenden

#### Spezifische Namengebung
- Prozedur: Verb verwenden
	- z.B. ReadBoardSize
- Funktion: liefert was --> Adjektive
	- Emty, NrOfNodes
- Units: Nomen
- Variablen: meist Nomen
	- bei boolschen Variablen --> Adjektive

Großbuchstaben:
- Programm
- Unit
- Prozeduren, Funktionen
- Typen
Kleinbuchstaben
- Variablen
GROSSBUCHSTABEN
- Schlüsselwörter: IF, BEGIN, END

## Dokumentation

- Kopf-Kommentare
- Kommentare für Deklarationen
- Kommentare für Anweisungen
	- spärlich verwenden, eher besser leserlichen Code schreiben, da Kommentare leicht veraltern - durch "nur was schnell ändern"

> Guter Code ist der beste Kommentar
> Schlechter Code wird nicht durch Kommentare gerettet

- Assertionen: Bedingungen, die gelten müssen
	- z.B. wenn eine Funktion ein sortiertes Array als Eingabe annimmt
- Anweisungskommentare
- Blockkommentare
	- (* --- Comment ---*)


Felder, Strings, Algorithmen mit Gedächtnis