### 2.2.1 Lösungsidee

Die Anzahl der Minuten und Stunden werden eingelesen und den jeweiligen Variablen zugeordnet. Dann werden die Stunden und Minuten in eine Dezimalzahl mit der Einheit Stunden umgerechnet.

1. Wenn die Zahl kleiner als 0 ist, wird eine Fehlermeldung ausgegeben. Wenn die Zahl größer als 12 ist, wird ausgegeben, dass die Höchstarbeitszeit überschritten wurde.

2. Ansonsten: Von dieser real Zahl wird die Zahl 8.0 abgezogen. Wenn der Wert kleiner gleich 0 ist, soll 0 ausgegeben werden. Wenn die Differenz kleiner oder gleich 2 ist, soll der Wert als Zeitausgleich direkt ausgegeben werden.

3. Wenn der Wert größer als 2 ist, soll von der Differenz 2 abgezogen werden und die Zahl mit 1.5 multipliziert werden, dann wieder 2 addiert und dann ausgegeben.


<div class="page-break" style="page-break-before: always;"></div>

### 2.2.2 Quellcode

```pascal
PROGRAM Zeiterfassung;
  VAR
    min: INTEGER;
    hour: INTEGER;
    workTime: REAL;
    overWorkTime: REAL; //Gesamtzeit - Normalzeit (8h)
    compTimeOff: REAL; //Zeitausgleich
BEGIN (* Zeiterfassung *)
  //Einlesen der Arbeitszeit
  WriteLn('Eingabe: ');
  ReadLn(hour, min);
  //Berechnung der Gesamtzeit und Überstunden
  workTime := hour + (min/60);
  overWorkTime := workTime - 8;
  //Abfragen
  IF (workTime < 0) THEN BEGIN
    WriteLn('Eingabe ungueltig');
  END ELSE
    IF (workTime > 12) THEN BEGIN
      WriteLn('Taegliche Hoechstarbeitszeit ueberschritten');
    END ELSE
	  IF (overWorkTime <= 0) THEN BEGIN //weniger oder genau 8 Stunden gearbeitet
        compTimeOff := 0;
        WriteLn('Anspruch auf Zeitausgleich: ', compTimeOff:2:2, ' Stunden');
      END ELSE
        IF (overWorkTime > 0) AND (overWorkTime <=2) THEN BEGIN //zw. 0 und 2 Überstunden
          compTimeOff := overWorkTime;
          WriteLn('Anspruch auf Zeitausgleich: ', compTimeOff:2:2, ' Stunden');
        END ELSE
          IF (overWorkTime >= 2) THEN BEGIN //mehr als 2 Überstunden --> ab 11. Stunde *1.5
            compTimeOff := ((overWorkTime - 2)*1.5)+2;
            WriteLn('Anspruch auf Zeitausgleich: ', compTimeOff:2:2, ' Stunden');
          END; (* IF *)
END. (* Zeiterfassung *)
```

<div class="page-break" style="page-break-before: always;"></div>

### 2.2.3 Tests

Es werden folgende Werte getestet:

| Stunden | Minuten | Testbeschreibung                                                                                   | Testergebnis                         |
| :-----: | :-----: | -------------------------------------------------------------------------------------------------- | ------------------------------------ |
|   -5    |   -10   | Negative Eingaben (führen zu Fehlermeldung)                                                        | ![[Pasted image 20251017174728.png]] |
|    7    |   30    | Eingaben von 0 - 8 Stunden, sollen zu 0 Stunden Zeitausgleich führen                               | ![[Pasted image 20251017174802.png]] |
|    8    |   30    | Eingaben von 8 - 10 Stunden Sollen zu (Eingabe - 8) Stunden Zeitausgleich führen                   | ![[Pasted image 20251017174833.png]] |
|   11    |   00    | Eingaben von 10-12 Stunden sollen zu ((Eingabe - 10)\*1.5 +2) Stunden Zeitausgleich führen         | ![[Pasted image 20251017174907.png]] |
|   13    |   00    | Eingaben über 12 Stunden geben eine Meldung aus, dass die maximale Arbeitszeit überschritten wurde | ![[Pasted image 20251017175013.png]] |

