PROGRAM SortMatrix;

  CONST
    rows = 5;
    columns = 5;
  
  TYPE
    Row = ARRAY[1..columns] OF INTEGER;
    Matrix = ARRAY[1..rows] OF Row;

  PROCEDURE ReadMatrix(VAR m: Matrix);
    VAR
      i, j: INTEGER;
  BEGIN
    FOR i := 1 TO rows DO BEGIN
      Write('Enter a row with ', columns, ' columns > ');
      FOR j := 1 TO columns DO BEGIN
        Read(m[i][j]);
      END;
    END;
  END;

  PROCEDURE WriteMatrix(m: Matrix);
    VAR
      i, j: INTEGER;
  BEGIN
    FOR i := 1 TO rows DO BEGIN
      Write('[ ');
      FOR j := 1 TO columns DO BEGIN
        Write(m[i][j]:2);
      END;
      Write(' ]');
      WriteLn;
    END;
  END;


  FUNCTION RowGreaterThan(a, b: Row): BOOLEAN; (*returns true if a > b*)
    VAR
      len, i: INTEGER;
  BEGIN
    i := 1;
    len := length(a);

    WHILE (i <= len) AND (a[i] = b[i]) DO BEGIN
      inc(i);
    END;

    RowGreaterThan := (i <= len) AND (a[i] > b[i]);
  END;

  PROCEDURE SortLinesByColumns(VAR m: Matrix);
    VAR
      first, last: INTEGER;
      i, j: INTEGER;
      tmp: Row;
  BEGIN
    first := 1;
    last := rows;

    FOR i := first TO last - 1 DO BEGIN
      (* sorted area: first .. i*)
      tmp := m[i + 1];
      j := i;
      WHILE (j >= first) AND RowGreaterThan(m[j], tmp) DO BEGIN
        m[j + 1] := m[j];
        j := j - 1;
      END;
      m[j + 1] := tmp;
    END;
  END;

  VAR
    m: Matrix;

BEGIN
  ReadMatrix(m);
  WriteLn;
  WriteMatrix(m);
  WriteLn;

  SortLinesByColumns(m);
  WriteMatrix(m);
  WriteLn;
END.
