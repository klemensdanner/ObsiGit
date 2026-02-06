  PROCEDURE FillArray(VAR a: array of integer; n: INTEGER);
    VAR
      i: integer;
     

  BEGIN (* FillArray *)
    for i := 0 to n-1 do BEGIN
      a[i] := (i*i);
    END;

  END; (* FillArray *)



  procedure DeleteNegatives3(var a: IntArray; var n: integer);
  var
    i, delItems: integer;

  begin

    delItems := 0;

    for i := 1 to n do
      begin
        if (a[i] < 0) then
          begin
            delItems := delItems +1;
          end
        else 
          begin
            a[i-delItems] := a[i];
          end;
      end;

  n := n - delItems;

  end;