(* MissingElement:                                            DA, 2025-11-08 *)
(* ------                                                                    *)
(* finds the missing element                                                 *)
(* ========================================================================= *)

program TheMissingElement;

const
	max = 100;
	
Type
	IntArray = array[1..max] of integer;

function inArray(num: integer; a: IntArray; n: integer): boolean;
var
	found: boolean;
	i: integer;
begin
	//Array mit Schleife durchlaufen so lange vergleichen bis gefunden
	found := false; //init
	i := 1; //init
	while (i <= n) and (not found) do
		begin
			if num = a[i] then
        begin
				  found := true;
        end
			else
        begin
				  found := false;

        end;
      i := i + 1;
		end;

    inArray := found;
end;




function MissingElement(a: IntArray; n: integer): integer;
var
	i: integer;
begin
  
	i := 1; //init
	
	//wenn i nicht im Array enthalten ist, ist es der gesuchte Wert
	while inArray(i,a,n) do
		begin
			i := i + 1;
		end;
	
	MissingElement := i;
end;

var
  n, i: integer;
  a: IntArray;
  
begin
  //read in array
  Write('n: ');
  ReadLn(n);
  WriteLn('Enter the values of your array: ');
  WriteLn;
  for i := 1 to n do
  begin
      ReadLn(a[i]);
  end;
  
  WriteLn('The missing element is ', MissingElement(a,n));


end.