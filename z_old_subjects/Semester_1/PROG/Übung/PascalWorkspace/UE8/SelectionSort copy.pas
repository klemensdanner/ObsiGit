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

  procedure AddNode(var list: ListPtr; val: integer);
    var
      newNode: ListNodePtr;
      last: ListNodePtr;
  begin
      New(newNode);
      newNode^.data := val;
      newNode^.next := NIL;

      if (list = nil) then
        list := newNode
      else begin
        last := list;

        while (last^.next <> nil) do begin
          last := last^.next;
        end;

        last^.next := newNode;
      end;
  end;

  procedure ReadList(var l: ListPtr);
    var
      val: integer;
  begin
    WriteLn('Enter some int values for your list (end with 0): ');
    Write('> '); ReadLn(val);
    while (val <> 0) do begin
      AddNode(l, val);
      Write('> '); ReadLn(val);
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


  function SmallestNodePt(l: ListPtr): ListNodePtr; //returns parent of the smallest node
    var
      minPtr, curr, minParent, pt: ListNodePtr;
  begin
    minPtr := l;
    minParent := nil;
    curr := l;
    pt := nil;
    while curr <> nil do begin
      if curr^.data < minPtr^.data then begin
        minParent := pt;
        minPtr := curr;
      end;
      pt := curr;
      curr := curr^.next;
    end;
    SmallestNodePt := minParent;
  end;



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

    //Swapping Case 1: nodes to be swapped are neighbours
    if (ptB = a) then begin
      a^.next := b^.next;
      b^.next := a;
      ptA^.next := b;      
    end else if (ptA = b) then begin
      b^.next := a^.next;
      a^.next := b;
      ptB^.next := a;
    end else begin //general case
      childOfA := a^.next;

      ptB^.next := a;
      a^.next := b^.next;

      ptA^.next := b;
      b^.next := childOfA;
    end;
  end;

  procedure SelectionSort(VAR list: ListPtr);
    var
      pt: ListNodePtr;
      ptB, dummy: ListNodePtr;
  begin
    if (list = nil) or (list^.next = nil) then begin
      WriteLn('List is empty or has only one node');
      Exit;
    end;


    // creating a parent dummy node
    New(dummy);
    dummy^.next := list;
    dummy^.data := -1;

    pt := dummy;

    while (pt^.next <> nil) do begin
      ptB := SmallestNodePt(pt^.next);
      if ptB <> nil then begin // smaller node found - swap
        SwapChildNodes(pt, ptB);
      end;
      pt := pt^.next;
    end;
    
    list := dummy^.next;
    Dispose(dummy);
    dummy := nil;

  end;

  var
    l: ListPtr;

begin
  l := nil;
  //InitList(l, 10);
  ReadList(l);
  if l <> nil then begin
    Write('unsorted >');
    WriteList(l);
    WriteLn;
  end;

  SelectionSort(l);
  if l <> nil then begin
    Write('sorted   >');
    WriteList(l);
    WriteLn;
  end;
  DisposeList(l);
end.