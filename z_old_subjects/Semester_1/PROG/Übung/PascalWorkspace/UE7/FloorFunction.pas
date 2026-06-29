program FindFloor;
  type
    TreeNodePtr = ^TreeNode;
    TreeNode = record
      left, right: TreeNodePtr;
      data: integer;
    end;
    TreePtr = TreeNodePtr;
  
  procedure InsertTree(var tree: TreePtr; val: integer);
    var
      n: TreeNodePtr;
      st, pt: TreeNodePtr;
  begin
    New(n);
    n^.left := nil;
    n^.right := nil;
    n^.data := val;

    if tree = nil then begin
      tree := n;
      Exit;
    end;

    st := tree;
    pt := nil;
    while st <> nil do begin
      pt := st;
      if val < st^.data then begin
        st := st^.left;
      end else begin
        st := st^.right;
      end;
    end;
    
    if val < pt^.data then begin
      pt^.left := n;
    end else begin
      pt^.right := n;
    end;
  end;

  procedure ReadTree(var tree: TreePtr);
    var
      val: integer;
  begin
    val := -1;
    while val <> 0 do begin
      Write(' > ');
      ReadLn(val);
      if val <> 0 then begin
        InsertTree(tree, val);
      end;
    end;  
  end;

  procedure WriteTree(tree: TreePtr);
  begin
    if tree <> nil then begin
      WriteTree(tree^.left);
      Write(tree^.data:3);
      WriteTree(tree^.right);
    end;
  end;

  procedure DisposeTree(var tree: TreePtr);
  begin
    if tree <> nil then begin
      DisposeTree(tree^.left);
      DisposeTree(tree^.right);
      Dispose(tree);
    end;
  end;

  function Floor(tree: TreePtr; x: INTEGER): TreeNodePtr;
    var
      st: TreeNodePtr;
      possResult, result: TreeNodePtr;
  begin
    if tree = nil then begin
      Floor := NIL;
      Exit;
    end;
    st := tree;
    possResult := nil;
    result := nil;
    
    while (st <> nil) and (st^.data <> x) do begin
      if st^.data < x then begin //mögl. Treffer, rechts weitersuchen
        possResult := st;
        st := st^.right;
      end else begin // st^.data > x, links weitersuchen
        st := st^.left;
      end;
    end;

    if st = nil then begin
      result := possResult;
    end else begin
      result := st;
    end;
    
    Floor := result;
  end;

  var
    t: TreePtr;
    x: integer;
    tmp: TreeNodePtr;

begin
  t := nil;
  ReadTree(t);
  WriteTree(t);
  WriteLn;

  Write(' Floor of > ');
  ReadLn(x);
  tmp := Floor(t, x);
  if tmp <> nil then begin
    WriteLn(tmp^.data);
  end else begin
    WriteLn('Error: value invalid or tree empty');
  end;  

  DisposeTree(t);
end.