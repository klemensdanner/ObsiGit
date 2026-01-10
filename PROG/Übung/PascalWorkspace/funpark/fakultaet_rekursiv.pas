program testfactorial;

function factorial(n: integer): integer;
var save: integer;
begin
  if n <= 1 then
    save := 1
  else
    save := n*factorial(n-1);
  factorial := save;
end;

begin
  WriteLn(factorial(5));


end.