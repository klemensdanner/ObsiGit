(* ListDL:                                                   DA,  2025-12-03 *)
(* ------                                                                    *)
(* Doubly-linked list.                                                       *)
(* ========================================================================= *)
PROGRAM ListDL;

  (* --- declarations --- *)
  TYPE
    NodePtr = ^Node;
    Node = RECORD
      prev, next: NodePtr;
      val: INTEGER;
    END; (* Node *)
    List = RECORD
      first: NodePtr;
      last: NodePtr;
    END;

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
    n^.prev := NIL;
    n^.next := NIL;
    n^.val := val;
    NewNode := n;
  END; (* NewNode *)

  (* --- list algorithms --- *)

  PROCEDURE InitList(VAR l: List);
  BEGIN (* InitList *)
    l.first := NIL;
    l.last := NIL;
  END; (* InitList *)

  PROCEDURE DisposeList(VAR l: List);
    VAR
      n2Dispose: NodePtr;
      n: NodePtr;
  BEGIN (* DisposeList *)
    n := l.first;
    WHILE (n <> NIL) DO BEGIN
      n2Dispose := n;
      n := n^.next;
      Dispose(n2Dispose);
    END; (* WHILE *)
    l.first := NIL;
    l.last := NIL;
  END; (* DisposeList *)

  PROCEDURE Prepend(VAR l: List; n: NodePtr);
  BEGIN (* Prepend *)
    IF (l.first = NIL) THEN BEGIN
      l.first := n;
      l.last := n;
    END ELSE BEGIN
      n^.next := l.first;
      l.first^.prev := n;
      l.first := n;
      {n^.next^.prev := n; (* alt. to line 2 *)}
    END; (* IF *)
  END; (* Prepend *)

  PROCEDURE Append(VAR l: List; n: NodePtr);
  BEGIN (* Append *)
    IF (l.last = NIL) THEN BEGIN
      l.last := n;
      l.first := n;
    END ELSE BEGIN
      n^.prev := l.last;
      l.last^.next := n;
      l.last := n;
    END; (* IF *)
  END; (* Append *)  

  PROCEDURE Insert(VAR l: List; n: NodePtr);
    VAR
      succ: NodePtr; (* successor of new node n *)
  BEGIN (* Insert *)
    IF l.first = NIL THEN BEGIN (* l.last = NIL, too *)
      l.first := n;
      l.last := n;
    END ELSE BEGIN
      succ := l.first;
      WHILE (succ <> NIL) AND (n^.val > succ^.val) DO BEGIN
        succ := succ^.next;
      END; (*WHILE*)
      IF succ = l.first THEN BEGIN (* prepend n *)
        n^.next := l.first;
        l.first^.prev := n;
        l.first := n;
      END ELSE IF succ = NIL THEN BEGIN (* append n *)
        n^.prev := l.last;
        l.last^.next := n;
        l.last := n;
      END ELSE BEGIN (* insert n in the middle, before succ *)
        n^.prev := succ^.prev;
        n^.next := succ;
        succ^.prev^.next := n;
        succ^.prev := n;
      END; (* ELSE *)
    END; (* ELSE *)
  END; (* Insert *)  

  PROCEDURE WriteList(lRec: List);
    VAR
      l: NodePtr;
  BEGIN (* WriteList *)
    l := lRec.first;
    WHILE (l <> NIL) DO BEGIN
      Write(l^.val:3);
      l := l^.next;
    END; (* WHILE *) 
    WriteLn;   
  END; (* WriteList *)

  VAR
    l: List;

BEGIN (* ListDL *)
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
END. (* ListDL *)
