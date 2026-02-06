### 2.1.1 Kopie von Lösungsidee aus Übung 1

Variablen werden deklariert. Mittels Schleife werden solange Werte eingelesen, bis der eingelesene Wert gleich 0 ist. Alle Werte werden in der Schleife überprüft ob sie größer als 0 sind oder nicht und dann zu den jeweiligen Variablen addiert. Anschließend werden die Werte der Variablen ausgegeben.

### 2.1.2 Quellcode

```pascal
PROGRAM EinnahmenAusgaben;

  VAR
  value, totalpos, totalneg: INTEGER;

BEGIN (*EinnahmenAusgaben*)
  value := 1;
  totalneg := 0;
  totalpos := 0;

  while value <> 0 do // Solange value ungleich 0 wird eingelesen
  BEGIN
    ReadLn(value);

    //Zuweisungen je nach Vorzeichen
    if value > 0 THEN
      totalpos := totalpos + value
    else
      totalneg := totalneg + value
  END;

//Ausgabe
WriteLn('Einnahmen: ', totalpos);
WriteLn('Ausgaben: ', totalneg);
WriteLn('Gesamt: ', (totalpos + totalneg));

END. (*EinnahmenAusgaben*)
```

<div class="page-break" style="page-break-before: always;"></div>

### 2.1.3 Tests


| Zahlen                          | Beschreibung                 | Ausgabe                                   |
| ------------------------------- | ---------------------------- | ----------------------------------------- |
| 10 20 -30 40 -50 60 70 80 -90 0 | Positive und negative Zahlen | ![[Pasted image 20251018122847.png\|100]] |
| 0                               | 0 testen                     | ![[Pasted image 20251018122952.png\|100]] |
