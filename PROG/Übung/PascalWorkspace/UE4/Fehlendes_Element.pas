program TheMissingElement;

const
	max = 100;
	
type
	IntArray = Array[1..max] of integer;


var
	ExampleArr: IntArray;
	n, i: integer;


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




function MissingElement(a: IntArray; n: integer): integer;
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
		
		MissingElement := k;

	end;



	begin

		Write('n: '); Readln(n);

    WriteLn('Gib jetzt die ', n, ' Zahlen fuer das Array im Wertebereich von [1..n+1] ein:');
    WriteLn;

    //Zahlen ins array einlesen
    for i := 1 to n do
      ReadLn(ExampleArr[i]);   


		WriteLn('The missing element is ', MissingElement(ExampleArr, n));




	end.