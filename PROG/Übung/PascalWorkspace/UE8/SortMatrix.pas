program SortMatrix;

  const
    rows = 4;
    columns = 3;
  
  type
    Row = array[1..columns] of integer;
    Matrix = array[1..rows] of Row;


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
