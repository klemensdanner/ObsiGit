
## 1 Plateau Problem

Das Array soll mittels Zählschleife von 1 bis n durchlaufen und immer die Anzahl der aufeinander folgenden Werte in ein Hilfsarray speichern. Mit einer eigenen Funktion wird der größte Wert dieses Hilfsarrays bestimmt, welcher also die Anzahl der aufeinander folgenden Werte ist.

<div class="page-break" style="page-break-before: always;"></div>
### 1.2 Quellcode

```pascal
program PlateauProblem;

const
	max = 100;

Type
	IntArray = array[1..max] of integer;

function GreatestValue(a: IntArray; n: integer): integer;
var
	i, maxValue: integer;
begin
	maxValue := 0; // init
	for i := 1 to n do
		begin
			if a[i] > maxValue then
				maxValue := a[i];		
		end;
		GreatestValue := maxValue;
end;


function Plateau(a: IntArray; n: integer): integer;
var
	i: integer;
	NumCounter: IntArray;
	
begin
	NumCounter[1] := 1; //init
	for i := 2 to n do
		if (a[i] = a[i-1]) then
			NumCounter[i] := NumCounter[i-1] + 1
		else
			NumCounter[i] := 1;
			
	Plateau := GreatestValue(NumCounter, n);
end;


procedure ReadIntArray(VAR a: IntArray; VAR n: integer);
var
	i: integer;
begin
	WriteLn('Enter the length of the array: ');

	repeat //Eingabeprüfung
		ReadLn(n);
		if n<1 then
			WriteLn('Try again. Enter a length >= 1')
	until n>=1;

	WriteLn('Enter ', n, ' values for your array: ');
	for i := 1 to n do
		Read(a[i]);
end;

//global var
var
	testArray: IntArray;
	n: integer;

begin
	
	ReadIntArray(testArray, n);
	WriteLn('Plateau-Value: ', Plateau(testArray, n));
	
end.
```

<div class="page-break" style="page-break-before: always;"></div>

### Tests

| Beschreibung       | Eingabe / Ausgabe                         |
| ------------------ | ----------------------------------------- |
| Beispiel           | ![[Pasted image 20251109143014.png\|250]] |
| Nur gleiche Werte  | ![[Pasted image 20251109144250.png\|250]] |
| nur 1 Wert         | ![[Pasted image 20251109144024.png\|250]] |
| negative Länge / 0 | ![[Pasted image 20251109144143.png\|250]] |
<div class="page-break" style="page-break-before: always;"></div>

## 2 Das fehlende Element

### 2.1 Lösungsidee
Für die Funktion MissingElement1() erfolgt die Lösung laut Aufgabenstellung.

Lösungsidee MissingElement2():
Eine Schleife prüft immer, ob eine Zählvariable (startend bei 1) im Array enthalten ist oder nicht. Wenn sie enthalten ist, wird die Zählvariable um eins erhöht. Wenn sie nicht enthalten ist, so ist das offensichtlich der fehlende Wert. Dazu wird eine Hilfsfunktion inArray(i,a,n) verwendet, welche zuerst definiert wird.

<div class="page-break" style="page-break-before: always;"></div>

### 2.2 Quellcode

```pascal
program TheMissingElement;

const
	max = 100;
	
Type
	IntArray = array[1..max] of integer;


function ExistInArray(a: IntArray; len, num: integer): boolean;
	var
		j: integer;
	begin
	//durchsuchen mit while schleife für sofortigen Abbruch bei Fund
	
		j := 1; //init
		while (j<max) and (a[j] <> num) do //solange j hochzählen bis Index=Arraywert
			begin
				j := j + 1;
			end;

		if j <= len then
			ExistInArray := True
		Else
			ExistInArray := False;
			
	end;


function MissingElement1(a: IntArray; n: integer): integer;
	var
		h: array[1..max] of boolean;
		i, k: integer;
		
	begin
		//h init
		for i := 1 to (n+1) do
			h[i] := false;
			
		//prüfen, ob Index vom Feld im Array vorkommt
		for i := 1 to (n+1) do
			begin
				if ExistInArray(a, n, i) then
					h[i] := true;
			end;
			
		//h durchlaufen und beim ersten False aufhören, Index --> Ergebnis
		k := 0; //init
		
		repeat
			k := k + 1;
		until h[k] = false;
		
		MissingElement1 := k;

	end;


function MissingElement2(a: IntArray; n: integer): integer;
var
	i: integer;
begin
  
	i := 1; //init
	
	//wenn i nicht im Array enthalten ist, ist es der gesuchte Wert
	while ExistInArray(a,n,i) do
		begin
			i := i + 1;
		end;
	
	MissingElement2 := i;
end;

var
  n, i: integer;
  a: IntArray;
	input: integer;
  
begin
  //Länge einlesen
  Write('n: ');
  ReadLn(n);
  
	//Array einlesen, wenn n valid
	if n <= 0 then
		begin
			WriteLn('error: no numbers <= 0');
			exit; //Eingangsbedingung nicht erfüllt
		end;

		WriteLn('Enter the values of your array: ');

		a[1] := 0; //init, wird überschrieben
  	for i := 1 to n do
  	begin
      ReadLn(input);
			if (input <= 0) OR (input > n+1) OR ExistInArray(a,n,input) then
				begin
					WriteLn('error: input out of range or use a number only once');
					exit; //Eingangsbedingung nicht erfüllt
				end
			else
				a[i] := input;
		end;
  	
  	WriteLn('missing element a): ', MissingElement1(a,n));
	WriteLn('missing element b): ', MissingElement2(a,n));
	
end.
```
<div class="page-break" style="page-break-before: always;"></div>

