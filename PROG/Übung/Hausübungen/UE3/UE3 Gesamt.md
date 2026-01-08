## 1 Maximum von zwei oder drei Werten

### 1.1 Lösungsidee
a) 2 Werte werden eingelesen. Die Funktion Max2 prüft mittels if-Abfrage welcher Wert größer ist und gibt diesen zurück.
b) 3 Werte werden eingelesen. Die Funktion Max3 ermittelt das Maximum, indem sie mit der Funktion Max2 aus Aufgabe a) das Maximum der ersten beiden Zahlen ermittelt dann das Maximum aus dem Rückgabewert und der dritten Zahl bestimmt, welches insgesamt das Maximum von allen drei Zahlen ist.
<div class="page-break" style="page-break-before: always;"></div>

### 1.2 Quellcode

```pascal
PROGRAM Maximum;

// Aufgabe a)
FUNCTION Max2(a, b: INTEGER): INTEGER;
	var maximum: INTEGER;
	
	BEGIN
	IF a > b then
		maximum := a
	ELSE
		maximum := b;
	Max2 := maximum
	END;

// Aufgabe b)
FUNCTION Max3(a, b, c: INTEGER): INTEGER;
  BEGIN
    Max3 := Max2(Max2(a,b),c);
  END;

VAR
  a, b, c: INTEGER;

BEGIN

  Write('Geben Sie drei Zahlen ein. Das Maximum der ersten beiden und aller drei Zahlen wird ermittelt: ');
  WriteLn; Read(a,b,c);

  WriteLn('Maximum der ersten beiden Zahlen: ', Max2(a,b));
  WriteLn('Maximum aller Zahlen: ', Max3(a,b,c));

END.
```

<div class="page-break" style="page-break-before: always;"></div>
### 1.3 Tests

| Eingabe      | Beschreibung                 | Ausgabe                                   |
| ------------ | ---------------------------- | ----------------------------------------- |
| 6,2,4        | unterschiedliche pos. Zahlen | ![[Pasted image 20251025120832.png\|400]] |
| 0,0,0        | 0 und nur eine Zahl          | ![[Pasted image 20251025120937.png\|400]] |
| -5,0,1       | negative Zahl dabei          | ![[Pasted image 20251025121017.png\|400]] |
| -15, -21, -1 | nur negative Zahlen          | ![[Pasted image 20251025121049.png\|400]] |
<div class="page-break" style="page-break-before: always;"></div>

## 2 Befreundete Zahlen
### 2.1 Lösungsidee
Zuerst wird eine Funktion implementiert, welche die Summe der echten Teiler zurückgibt.
In einer zweiten Funktion wird unter der Verwendung der ersten Funktion geprüft, ob die Summe der Teiler gleich der jeweils anderen Zahl ist und anschließend ein Wahrheitswert zurückgegeben.

Mit for Schleife von der Zahl bis 1 runterzählen. Immer wenn Rest 0, dann den Index zu einer Summenvariable hinzufügen.
<div class="page-break" style="page-break-before: always;"></div>

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

<div class="page-break" style="page-break-before: always;"></div>

### 2.3 Tests

| Eingaben  | Beschreibung                    | Ausgaben                                  |
| --------- | ------------------------------- | ----------------------------------------- |
| 220,284   | allgemein                       | ![[Pasted image 20251028171205.png\|200]] |
| 1210,1184 | allgemein                       | ![[Pasted image 20251028171303.png\|200]] |
| 100,100   | nicht befreundet                | ![[Pasted image 20251028171345.png\|200]] |
| 0,0       | nicht befreundet, untere Grenze | ![[Pasted image 20251028171421.png\|200]] |
| -220,-284 | negativ, nicht befreundet       | ![[Pasted image 20251028171455.png\|200]] |

<div class="page-break" style="page-break-before: always;"></div>

## 3 Balkendiagramm

### 3.1 Lösungsidee

