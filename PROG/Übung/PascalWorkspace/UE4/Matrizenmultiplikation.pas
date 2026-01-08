(* Matrizenmultiplikation:                                    DA, 2025-11-09 *)
(* ------                                                                    *)
(* lest zwei Matrizen ein und multipliziert sie ggf.                         *)
(* ========================================================================= *)

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