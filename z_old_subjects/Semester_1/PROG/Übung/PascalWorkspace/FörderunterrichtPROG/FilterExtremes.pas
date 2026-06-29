program FilterTheExtremes;


procedure FilterExtreme(a: IntArray; VAR extremes: IntArray; threshold, n; VAR nExtremes: integer) //n: Anzahl der belegten Elementen
  var
    i: integer;
begin
  nExtremes := 0;

  for i := 1 to n do
    begin
      if a[i] > threshold then
        begin
          nExtremes := nExtremes + 1;
          extremes[nExtremes] := a[i];


          for 
          a[i] := a[i+1];
        end;

    end;



end;



begin

  


end.