Es werden ein Char und 5 Zahlen eingelesen, welche von der Prozedur übernommen werden.
Wenn die eingelesenen Zahlen im Wertebereich liegen, fährt das Programm fort. Mit der Funktion Max2 aus Aufgabe 1 wird von den eingelesen Zahlen das Maximum ermittelt, um die Anzahl der Zeilen herauszufinden.
Für jede Zeile wird für alle Werte ni mittels einer anderen Prozedur geprüft, ob der Index der aktuellen Zeile kleiner oder gleich des jeweiligen Wertes ni ist. Wenn sie kleiner ist, wird der Char geschrieben, ansonsten ein Leerzeichen.

<div class="page-break" style="page-break-before: always;"></div>

### 3.2 Quellcode

```pascal
PROGRAM Balkendiagramm;

  VAR
    n1, n2, n3, n4, n5: INTEGER;
    ch1: string; //um runtime error bei Falscheingabe zu vermeiden


  //Funktion zur Berechnung vom Max
  FUNCTION Max2(a, b: INTEGER): INTEGER;
	var maximum: INTEGER;
	BEGIN
	IF a > b then
		maximum := a
	ELSE
		maximum := b;
  Max2 := maximum
	END;

  //Entscheidet für eine Stelle, ob ein ch oder ' ' geschrieben wird
  PROCEDURE SetCharOrSpace(ch: CHAR; zeile, ni: INTEGER);

    BEGIN

      IF zeile <= ni then
        Write(' ', ch)
      ELSE
        Write('  ');

    END;


  PROCEDURE BarChart(ch: CHAR; n1, n2, n3, n4, n5: INTEGER);
  //Block
  VAR
  nMax: INTEGER;
  j: INTEGER;
  BEGIN
  
    //BarChart ausgeben, wenn im Wertebereich
    IF (n1 in [1..10]) and (n2 in [1..10]) and (n3 in [1..10]) and (n4 in [1..10]) and (n5 in [1..10]) then
      BEGIN
        //Maximum für Anzahl der Zeilen ermitteln
        nMax := Max2(Max2(Max2(Max2(n1,n2),n3),n4),n5);
        

        for j := nMax downto 1 do
          BEGIN
            //Zeile basteln und ausgeben, in eigene Prozedur auslagern
            Write(j:2, '|');
            SetCharOrSpace(ch, j, n1);
            SetCharOrSpace(ch, j, n2);
            SetCharOrSpace(ch, j, n3);
            SetCharOrSpace(ch, j, n4);
            SetCharOrSpace(ch, j, n5);

            WriteLn;
          END;
        
        WriteLn('  +----------');
        WriteLn('    1 2 3 4 5');
      END
    ELSE
      WriteLn('Der Wertebereich ist 1 bis 10')
  END;

BEGIN
  WriteLn('Geben Sie einen char und 5 Zahlen zwischen 1 und 10 ein, um ein Balkendiagramm zu erstellen!');
  WriteLn;
  Read(ch1, n1, n2, n3, n4, n5);
  
  if length(ch1) = 1 then
  BEGIN
    WriteLn;
    BarChart(ch1[1], n1, n2, n3, n4, n5);
  END
  ELSE
    WriteLn('Bitte einen Char eingeben!');
END.
```
<div class="page-break" style="page-break-before: always;"></div>

### 3.3 Tests

| Eingaben     | Begründung                   | Ausgaben                                  |
| ------------ | ---------------------------- | ----------------------------------------- |
| X,3,5,7,4,2  | Aufgabe                      | ![[Pasted image 20251026134759.png\|100]] |
| O,2,5,10,4,8 | maximaler Wert, anderer Char | ![[Pasted image 20251026134935.png\|100]] |
| A,1,1,1,1,1  | minimaler Wert               | ![[Pasted image 20251026135959.png\|100]] |
| B,1,4,0,6,5  | außerhalb von Wertebereich   | ![[Pasted image 20251026140026.png\|200]] |
| C,1,4,11,6,5 | außerhalb von Wertebereich   | ![[Pasted image 20251026140056.png\|200]] |
| AB,1,2,3,4,5 | String eingegeben            | ![[Pasted image 20251026135914.png\|200]] |
 
