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