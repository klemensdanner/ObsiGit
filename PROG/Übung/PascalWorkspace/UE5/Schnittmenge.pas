program schnittmenge;

const
	max = 5;

type
	IntArray = array[1..max] of integer;


procedure ReadArray(var a: Array of integer; n: integer);
var
  i: integer;

begin
  for i := 0 to (n-1) do
    Read(a[i]);
end;

procedure WriteArray(a: Array of integer; n: integer);
var
  i: integer;
begin
  for i := 0 to (n-1) do
    Write(a[i]:3);
end;


function IsSorted(a: Array of integer; n: integer): boolean;
var
	i: integer;
	sorted: boolean;

begin
	i := 0; //OpenArray-Init
  sorted := true;
	while sorted AND (i <= (n-2)) do //Zugriff auf i+1 & open-array
		begin
      if a[i] > a[i+1] then
        sorted := false;

			i := i + 1;
		end; //end while
	
	IsSorted := sorted;
end;


procedure Intersect(a1: array of integer; n1: integer; a2: array of integer; n2: integer; VAR a3: array of integer; VAR n3: integer);

VAR
	a3max, i, j: integer;

begin
	//Eingangskriterien prüfen
	if (NOT IsSorted(a1, n1)) OR (NOT IsSorted(a2, n2)) then
		begin
			n3 := -1;
			Exit; //Prozedur wird wegen Nichterfüllung der Eingangskriterien verlassen
		end;
	
  a3max := high(a3);
  i := 0;
  j := 0; //open-array-init
  n3 := 0; //init

  while (i <= (n1 - 1)) AND (j <= (n2 - 1)) do
    begin
{       //gleiche Zahlen überspringen:
      while (i <= (n1-2)) AND (a1[i] = a1[i+1]) do //prüfung damit i+1 nicht außerhalb liegt
        i := i + 1;
      while (j <= (n2-2)) AND (a2[j] = a2[j+1]) do
        j := j + 1; }
      
      if (a1[i] = a2[j]) then
        begin
          if n3 <= a3max then
            begin
              a3[n3] := a1[i];
              i := i + 1;
              j := j + 1;
              n3 := n3 + 1;
            end
          else
            begin
              n3 := -1;
              Exit; //Überlauf
            end
        end
      else
        if (a1[i] < a2[j]) then
          i := i + 1
        else
          j := j + 1;
      
    
    end;
end;


VAR
  a1, a2, a3: IntArray;
  n1, n2, n3 : integer;


begin
  Write('n1 > ');
  Read(n1);

  Write('Enter ', n1, ' values > ');
  ReadArray(a1, n1);
  WriteArray(a1, n1);
  WriteLn;

  Write('n2 > ');
  Read(n2);

  Write('Enter ', n2, ' values > ');
  ReadArray(a2,n2);
  WriteArray(a2,n2);

  Intersect(a1, n1, a2, n2, a3, n3);
  WriteLn(n3);
  if (n3 = -1) then
    WriteLn('An Error occured: input arrays not sorted or overflow');

  WriteLn('Those numbers are in both arrays: ');
  WriteArray(a3, n3);
  WriteLn;

end.
