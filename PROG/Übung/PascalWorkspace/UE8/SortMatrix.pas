program SortMatrix;

  const
    rows = 4;
    columns = 5;
  
  type
    Row = array[1..columns] of integer;
    Matrix = array[1..rows] of Row;


  procedure FillMatrix(var m: Matrix);
    var
      i, j: integer;
  begin
    Randomize;
    for i := 1 to rows do begin
      for j := 1 to columns do begin
        m[i][j] := Random(10);
      end;
    end;
  end;


  procedure WriteMatrix(m: Matrix);
    var
      i, j: integer;
  begin
    for i := 1 to rows do begin
      Write('[ ');
      for j := 1 to columns do begin
        Write(m[i][j]:2);
      end;
      Write(' ]');
      WriteLn;
    end;
  end;


  function RowGreaterThan(a, b: Row): boolean; //returns true if a > b
    var
      len, i: integer;
  begin
    i := 1;
    len := length(a);

    while (i <= len) and (a[i] = b[i]) do begin
      inc(i);
    end;

    RowGreaterThan := (i <= len) and (a[i] > b[i]);
  end;



  procedure SortLinesByColumns(var m: Matrix);
    var
      first, last: integer;
      i, j: integer;
      tmp: Row;
  begin
    first := 1;
    last := rows;

    for i := first to last - 1 do begin
      // sorted area: first .. i
      tmp := m[i + 1];
      j := i;
      while (j >= first) and RowGreaterThan(m[j], tmp) do begin
        m[j + 1] := m[j];
        j := j - 1;
      end;
      m[j + 1] := tmp;
    end;
  end;


  var
    m: Matrix;

begin
  FillMatrix(m);
  WriteMatrix(m);
  WriteLn;

  SortLinesByColumns(m);
  WriteMatrix(m);
  WriteLn;
end.