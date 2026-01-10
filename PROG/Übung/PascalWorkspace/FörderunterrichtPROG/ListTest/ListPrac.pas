program PlayLists;

  type
    ListNodePtr = ^ListNode;
    ListNode = record
      next: ListNodePtr;
      data: integer;
    end;
    ListPtr = ListNodePtr;


  procedure Append(VAR l: ListPtr; value: integer);
    var
      curr: ListNodePtr;
      n: ListNodePtr;
  begin
    New(n);
    curr := l;
    if l = nil then begin
      n^.next := l;
      n^.data := value;
      l := n;
    end else begin
      // bis hinten durchlaufen, beim letzten stehen bleiben
      while (curr^.next <> nil) do begin
        curr := curr^.next;
      end;
      // jetzt hinten einfügen
      n^.next := nil;
      n^.data := value;
      curr^.next := n;
    end;
  end;

  procedure Prepend(var l: ListPtr; value: integer);
    var
      n: ListNodePtr;
  begin
    New(n);
    n^.data := value;
    n^.next := l;
    l := n;
  end;


  procedure DisposeList(var l: ListPtr); //nachher nil zuweisen!
    var
      curr, prev: ListNodePtr;
  begin
    curr := l;
    prev := nil;
    while (curr <> nil) do begin
      prev := curr;
      curr := curr^.next;
      Dispose(prev);
    end;
    l := nil;
  end;


  procedure ReadList(var l: ListPtr);
    var
      value: integer;
  begin
    value := 1;
    while value <> 0 do begin
      Write('value > ');
      ReadLn(value);
      if value <> 0 then
        Append(l, value);
    end;

  end;

  procedure WriteList(l: ListPtr);
    var
      curr: ListNodePtr;
  begin
    curr := l;
    write('[ ');
    while (curr <> nil) do begin
      write(curr^.data:3);
      curr := curr^.next;
    end;
    write(' ]');
    WriteLn;
  end;

  procedure RemoveMax(var l: ListPtr);
    var
      maxPtr, maxPrevPtr, prev, curr: ListNodePtr;
      max: integer;
  begin
    if l = nil then
      Exit;
    curr := l;
    prev := nil;
    maxPtr := nil;
    maxPrevPtr := nil;
    max := 0;
    while (curr <> nil) do begin //and (curr^.next <> nil) 
      if curr^.data > max then begin
        max := curr^.data;
        maxPtr := curr;
        maxPrevPtr := prev;
      end;
      prev := curr;
      curr := curr^.next;
    end;
    //Max entfernen
    if maxPrevPtr = nil then begin //erster wert ist der größte
      l := maxPtr^.next;
    end else begin
      maxPrevPtr^.next := maxPtr^.next;
      Dispose(maxPtr);
    end;
  end;


  procedure RemoveEvenIndex(var l: ListPtr);
    var
      counter: integer;
      prev, curr: ListNodePtr;
  begin
    if l = nil then
      Exit;
    
    counter := 0;
    prev := nil;
    curr := l;
    while curr <> nil do begin
      inc(counter);
      if (counter mod 2 = 0) then begin
        prev^.next := curr^.next;
        Dispose(curr);
        curr := prev^.next;
        //prev bleibt der vorgänger, da wir ja den wert in der mitte gelöscht haben
      end else begin
        prev := curr;
        curr := curr^.next;
      end;
    end;
  end;



  function CopyOdd(l: ListPtr): ListPtr;
    var
      nList, curr: ListNodePtr;
  begin
    if l = nil then
      Exit;
    
    nList := nil;
    curr := l;
    while (curr <> nil) do begin
      if (curr^.data mod 2 <> 0) then begin
        Append(nList, curr^.data);
      end;
      curr := curr^.next;
    end;
    CopyOdd := nList;
  end;

  var
    nList, list: ListPtr;


begin
  list := nil;

  ReadList(list);
  WriteList(list);
  WriteLn;

  nList := CopyOdd(list);
  WriteList(nList);

  DisposeList(nList);
  DisposeList(list);

end.