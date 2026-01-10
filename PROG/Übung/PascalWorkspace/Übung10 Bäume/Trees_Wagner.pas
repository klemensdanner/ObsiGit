(* TreesPrg:                                                 SWa, 2025-12-17 *)
(* ---------                                                                 *)
(* Fun with binary (search) trees.                                           *)
(* ========================================================================= *)
PROGRAM TreesPrg;

  TYPE
    Node = ^NodeRec;
    NodeRec = RECORD
      value: INTEGER;
      left, right: Node;
    END; (* NodeRec *)
    Tree = Node;

  FUNCTION NewNode(value: INTEGER): Node;
    VAR
      n: Node;
  BEGIN (* NewNode *)
    New(n);
    n^.value := value;
    n^.left := NIL;
    n^.right := NIL;
    NewNode := n;    
  END; (* NewNode *)

  FUNCTION TreeOf(n: Node; left, right: Tree): Tree;
  BEGIN (* TreeOf *)
    IF (n = NIL) THEN BEGIN
      WriteLn('ERROR: n is NIL');
      Exit;
    END; (* IF *)
    IF (left = right) THEN BEGIN
      WriteLn('ERROR: left and right are invalid');
      Exit;
    END; (* IF *)

    n^.left := left;
    n^.right := right;
    TreeOf := n;
  END; (* TreeOf *)

  PROCEDURE InitTree(VAR t: Tree);
  BEGIN (* InitTree *)
    t := NIL;    
  END; (* InitTree *)

  PROCEDURE DisposeTree(VAR t: Tree);
  BEGIN (* DisposeTree *)
    IF (t <> NIL) THEN BEGIN
      DisposeTree(t^.left);
      DisposeTree(t^.right);
      Dispose(t);
      t := NIL;
    END; (* IF *)
  END; (* DisposeTree *)

  PROCEDURE WriteTreePreorder(t: Tree);
  BEGIN (* WriteTreePreorder *)
    IF (t <> NIL) THEN BEGIN
      Write(t^.value, ' ');
      WriteTreePreorder(t^.left);
      WriteTreePreorder(t^.right);
    END; (* IF *)
  END; (* WriteTreePreorder *)

  PROCEDURE WriteTreePostorder(t: Tree);
  BEGIN (* WriteTreePostorder *)
    IF (t <> NIL) THEN BEGIN
      WriteTreePostorder(t^.left);
      WriteTreePostorder(t^.right);
      Write(t^.value, ' ');
    END; (* IF *)
  END; (* WriteTreePostorder *)

  PROCEDURE WriteTreeInorder(t: Tree);
  BEGIN (* WriteTreeInorder *)
    IF (t <> NIL) THEN BEGIN
      WriteTreeInorder(t^.left);
      Write(t^.value, ' ');
      WriteTreeInorder(t^.right);
    END; (* IF *)
  END; (* WriteTreeInorder *)

  FUNCTION ContainsRec(t: Tree; value: INTEGER): BOOLEAN;
  BEGIN (* ContainsRec *)
    IF (t = NIL) THEN BEGIN
      ContainsRec := FALSE;
    END ELSE IF (t^.value = value) THEN BEGIN
      ContainsRec := TRUE;
    END ELSE IF (value < t^.value) THEN BEGIN
      ContainsRec := ContainsRec(t^.left, value);
    END ELSE BEGIN
      ContainsRec := ContainsRec(t^.right, value);
    END; (* IF *)
  END; (* ContainsRec *)

  FUNCTION ContainsIter(t: Tree; value: INTEGER): BOOLEAN;
    VAR
      n: Node;
  BEGIN (* ContainsIter *)
    n := t;
    WHILE ((n <> NIL) AND (n^.value <> value)) DO BEGIN
      IF (value < n^.value) THEN BEGIN
        n := n^.left;
      END ELSE BEGIN
        n := n^.right;
      END; (* IF *)
    END; (* WHILE *)
    ContainsIter := n <> NIL;
  END; (* ContainsIter *)

  PROCEDURE InsertRec(VAR t: Tree; n: Node);
  BEGIN (* InsertRec *)
    IF (t = NIL) THEN BEGIN
      t := n;
    END ELSE BEGIN
      IF (n^.value < t^.value) THEN BEGIN
        InsertRec(t^.left, n);
      END ELSE BEGIN
        InsertRec(t^.right, n);
      END; (* IF *)
    END; (* IF *)
  END; (* InsertRec *)

  procedure Remove(var t: Tree; value: integer);
    var
      n, parent, child: Node; //der Knoten, der den 
      succ, succParent: Node;
  begin
    n := t;
      WHILE ((n <> NIL) AND (n^.value <> value)) DO BEGIN
        parent := n;
        IF (value < n^.value) THEN BEGIN
          n := n^.left;
        END ELSE BEGIN
          n := n^.right;
        END; (* IF *)
      END; (* WHILE *)

      if n <> nil then begin //Wert existiert
        if (n^.right = nil) then begin //Fall: kein rechtes Kind
          child := n^.left;
        end else if (n^.right^.left = nil) then begin //rechtes Kind hat kein linkes Kind
          child := n^.right;
          child^.left := n^.left;
        end else begin //nächstgrößere Node im rechten Teilbaum von n finden
          succParent := n^.right;
          succ := n^.right^.left;
          while succ^.left <> nil do begin 
            succParent := succ;
            succ := succ^.left;
          end;
          succParent^.left := succ^.right;
          succ^.left := n^.left
          succ^.right := n^.right
          child := succ;
        end;


        if (parent = nil) then begin
          t := child;
        end else if (n^.val < parent^.val) then begin
          parent^.left := child;
        end else begin
          parent^.right := child;
        end;
        Dispose(n);







      end;
  end;






  VAR
    t: Tree;

BEGIN (* TreesPrg *)
  t := TreeOf(NewNode(17),
              TreeOf(NewNode(10),
                     TreeOf(NewNode(2),
                            NIL,
                            NewNode(4)),
                     NIL),
              TreeOf(NewNode(28),
                     NewNode(19),
                     NIL));
  Write('Preorder:  ');
  WriteTreePreorder(t);
  WriteLn;
  Write('Inorder:   ');
  WriteTreeInorder(t);
  WriteLn;
  Write('Postorder: ');
  WriteTreePostorder(t);
  WriteLn;

  InsertRec(t, NewNode(7));
  WriteTreeInorder(t);
  WriteLn;

  WriteLn('ContainsRec(7):  ', ContainsRec(t, 7));
  WriteLn('ContainsRec(8):  ', ContainsRec(t, 8));
  WriteLn('ContainsIter(7): ', ContainsIter(t, 7));
  WriteLn('ContainsIter(8): ', ContainsIter(t, 8));

  DisposeTree(t);
END. (* TreesPrg *)
