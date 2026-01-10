Unterschied block und Compound Statement:

Block hat Deklarationsteil und ein begin und end

Das Compoundstatement ist ein Statement zum Zusammenfassen von Statements

Beispiel Prozedur:
```pascal
PROCEDURE Swap(VAR value1, value2: INTEGER)

// geht auch mit PROCEDURE Swap(VAR value1: INTEGER; var value2: INTEGER)
// aber beides INTEGER, also leichter so

VAR
	h: INTEGER;
	
BEGIN
	h := value1
	value1 := value2
	value2 := h;
END;
```

Bei Ausgangs und Übergangsparameter wird das Schlüsselwort 'VAR' verwendet.

Bei mehreren Ergebniswerten wird eine Prozedur verwendet. Außerdem wenn man Werte im Programm verändern sollen. (call by value)


### Call by value
Runtime Stack

Beispiel: write(12)

| Aktivierungssatz | Beschreibung |
| ---------------- | ------------ |
| i:=12            |              |
|                  |              |
|                  |              |
|                  |              |




Es gibt immer einen Hauptspeicher - dort sind globale Variablen gespeichert.
Dann gibt es einen Stack (Stapel), der für eine neue Prozedur einen neuen Aktivierungssatz in diesem Stack anlegt. Wenn die Prozedur beendet ist, wird dieser Aktivierungssatz wieder gelöscht und damit auch die evtl. (bei call by value) darin gespeicherten Variablen.

Es gibt im ganzen Programm nur einen Stack, der für Funktionen und Prozeduren verwendet wird.
Eine Funktion bzw Proz. erstellt darin einen Aktivierungssatz. Wenn innerhalb nochmal eine Funk/Proz aufgerufen wird, wird unter diesem Aktivierungssatz ein weiterer Aktivierungssatz erstellt, der wieder nur für die Dauer der Funktion existiert. Im Normalfall, bei richtiger Programmierung, ist das Stack am Ende des Programms leer.


Bei call by value werden die Werte Variablen direkt an die Prozedur übergeben. Wenn die Werte in der Prozedur verändert werden, gilt diese Änderung nur für die Laufzeit des Aktivierungssatzes im Stack (Speicher).

Bei call by reference werden Speicheradressen übergeben. Wenn man diese Werte verändert, werden die Werte tatsächlich angepasst.

Globale Variablen nur dann verwenden, wenn es nicht anders geht.


```pascal
real div real //geht nur bei INTEGERs
//stattdessen:

real / real
```



