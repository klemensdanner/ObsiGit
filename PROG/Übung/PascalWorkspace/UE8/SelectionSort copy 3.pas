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

{
    //swap first node
    ptB := SmallestNodePt(list);
    if ptB <> nil then begin //there is a smaller element than the first one
      b := ptB^.next; // b exists, ptB is its parent
      childOfB := b^.next; // can be nil if b is the last node
      a := list;

      b^.next := list^.next;
      list := b;

      ptB^.next := a;
      a^.next := ChildOfB;
    end;}

    //creating a parent dummy node
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
  InitList(l, 10);
  WriteList(l);
  WriteLn;

  SelectionSort(l);
  WriteList(l);
  WriteLn;
  DisposeList(l);
end.