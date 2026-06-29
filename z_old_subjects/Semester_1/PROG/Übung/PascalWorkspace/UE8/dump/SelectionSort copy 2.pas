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

  // Returns the PARENT of the smallest node found in the list starting at l
  // Returns NIL if l itself is the smallest or l is nil
  function SmallestNodePt(l: ListPtr): ListNodePtr; 
    var
      minPtr, curr, minParent, pt: ListNodePtr;
  begin
    SmallestNodePt := nil;
    if l = nil then Exit;

    minPtr := l;
    minParent := nil;
    
    curr := l;
    pt := nil; // pt tracks the parent of curr

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

  procedure SelectionSort(VAR list: ListPtr);
    var
      sortedHead, sortedTail: ListPtr;
      unsortedHead: ListPtr;
      minParent, minNode: ListNodePtr;
  begin
    sortedHead := nil;
    sortedTail := nil;
    unsortedHead := list;

    // Repeat until the unsorted list is empty
    while unsortedHead <> nil do begin
      
      // 1. Find the parent of the smallest node in the unsorted part
      minParent := SmallestNodePt(unsortedHead);
      
      // 2. Identify the Min Node
      if minParent = nil then begin
        // The first node (unsortedHead) is the smallest
        minNode := unsortedHead;
        unsortedHead := unsortedHead^.next; // Advance unsorted head
      end else begin
        // Some node deep in the list is the smallest
        minNode := minParent^.next;
        minParent^.next := minNode^.next; // Unlink minNode from its current spot
      end;

      // 3. Move Min Node to the Sorted List
      minNode^.next := nil; // Isolate the node
      
      if sortedHead = nil then begin
        sortedHead := minNode;
        sortedTail := minNode;
      end else begin
        sortedTail^.next := minNode;
        sortedTail := minNode;
      end;
    end;

    // 4. Update the original list pointer
    list := sortedHead;
  end;

  var
    l: ListPtr;

begin
  l := nil;
  InitList(l, 10);
  Write('Original: ');
  WriteList(l);
  WriteLn;

  SelectionSort(l);
  
  Write('Sorted:   ');
  WriteList(l);
  WriteLn;
  DisposeList(l);
  ReadLn; // Keeps window open
end.