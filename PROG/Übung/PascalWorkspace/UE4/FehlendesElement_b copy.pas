(* MissingElement:                                            DA, 2025-11-08 *)
(* ------                                                                    *)
(* finds the missing element                                                 *)
(* ========================================================================= *)

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