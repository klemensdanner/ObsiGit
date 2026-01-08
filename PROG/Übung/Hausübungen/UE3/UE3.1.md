## 1 Maximum von zwei oder drei Werten

### 1.1 Lösungsidee
a) 2 Werte werden eingelesen. Die Funktion Max2 prüft mittels if-Abfrage welcher Wert größer ist und gibt diesen zurück.
b) 3 Werte werden eingelesen. Die Funktion Max3 ermittelt das Maximum, indem sie mit der Funktion Max2 aus Aufgabe a) das Maximum der ersten beiden Zahlen ermittelt dann das Maximum aus dem Rückgabewert und der dritten Zahl bestimmt, welches insgesamt das Maximum von allen drei Zahlen ist.

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
### 1.3 Tests

| Eingabe      | Beschreibung                 | Ausgabe                                   |
| ------------ | ---------------------------- | ----------------------------------------- |
| 6,2,4        | unterschiedliche pos. Zahlen | ![[Pasted image 20251025120832.png\|400]] |
| 0,0,0        | 0 und nur eine Zahl          | ![[Pasted image 20251025120937.png\|400]] |
| -5,0,1       | negative Zahl dabei          | ![[Pasted image 20251025121017.png\|400]] |
| -15, -21, -1 | nur negative Zahlen          | ![[Pasted image 20251025121049.png\|400]] |
