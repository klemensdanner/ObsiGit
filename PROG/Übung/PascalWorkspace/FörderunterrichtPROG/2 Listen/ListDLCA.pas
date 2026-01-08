(* ListDLCA:                                                  DA, 2025-12-03 *)
(* ------                                                                    *)
(* DL ... doubly linked                                                      *)
(* C  ... cyclic                                                             *)
(* A  ... with anchor                                                        *)
(* Basic data structures and algorithms for handling such linked lists.      *)
(* ========================================================================= *)
PROGRAM ListDLCA;

  (* --- declarations --- *)
  TYPE
    NodePtr = ^Node;
    Node = RECORD
      prev, next: NodePtr;
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
    n^.next := n;
    n^.prev := n;
    n^.val := val;
    NewNode := n;
  END; (* NewNode *)

  (* --- list algorithms --- *)

  PROCEDURE DisposeList(VAR l: ListPtr); FORWARD;

  PROCEDURE InitList(VAR l: ListPtr);
  BEGIN (* InitList *)
    IF (l <> NIL) THEN BEGIN
      DisposeList(l);
    END; (* IF *)
    l := NewNode(0);
  END; (* InitList *)

  PROCEDURE DisposeList(VAR l: ListPtr);
    VAR
      n, curr: NodePtr;
  BEGIN (* DisposeList *)
    curr := l^.next;
    WHILE (curr <> l) DO BEGIN
      n := curr;
      curr := curr^.next;
      Dispose(n);
    END; (* WHILE *)
    Dispose(l);
    l := NIL;
  END; (* DisposeList *)

  PROCEDURE Prepend(l: ListPtr; n: NodePtr);
  BEGIN (* Prepend *)
    n^.prev := l;
    n^.next := l^.next;
    l^.next^.prev := n;
    l^.next := n;
  END; (* Prepend *)  

  PROCEDURE Append(l: ListPtr; n: NodePtr);
  BEGIN (* Append *)
    n^.next := l;
    n^.prev := l^.prev;
    l^.prev^.next := n;
    l^.prev := n;    
  END; (* Append *)

  FUNCTION Sorted(l: ListPtr): BOOLEAN;
    VAR
      n: NodePtr;
  BEGIN (* Sorted *)
    IF (l^.next = l^.prev) THEN BEGIN  (* no or only one node *)
      Sorted := TRUE;
    END ELSE BEGIN
      n := l^.next;
      WHILE (n^.next <> l) AND (n^.val <= n^.next^.val) DO BEGIN
        n := n^.next;
      END; (* WHILE *)
      Sorted := (n^.next = l);
    END; (* IF *)
  END; (* Sorted *)

  PROCEDURE Insert(VAR l: ListPtr; n: NodePtr);
    VAR
      succ: NodePtr;  (* successor for n *)
  BEGIN (* Insert *)
    Assert(Sorted(l), 'in Insert() - start: list not sorted');
    (* search for insertion position *)
    succ := l^.next;
    WHILE (succ <> l) AND (n^.val > succ^.val)  DO BEGIN
      succ := succ^.next;
    END; (* WHILE *)

    (* insert n right before succ *)
    n^.prev := succ^.prev;
    n^.next := succ;
    succ^.prev^.next := n;
    succ^.prev := n;
    Assert(Sorted(l), 'in Insert() - end: list not sorted');    
  END; (* Insert *)

  PROCEDURE WriteList(l: ListPtr);
    VAR
      n: NodePtr;
  BEGIN (* WriteList *)
    n := l^.next; 
    WHILE (n <> l) DO BEGIN
      Write(n^.val:5);
      n := n^.next;
    END; (* WHILE *)
    WriteLn;            
  END; (* WriteList *)

  VAR
    l: ListPtr;

BEGIN (* ListDLCA *)
  InitList(l);
  Append(l, NewNode(3));
  Append(l, NewNode(7));
  Prepend(l, NewNode(2));
  WriteList(l);
  Insert(l, NewNode(1));
  WriteList(l);
  Insert(l, NewNode(99));
  WriteList(l);
  Insert(l, NewNode(1));
  WriteList(l);
  Insert(l, NewNode(17));
  WriteList(l);
  DisposeList(l);
  
END. (* ListDLCA *)
