## 2 Befreundete Zahlen
### 2.1 Lösungsidee
Zuerst wird eine Funktion implementiert, welche die Summe der echten Teiler zurückgibt.
In einer zweiten Funktion wird unter der Verwendung der ersten Funktion geprüft, ob die Summe der Teiler gleich der jeweils anderen Zahl ist und anschließend ein Wahrheitswert zurückgegeben.

Mit for Schleife von der Zahl bis 1 runterzählen. Immer wenn Rest 0, dann den Index zu einer Summenvariable hinzufügen.
### 2.2 Quellcode
```pascal
PROGRAM BefreundeteZahlen1;
VAR a,b: INTEGER;

FUNCTION TeilerSumme(a: INTEGER): INTEGER;
  var Summe, i: INTEGER;
  
  BEGIN
    Summe := 0; //init
    for i := (a - 1) downto 1 do
    BEGIN
      IF (a mod i = 0) then
      Summe := Summe + i;    
    END;

    Teilersumme := Summe;
  END;

FUNCTION BefreundeteZahlen(a,b: INTEGER): BOOLEAN;
  
  BEGIN
    IF (a<1) or (b<1) then //negative Zahlen machen keinen Sinn, und auch 0 sind keine befreundeten Zahlen
    BefreundeteZahlen := false
    ELSE
    BefreundeteZahlen := (a = TeilerSumme(b)) and (b = TeilerSumme(a));
  END;

BEGIN
  Write('Zwei Zahlen eingeben: '); Read(a,b);

  IF BefreundeteZahlen(a,b) then
    WriteLn('Diese Zahlen sind befreundet.')
  ELSE
    WriteLn('Diese Zahlen sind nicht befreundet.');
END.
```

### 2.3 Tests

| Eingaben  | Beschreibung                    | Ausgaben                                  |
| --------- | ------------------------------- | ----------------------------------------- |
| 220,284   | allgemein                       | ![[Pasted image 20251028171205.png\|200]] |
| 1210,1184 | allgemein                       | ![[Pasted image 20251028171303.png\|200]] |
| 100,100   | nicht befreundet                | ![[Pasted image 20251028171345.png\|200]] |
| 0,0       | nicht befreundet, untere Grenze | ![[Pasted image 20251028171421.png\|200]] |
| -220,-284 | negativ, nicht befreundet       | ![[Pasted image 20251028171455.png\|200]] |
