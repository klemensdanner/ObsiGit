program SelSort;

  TYPE
    ListNodePtr = ^ListNode;
    ListNode = RECORD 
      next: ListNodePtr;
      data: INTEGER;
    END;
    ListPtr = ListNodePtr;

  procedure InitList(var l: ListPtr; len: integer);
    var
      n, first, curr: ListNodePtr;
      i: integer;
  begin
    Randomize;
    if l = nil then begin
      New(n);
      n^.next := nil;
      n^.data := Random(10);
      curr := n;
      first := n;
      for i := 2 to len do begin
        New(n);
        n^.next := nil;
        n^.data := Random(10);
        curr^.next := n;
        curr := curr^.next;
      end;
      curr^.next := nil;
      l := first;
    end;
  end;
    

  procedure DisposeList(var l: ListPtr);
    var
      curr, pt: ListNodePtr;
  begin
    curr := l;
    while curr <> nil do begin
      pt := curr;
      curr := curr^.next;
      Dispose(pt);
      pt := nil;
    end;
  end;

  procedure WriteList(l: ListPtr);
    var
      curr: ListNodePtr;
  begin
    curr := l;
    while curr <> nil do begin
      Write(curr^.data:3);
      curr := curr^.next;
    end;
  end;


  function SmallestNode(l: ListPtr): ListNodePtr; //returns smallest node
    var
      minPtr, curr: ListNodePtr;
  begin
    minPtr := l;
    curr := l;
    while curr <> nil do begin
      if curr^.data < minPtr^.data then begin
        minPtr := curr;
      end;
      curr := curr^.next;
    end;
    SmallestNode := minPtr;
  end;

  {procedure SwapData(a, b: ListNodePtr);
    var
      tmp: integer;
  begin
    tmp := a^.data;
    a^.data := b^.data;
    b^.data := tmp;
  end;}


  procedure SwapChildNodes(ptA, ptB: ListNodePtr); //swaps Nodes using their parents
    var
      a, b, childOfA: ListNodePtr;
  begin
    if (ptA = nil) or (ptB = nil) or (ptA^.next = nil) or (ptB^.next = nil) then begin
      WriteLn('Error: you cannot swap these nodes');
      Exit;
    end;
    a := ptA^.next;
    b := ptB^.next;
    //Swapping:
    childOfA := a^.next;

    ptB^.next := a;
    a^.next := b^.next;

    ptA^.next := b;
    b^.next := childOfA;
  end;

  procedure SelectionSort(VAR list: ListPtr);
    var
      curr: ListNodePtr;
  begin
    curr := list;
    while curr^.next <> nil do begin
      SwapData(SmallestNode(curr), curr); //curr immer <> nil, letzten Wert nicht tauschen
      curr := curr^.next;
    end;
  end;

  var
    l: ListPtr;

begin
  l := nil;
  InitList(l, 10);
  WriteList(l);
  WriteLn;

  SelectionSort(l);
  WriteList(l);
  WriteLn;
  DisposeList(l);
end.