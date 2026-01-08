(* ListSL:                                        DA, 2025-11-26, 2025-12-03 *)
(* ------                                                                    *)
(* Singly-linked list.                                                       *)
(* ========================================================================= *)
PROGRAM ListSL;

  (* --- declarations --- *)
  TYPE
    NodePtr = ^Node;
    Node = RECORD
      next: NodePtr;
      val: INTEGER;
    END; (* Node *)
    ListPtr = NodePtr;

  (* --- helpers --- *)
  PROCEDURE ASSERT(cond: BOOLEAN; msg: STRING);
  BEGIN (* ASSERT *)
    IF (NOT cond) THEN BEGIN
      WriteLn('ASSERTION FAILED: ', msg);
      HALT;
    END; (* IF *)
  END; (* ASSERT *)

  FUNCTION NewNode(val: INTEGER): NodePtr;
    VAR
      n: NodePtr;
  BEGIN (* NewNode *)
    New(n);  (* IF n = NIL THEN ... error handling *)
    n^.next := NIL;
    n^.val := val;
    NewNode := n;
  END; (* NewNode *)

  (* --- list algorithms --- *)

  PROCEDURE InitList(VAR l: ListPtr);
  BEGIN (* InitList *)
    l := NIL;
  END; (* InitList *)

  PROCEDURE DisposeList(VAR l: ListPtr);
    VAR
      n2Dispose: NodePtr;
  BEGIN (* DisposeList *)
    WHILE (l <> NIL) DO BEGIN
      n2Dispose := l;
      l := l^.next;
      Dispose(n2Dispose);
    END; (* WHILE *)
  END; (* DisposeList *)

  PROCEDURE Prepend(VAR l: ListPtr; n: NodePtr);
  BEGIN (* Prepend *)
    n^.next := l;
    l := n;
  END; (* Prepend *)

  PROCEDURE Append(VAR l: ListPtr; n: NodePtr);
    VAR
      last: NodePtr;
  BEGIN (* Append *)
    IF (l = NIL) THEN BEGIN
      l := n;
    END ELSE BEGIN
      last := l;
      WHILE (last^.next <> NIL) DO BEGIN
        last := last^.next;
      END; (* WHILE *)
      last^.next := n;
    END; (* IF *)
  END; (* Append *)

  FUNCTION Sorted(l: ListPtr): BOOLEAN;
    VAR
      n: NodePtr;
      succ: NodePtr; (* successor of n *)
  BEGIN (* Sorted *)
    IF (l = NIL) OR (l^.next = NIL) THEN BEGIN
      Sorted := TRUE;
    END ELSE BEGIN
      n := l;
      succ := n^.next;
      WHILE (succ <> NIL) AND (n^.val <= succ^.val) DO BEGIN
      { WHILE (n^.next <> NIL) AND (n^.val <= n^.next^.val) DO BEGIN (* without additional variable succ *)}
        succ := succ^.next;
        n := n^.next;
      END; (* WHILE *)
      Sorted := (succ = NIL);
    END; (* IF *)
  END; (* Sorted *)

  PROCEDURE Insert(VAR l: ListPtr; n: NodePtr);
    VAR
      prev: NodePtr; (* previous node, predecessor of current insert position for n *)
      succ: NodePtr; (* successor of current insert position *)      
  BEGIN (* Insert *)
    ASSERT(Sorted(l), 'List (in Insert) is not sorted!');
    prev := NIL;
    succ := l;
    WHILE (succ <> NIL) AND (n^.val > succ^.val) DO BEGIN
      prev := succ;
      succ := succ^.next;
    END; (* WHILE *)
    IF (prev = NIL) THEN BEGIN
      (*n^.next := succ; {alt. to : n^.next := l}*)
      l := n;
    END ELSE BEGIN
      prev^.next := n;
      (* n^.next := succ; *)
    END; (* IF *)
    n^.next := succ;
    ASSERT(Sorted(l), 'List (after Insert) is not sorted!');
  END; (* Insert *)

  FUNCTION NrOfNodes(l: ListPtr): INTEGER;
    VAR
      nr: INTEGER;
  BEGIN (* NrOfNodes *)
    nr := 0;
    WHILE (l <> NIL) DO BEGIN
      nr := nr + 1;
      l := l^.next;
    END; (* WHILE *)
    NrOfNodes := nr;
  END; (* NrOfNodes *)

  FUNCTION NodeWith(l: ListPtr; val: INTEGER): NodePtr;
  BEGIN (* NodeWith *)
    WHILE (l <> NIL) AND (l^.val <> val) DO BEGIN
      l := l^.next;
    END; (* WHILE *)
    NodeWith := l;
  END; (* NodeWith *)

  PROCEDURE DeleteFirstOccuranceOf(VAR l: ListPtr; val: INTEGER);
    VAR
      prev, curr: NodePtr;
      found: BOOLEAN;
  BEGIN (* DeleteFirstOccuranceOf *)
    prev := NIL;
    curr := l;
    found := FALSE;
    WHILE (curr <> NIL) AND (NOT found) DO BEGIN
      IF (curr^.val = val) THEN BEGIN
        found := TRUE;
        IF (prev = NIL) THEN BEGIN
          l := curr^.next;
        END ELSE BEGIN
          prev^.next := curr^.next;
        END; (* IF *)
        Dispose(curr);
      END ELSE BEGIN
        prev := curr;
        curr := curr^.next;
      END; (* IF *)
    END; (* WHILE *)
  END; (* DeleteFirstOccuranceOf *)

  PROCEDURE ReadListWithPrepend(VAR l: ListPtr);
    VAR
      n, i, val: INTEGER;
  BEGIN (* ReadListWithPrepend *)
    WriteLn('Provide the number of values for prepend in list');
    Write('n > '); ReadLn(n);
    InitList(l);
    FOR i := 1 TO n DO BEGIN
      Write('val > '); ReadLn(val);
      Prepend(l, NewNode(val));
    END; (* FOR *)
  END; (* ReadListWithPrepend *)

  PROCEDURE WriteList(l: ListPtr);
  BEGIN (* WriteList *)
    WHILE (l <> NIL) DO BEGIN
      Write(l^.val:3);
      l := l^.next;
    END; (* WHILE *) 
    WriteLn;   
  END; (* WriteList *)

  VAR
    l: ListPtr;

BEGIN (* ListSL *)
  InitList(l);
  {Prepend(l, NewNode(10));}
  {
  ReadListWithPrepend(l);
  
  Append(l, NewNode(11));
  WriteList(l);
  WriteLn('number of nodes = ', NrOfNodes(l));
}
  {WriteLn('List is sorted? ', Sorted(l));}
  Insert(l, NewNode(18));
  WriteList(l);
  DeleteFirstOccuranceOf(l, 19);
  WriteList(l);
  DisposeList(l);
END. (* ListSL *)