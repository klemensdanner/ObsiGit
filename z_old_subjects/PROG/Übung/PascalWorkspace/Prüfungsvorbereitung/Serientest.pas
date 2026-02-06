program SeriesTestProg;

  procedure SeriesTest(a: array of integer; r: integer);
    var
      count, i: integer;
      expected, actual: real;
  begin
    if r <= 0 then Halt(1);
    if (High(a) - Low(a) < 1) then Halt(2);

    count := 0;
    for i := Low(a) to High(a)-1 do begin
      if a[i] = a[i + 1] then begin
        inc(count);
      end;
    end;
    expected := 1.0 / r;
    actual := (1.0 * count) / (High(a)-Low(a)); //-1, bast scho
    WriteLn('Expected > ', expected);
    WriteLn('Actual > ', actual);
  end;

begin
end.