### 2.3 Tests

| Eingabe                           | Beschreibung                  | Ausgabe                                   |
| --------------------------------- | ----------------------------- | ----------------------------------------- |
| n: 4<br><br>3,2,4,5               | Aufgabenstellung              | ![[Pasted image 20251108211606.png\|250]] |
| n: 7<br><br>4,2,7,3,1,6,5<br><br> | anderes n + letzte zahl fehlt | ![[Pasted image 20251108212033.png\|250]] |
| n: 1<br><br>2                     | kleinster gültiger input      | ![[Pasted image 20251108212249.png\|250]] |
| n: 0                              | n out of range                | ![[Pasted image 20251108212143.png\|250]] |
| n: 4<br><br>3, 2, 4, -1           | a\[i] out of range            | ![[Pasted image 20251108212426.png\|250]] |
| n: 4<br><br>3, 2, 2, 4            | Wert doppelt eingegeben       | ![[Pasted image 20251108212550.png\|250]] |

<div class="page-break" style="page-break-before: always;"></div>

## 3 Matrizenmultiplikation

### 3.1 Lösungsidee

Die Realisation erfolgt mittels mehrdimensionaler Felder. Die Eingabe wird mit zwei verschachtelten Zählschleifen gemacht, die Ausgabe analog dazu. Bei der Multiplikation wird wieder durch zwei verschachtelte Zählschleifen zur aktuellen Stelle c\[i, j] "navigiert" und dort die Formel zur Berechnung durch Aufsummieren angewendet.

<div class="page-break" style="page-break-before: always;"></div>

### 3.2 Quellcode
```pascal
program Matrizenmultiplikation;

type
	Matrix = array[1..3,1..3] of integer;
	
procedure MatrixInput(VAR mat: Matrix); //Zeilen und Spalten einer 3x3 Matrix einlesen
var
	i, j: integer;
 
begin
	for i := 1 to 3 do //Zeilen
    begin
		  for j := 1 to 3 do //Spalten
			  Read(mat[i,j]);
      ReadLn;
    end;
end;

procedure MatrixOutput(mat: Matrix);
var
	i, j: integer;

begin
	for i := 1 to 3 do //Zeilen
		begin
			for j := 1 to 3 do //Spalten
				Write(mat[i,j]:4);
			
			WriteLn; //Zeilenumbruch bei neuer Zeile
		end;
end;

procedure MatrixMulti(a, b: Matrix; VAR c: Matrix);
var
	i, j, k: integer;
begin
	for i := 1 to 3 do
		for j := 1 to 3 do
			begin //Stelle c[i,j] von Ergebnismatrix
				c[i,j] := 0; //init
				//Formel zur Berechnung von c[i,j] anwenden
				
				for k := 1 to 3 do
					begin
						c[i,j] := c[i,j] + (a[i,k]*b[k,j]);
					end;
			end;
end;

//global variables
var
	a, b, c: Matrix;
	MultiWantedChar: char;

begin
  WriteLn('Enter two 3x3 matrices');
	MatrixInput(a);
	WriteLn;
	
	MatrixOutput(a);
	WriteLn;
	
	MatrixInput(b);
	WriteLn;
	
	MatrixOutput(b);
	WriteLn;
	
	//Abfragen ob Multiplikation gewünscht
	WriteLn('Do you want to multiply the entered matrices? (y/n)');
	Read(MultiWantedChar);
	
	if MultiWantedChar = 'y' then
		begin //Multiplikation
			MatrixMulti(a,b,c);
			MatrixOutput(c);
		end;
end.
```
<div class="page-break" style="page-break-before: always;"></div>

### 3.3 Tests

| Eingabe                                                               | Beschreibung    | Ausgabe                                   |
| --------------------------------------------------------------------- | --------------- | ----------------------------------------- |
| 123<br>456<br>789<br><br>987<br>654<br>321                            | random Matrizen | ![[Pasted image 20251109122916.png\|250]] |
| 123<br>456<br>789<br><br>100<br>010<br>001                            | Einheitsmatrix  | ![[Pasted image 20251109122745.png\|250]] |
| -1 2 -3<br>4 -5  6<br>1  2  3<br><br> 4 -5  6<br>-1  2 -3<br> 3  2  1 | negative Zahlen | ![[Pasted image 20251109123327.png\|250]] |
| 0 0 0<br>0 0 0<br>0 0 0<br><br>1 2 3<br>4 5 6<br>7 8 9                | 0               | ![[Pasted image 20251109123556.png\|250]] |
