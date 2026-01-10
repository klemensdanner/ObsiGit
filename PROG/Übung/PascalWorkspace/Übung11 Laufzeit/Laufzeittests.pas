// max positive sum of subvectors

program MaxPgm;
  var
    counter: integer; (* counts the number of loops *)

  procedure Init(var a: array of integer);
    var
     i, val: integer;
  begin
    for i := 0 to high(a) do begin
      val := Random(10);
      if (val mod 3 = 0) then begin
        val := -val;
      end;
      a[i] := val;
    end;
  end;

  procedure WriteArray(a: array of integer);
    var
      i: integer;
  begin
    for i := 0 to high(a) do begin
      Write(a[i]:4);
    end;
    WriteLn;
  end;

  function Max2(x, y: integer): integer;
  begin
    if x > y then
      Max2 := x
    else
      Max2 := y;
  end;

  function MaxSum1(a: array of integer): integer;
    var
      i, upper, lower: integer;
      max: integer;
      sum: integer;
  begin
    counter := 0;
    max := 0;
    for lower := 0 to high(a) do begin
      for upper := lower to high(a) do begin
        sum := 0;
        for i := lower to upper do begin
          sum := sum + a[i];
          inc(counter);
        end;
        max := Max2(max, sum)
      end;
    end;
    MaxSum1 := max;   
  end;


  function MaxSum2(a: array of integer): integer;
    var
      i, upper, lower: integer;
      max: integer;
      sum: integer;
  begin
    counter := 0;
    max := 0;
    for lower := 0 to high(a) do begin
      for upper := lower to high(a) do begin
        sum := 0;
        for i := lower to upper do begin
          sum := sum + a[i];
          inc(counter);
        end;
        max := Max2(max, sum)
      end;
    end;
    MaxSum1 := max;   
  end;

  function MaxSum3(a: array of integer): integer;
    var
      i: integer;
      max, maxEndingHere: Integer;
  begin
    maxEndingHere := Max2(maxEndingHere + a[i], 0);
    max := Max2(maxEndingHere, max);
    counter := counter + 1;






  var
    a1: array[0..5] of integer;
begin

  Init(a1);
  WriteArray(a1);
  WriteLn;
  WriteLn('MaxSum > ', MaxSum1(a1), 'no. of loops', counter);

end.