program SortierverfahrenUebung;

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


  procedure SelectionSort(var a: TypeArray; first, last: integer); //sorts by element key
    var
      i, j: integer;
      minKeyIndex: integer;
  begin
    for i := first to last - 1 do begin // if first till last-1 is sorted, also last is at its right position
      //kleinsten von i bis last-1 finden und dann mit a[i] austauschen
      minKeyIndex := i;
      for j := i to last do begin // till last (smallest can be the very last one)
        if a[j].key < a[minKeyIndex].key then begin
          minKeyIndex := j;
        end;
      end;
      //j ist jetzt kleinster Index. jetzt tauschen
      Swap(a[i], a[minKeyIndex]);
    end;
  end;

  procedure InsertionSort(var a: TypeArray; first, last: integer);
    var
      i, j: integer;
      tmpElement: ElementType;
  begin
    for i := first to last - 1 do begin
      // sortierter bereich ist first bis incl i
      // a[i + 1] muss jetzt einsortiert werden
      tmpElement := a[i + 1];
      j := i;
      while (j >= first) and (tmpElement.key < a[j].key) do begin
        a[j + 1] := a[j];
        dec(j);
      end;
      a[j + 1] := tmpElement;
    end;
  end;

  procedure ShellSort(var a: TypeArray; first, last: integer);
    var
      i, j: integer;
      m: integer;
      tmpElement: ElementType;
  begin
    m := (last - first + 1) div 2;
    while m > 0 do begin
      for i := first to last - m do begin
        tmpElement := a[i + m];
        j := i;
        while (j >= first) and (tmpElement.key < a[j].key) do begin
          a[j + m] := a[j];
          j := j - m;
        end;
        a[j + m] := tmpElement;
      end;
      m := m div 2;
    end;
  end;



  var
    a: TypeArray;
    first, last: integer;

begin
  first := 1;
  last := 10;
  FillArray(a, first, last);

  Write('unsorted > ');
  WriteArrayKeys(a, first, last);

  ShellSort(a, first, last);

  WriteLn;
  Write('sorted   > ');
  WriteArrayKeys(a, first, last);

  WriteLn;


        

end.
