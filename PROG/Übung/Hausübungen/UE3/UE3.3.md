## 3 Balkendiagramm

### 3.1 Lösungsidee

Es werden ein Char und 5 Zahlen eingelesen, welche von der Prozedur übernommen werden.
Wenn die eingelesenen Zahlen im Wertebereich liegen, fährt das Programm fort. Mit der Funktion Max2 aus Aufgabe 1 wird von den eingelesen Zahlen das Maximum ermittelt, um die Anzahl der Zeilen herauszufinden.
Für jede Zeile wird für alle Werte ni mittels einer anderen Prozedur geprüft, ob der Index der aktuellen Zeile kleiner oder gleich des jeweiligen Wertes ni ist. Wenn sie kleiner ist, wird der Char geschrieben, ansonsten ein Leerzeichen.
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
### 3.3 Tests

| Eingaben     | Begründung                   | Ausgaben                                  |
| ------------ | ---------------------------- | ----------------------------------------- |
| X,3,5,7,4,2  | Aufgabe                      | ![[Pasted image 20251026134759.png\|100]] |
| O,2,5,10,4,8 | maximaler Wert, anderer Char | ![[Pasted image 20251026134935.png\|100]] |
| A,1,1,1,1,1  | minimaler Wert               | ![[Pasted image 20251026135959.png\|100]] |
| B,1,4,0,6,5  | außerhalb von Wertebereich   | ![[Pasted image 20251026140026.png\|200]] |
| C,1,4,11,6,5 | außerhalb von Wertebereich   | ![[Pasted image 20251026140056.png\|200]] |
| AB,1,2,3,4,5 | String eingegeben            | ![[Pasted image 20251026135914.png\|200]] |
 
