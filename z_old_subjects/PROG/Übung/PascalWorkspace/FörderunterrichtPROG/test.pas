


procedure DeleteAllNegatives(var a: IntArray; var n: integer);

var
  saveN, i, j: integer;

begin

  for i := 1 to n do
    begin
      if a[i] < 0 then
        begin
          for j := i to (n-1) do
            begin
              a[j] := a[j+1]; //fehler
              







            end;








        end;





    end;







end;