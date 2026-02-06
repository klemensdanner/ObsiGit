### 2.3.1 Lösungsidee

Solange in n ungleich 0 ist, wird das Folgende mittels while-Schleife wiederholt:
Ein Wert für n und einer für m wird eingelesen und den Variablen zugewiesen.
Dann werden zwei for-Schleifen verschachtelt implementiert. Die äußere Schleife zählt die Zeilen, von 1 bis n, der Index ist i. Die innere Schleife zählt die Spalten von 1 bis m mit dem Index j. Bei jedem Durchlauf wird das Produkt i\*j ausgegeben. Um Abstand zwischen den Produkten zu gewährleisten, wird eine Mindestbreite bei der Ausgabe festgelegt.
Nach der inneren Schleife muss ein Zeilenumbruch durchgeführt werden.

<div class="page-break" style="page-break-before: always;"></div>

### 2.3.2 Quelltext

```pascal
PROGRAM Multiplikationstabelle;
  VAR
    n, m, i, j: INTEGER;

BEGIN
  //Initialisierung
  n := 1;
  m := 1;

  while n <> 0 do BEGIN

    Write('Zeilen: ');
    ReadLn(n);

    IF n <> 0 THEN BEGIN //Bei Eingabe von n=0 direkt abbrechen
      Write('Spalten: ');
      ReadLn(m);

      IF (n > 0) AND (m > 0) THEN BEGIN // Negative Werte ausschließen, Programm weiterführen

        for i := 1 to n do BEGIN

          for j := 1 to m do BEGIN

            Write((i*j):5)

          END; (*innere Zählschleife*)

          WriteLn
        END; (*äußere Zählschleife*)

      END (*if-Abfrage, neg. Werte ausschließen*) ELSE
        Write('Bitte nur positive ganze Zahlen eingeben.'); //Fehlermeldung ausgeben
        WriteLn;
    
    END (*if-Abfrage, bei n=0 abbrechen*)
  END (*While*)
END.
```


<div class="page-break" style="page-break-before: always;"></div>

### 2.3.3 Tests

|  n  |  m  |                     Beschreibung                     |                  Ausgabe                  |
| :-: | :-: | :--------------------------------------------------: | :---------------------------------------: |
|  5  | 10  |                Positive ganze Zahlen                 | ![[Pasted image 20251018133159.png\|250]] |
| -5  | 10  |             Eingabe einer negativen Zahl             | ![[Pasted image 20251018133319.png\|250]] |
|  0  |  x  | Eingabe von n=0, Programm soll direkt beendet werden | ![[Pasted image 20251018133438.png\|250]] |
