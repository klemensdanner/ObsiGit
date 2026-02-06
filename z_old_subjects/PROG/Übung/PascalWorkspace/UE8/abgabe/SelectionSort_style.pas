PROGRAM SelSort;

  TYPE
    ListNodePtr = ^ListNode;
    ListNode = RECORD 
      next: ListNodePtr;
      data: INTEGER;
    END;
    ListPtr = ListNodePtr;

  PROCEDURE AddNode(VAR list: ListPtr; val: INTEGER);
    VAR
      newNode: ListNodePtr;
      last: ListNodePtr;
  BEGIN
      New(newNode);
      newNode^.data := val;
      newNode^.next := NIL;

      IF (list = NIL) THEN
        list := newNode
      ELSE BEGIN
        last := list;

        WHILE (last^.next <> NIL) DO BEGIN
          last := last^.next;
        END;

        last^.next := newNode;
      END;
  END;

  PROCEDURE ReadList(VAR l: ListPtr);
    VAR
      val: INTEGER;
  BEGIN
    WriteLn('Enter some int values for your list (end with 0): ');
    Write('> '); ReadLn(val);
    WHILE (val <> 0) DO BEGIN
      AddNode(l, val);
      Write('> '); ReadLn(val);
    END;

  END;

  PROCEDURE DisposeList(VAR l: ListPtr);
    VAR
      curr, pt: ListNodePtr;
  BEGIN
    curr := l;
    WHILE curr <> NIL DO BEGIN
      pt := curr;
      curr := curr^.next;
      Dispose(pt);
      pt := NIL;
    END;
  END;

  PROCEDURE WriteList(l: ListPtr);
    VAR
      curr: ListNodePtr;
  BEGIN
    curr := l;
    WHILE curr <> NIL DO BEGIN
      Write(curr^.data:3);
      curr := curr^.next;
    END;
  END;

  FUNCTION SmallestNodePt(l: ListPtr): ListNodePtr; (*returns parent of the smallest node*)
    VAR
      minPtr, curr, minParent, pt: ListNodePtr;
  BEGIN
    minPtr := l;
    minParent := NIL;
    curr := l;
    pt := NIL;
    WHILE curr <> NIL DO BEGIN
      IF curr^.data < minPtr^.data THEN BEGIN
        minParent := pt;
        minPtr := curr;
      END;
      pt := curr;
      curr := curr^.next;
    END;
    SmallestNodePt := minParent;
  END;

  PROCEDURE SwapChildNodes(ptA, ptB: ListNodePtr); (*swaps Nodes using their parents*)
    VAR
      a, b, childOfA: ListNodePtr;
  BEGIN
    IF (ptA = NIL) OR (ptB = NIL) OR (ptA^.next = NIL) OR (ptB^.next = NIL) THEN BEGIN
      WriteLn('Error: you cannot swap these nodes');
      Exit;
    END;
    a := ptA^.next;
    b := ptB^.next;

    (*Swapping Case 1: nodes to be swapped are neighbours*)
    IF (ptB = a) THEN BEGIN
      a^.next := b^.next;
      b^.next := a;
      ptA^.next := b;      
    END ELSE IF (ptA = b) THEN BEGIN
      b^.next := a^.next;
      a^.next := b;
      ptB^.next := a;
    END ELSE BEGIN (*general case*)
      childOfA := a^.next;

      ptB^.next := a;
      a^.next := b^.next;

      ptA^.next := b;
      b^.next := childOfA;
    END;
  END;

  PROCEDURE SelectionSort(VAR list: ListPtr);
    VAR
      pt: ListNodePtr;
      ptB, dummy: ListNodePtr;
  BEGIN
    IF (list = NIL) OR (list^.next = NIL) THEN BEGIN
      WriteLn('List is empty or has only one node');
      Exit;
    END;


    (* creating a parent dummy node*)
    New(dummy);
    dummy^.next := list;
    dummy^.data := -1;

    pt := dummy;

    WHILE (pt^.next <> NIL) DO BEGIN
      ptB := SmallestNodePt(pt^.next);
      IF ptB <> NIL THEN BEGIN (* smaller node found - swap*)
        SwapChildNodes(pt, ptB);
      END;
      pt := pt^.next;
    END;
    
    list := dummy^.next;
    Dispose(dummy);
    dummy := NIL;

  END;

  VAR
    l: ListPtr;

BEGIN
  l := NIL;
  ReadList(l);
  IF l <> NIL THEN BEGIN
    Write('unsorted >');
    WriteList(l);
    WriteLn;
  END;

  SelectionSort(l);
  IF l <> NIL THEN BEGIN
    Write('sorted   >');
    WriteList(l);
    WriteLn;
  END;
  DisposeList(l);
END.
