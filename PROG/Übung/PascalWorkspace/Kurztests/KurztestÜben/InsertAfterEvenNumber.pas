program InsertAfterEvenNumber;

CONST
  max = 100;


type
  IntArray = array[1..max] of integer;


procedure FillArray(var a: IntArray; n: integer);
var
  i: integer;
  
begin
  for i:=1 to n do
    ReadLn(a[i]);


end;


procedure WriteArray(a: IntArray; n: integer);
var
  i: integer;

begin
  for i := 1 to n do
    Write(a[i]:3);
end;


procedure Insert0(var a: IntArray; var n: integer; at: integer);
var
  i: integer;

begin
  if n<max then
    begin

      for i:=n downto at do
        a[i+1] := a[i]; //end for

      a[at] := 0;
      n := n+1;

    end; //if
end;




procedure InsertAfterEven(var a: IntArray; var n: integer);

var
  i: integer;

begin
  i:=1;
  while i<=n do
    begin
      if (a[i] mod 2 = 0) then
        begin
          Insert0(a,n,(i+1)); //definieren!
          i := i + 1;
        end;
        Writeln('Testvalues i, n: ', i:2, n:2);
        i:=i+1;
      end;
      
end;

var
  a: IntArray;
  n: integer;

begin

  Write('n: '); Read(n);
  FillArray(a,n);

  WriteArray(a,n);
  WriteLn;


  InsertAfterEven(a,n);
  WriteArray(a,n);
  WriteLn;






end.