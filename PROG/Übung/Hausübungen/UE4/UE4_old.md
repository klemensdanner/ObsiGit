## 1 Plateau-Problem

## 1.1 Lösungsidee

- mit For-Schleife durchzählen
- mit Hilfsvariable immer den letzten Wert speichern
- vergleichen
	- wenn gleich, dann Hilfszähler inkrimentieren
	- wenn ungleich, Hilfszähler auf 1 setzen
		- Hilfszähler in einem Hilfsarray abspeichern

- Eigene Funktion definieren, die von einem n-stelligen array das Maximum ausgibt
	- mittels Zählschleife von 1 bis n mit stellenweisem vergleich und immer schreiben des größeren Wertes

## 1.2 Quellcode
```pascal
PROGRAM PlateauProblem;


const
	max = 100;

TYPE
	IntArray = Array[1..max] of Integer; //häääää ich weiß ja nicht wie lange
	
var
  ExampleArr: IntArray;
  n: integer;
  i: integer;

function MaximumOfArray(a: IntArray; n: integer): integer;
	var
		GreaterValue: integer;
	
	begin
		GreaterValue := a[1]; //init
		for i := 2 to n do //Zugriff auf vorherigen Wert
			begin
				if a[i] > GreaterValue then
					GreaterValue := a[i];
			
			end;
	
	
	MaximumOfArray := GreaterValue;
	end;

function Plateau(a: IntArray; n: integer): integer;
	var
		j: integer; //zählt aneinanderfolgende Werte
		NumbersCounted: IntArray;
    //array[1..n] of integer; //zum Speichern der Anzahl an aneinanderfolgenden Werten
		
	begin
		j := 1; //init
		NumbersCounted[1] := 1; //init
		
		for i:= 2 to n do //erster Wert überspringen weil auf vorherigen Wert zugegriffen wird
			begin
				// Wenn IntArray[i]=vorherWert, dann inc(j), else j := 1
				//j in Hilfsarray speichern, mit NumbersCounted[i] := j
				
				if (a[i] = a[i-1]) then
					begin
						inc(j);
						NumbersCounted[i] := j;
					end
				else
					j := 1;
			end; (*for*)
			
	Plateau := MaximumOfArray(NumbersCounted, n);
	
	end;


  begin
    Write('n: '); Readln(n);

    WriteLn('Gib jetzt die ', n, ' Zahlen für das Array ein:');
    WriteLn;

    //Zahlen ins array einlesen
    for i := 1 to n do
      ReadLn(ExampleArr[i]);   

    WriteLn('Plateau-Wert: ', Plateau(ExampleArr,n));
  end.
```


## 1.3 Tests

