PROGRAM FindFloor;
  TYPE
    TreeNodePtr = ^TreeNode;
    TreeNode = RECORD
      left, right: TreeNodePtr;
      data: INTEGER;
    END;
    TreePtr = TreeNodePtr;
  
  PROCEDURE InsertTree(VAR tree: TreePtr; val: INTEGER);
    VAR
      n: TreeNodePtr;
      st, pt: TreeNodePtr;
  BEGIN
    New(n);
    n^.left := NIL;
    n^.right := NIL;
    n^.data := val;

    IF tree = NIL THEN BEGIN
      tree := n;
      Exit;
    END;

    st := tree;
    pt := NIL;
    WHILE st <> NIL DO BEGIN
      pt := st;
      IF val < st^.data THEN BEGIN
        st := st^.left;
      END ELSE BEGIN
        st := st^.right;
      END;
    END;
    
    IF val < pt^.data THEN BEGIN
      pt^.left := n;
    END ELSE BEGIN
      pt^.right := n;
    END;
  END;

  PROCEDURE ReadTree(VAR tree: TreePtr);
    VAR
      val: INTEGER;
  BEGIN
    val := -1;
    WHILE val <> 0 DO BEGIN
      Write(' > ');
      ReadLn(val);
      IF val <> 0 THEN BEGIN
        InsertTree(tree, val);
      END;
    END;  
  END;

  PROCEDURE WriteTree(tree: TreePtr);
  BEGIN
    IF tree <> NIL THEN BEGIN
      WriteTree(tree^.left);
      Write(tree^.data:3);
      WriteTree(tree^.right);
    END;
  END;

  PROCEDURE DisposeTree(VAR tree: TreePtr);
  BEGIN
    IF tree <> NIL THEN BEGIN
      DisposeTree(tree^.left);
      DisposeTree(tree^.right);
      Dispose(tree);
    END;
    tree := NIL;
  END;

  FUNCTION Floor(tree: TreePtr; x: INTEGER): TreeNodePtr;
    VAR
      st: TreeNodePtr;
      possResult, result: TreeNodePtr;
  BEGIN
    IF tree = NIL THEN BEGIN
      Floor := NIL;
      Exit;
    END;
    st := tree;
    possResult := NIL;
    result := NIL;
    
    WHILE (st <> NIL) AND (st^.data <> x) DO BEGIN
      IF st^.data < x THEN BEGIN (*mögl. Treffer, rechts weitersuchen*)
        possResult := st;
        st := st^.right;
      END ELSE BEGIN (* st^.data > x, links weitersuchen*)
        st := st^.left;
      END;
    END;

    IF st = NIL THEN BEGIN
      result := possResult;
    END ELSE BEGIN
      result := st;
    END;
    
    Floor := result;
  END;

  VAR
    t: TreePtr;
    x: INTEGER;
    tmp: TreeNodePtr;

BEGIN
  t := NIL;
  ReadTree(t);
  WriteTree(t);
  WriteLn;

  Write(' Floor of > ');
  ReadLn(x);
  tmp := Floor(t, x);
  IF tmp <> NIL THEN BEGIN
    WriteLn(tmp^.data);
  END ELSE BEGIN
    WriteLn('Error: value invalid or tree empty');
  END;  

  DisposeTree(t);
END.
