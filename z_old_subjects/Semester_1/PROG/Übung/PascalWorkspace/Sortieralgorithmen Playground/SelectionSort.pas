program Sortierverfahren;

  type
    ElementType = record
      key: integer;
      data: integer;
    end;
  
  const
    n = 10;

  type
    TypeArray = array [1..n] of ElementType;

  procedure Swap(var a, b: ElementType);
    var
      tmp: ElementType;
  begin
    tmp := a;
    a := b;
    b := tmp;
  end;

  procedure WriteArrayKeys(a: TypeArray; first, last: integer);
    var
      i: integer;
  begin
    for i := first to last do begin
      Write(a[i].key:3, ' ');
    end;
  end;


  procedure FillArray(var a: TypeArray; first, last: integer);
    var
      i: integer;
  begin
    Randomize;
    for i := first to last do begin
      a[i].key := Random(n);
      a[i].data := Random(n);
    end;
  end;

  procedure SelectionSort(VAR a: TypeArray; first, last: integer);
    var
      i, j: integer;
      minPos, minKey: integer;
  begin
    for i := first to (last - 1) do begin //last ist bereits sortiert
      minPos := i;
      minKey := a[i].key;
      // jetzt kleinsten Wert suchen
      for j := i + 1 to last do begin
        if a[j].key < minKey then begin
          minKey := a[j].key;
          minPos := j;
        end;
      end;
      Swap(a[i], a[minPos]);
    end;
  end;

  procedure InsertionSort(var a: TypeArray; first, last: integer);
    var
      i, j: integer;
      e: ElementType;

  begin
    for i := first + 1 to last do begin 
      //Sortierter Bereich: first bis i-1
      //darin einzufügen: i
      j := i;
      e := a[i];
      while (j > first) and (a[j-1].key > e.key) do begin //verschieben
        a[j] := a[j-1];
        dec(j);
      end;
      a[j] := e; //bei j+1 einfügen
    end;
  end;
  

  var
    a: TypeArray;
    first, last: longint;

begin
  first := 1;
  last := n;

  FillArray(a, first, last);

  //Write('Random > ');
  WriteArrayKeys(a, first, last);
  WriteLn;

  InsertionSort(a, first, last);
  Write('Sorted > ');
  WriteArrayKeys(a, first, last);
  WriteLn;

end.





