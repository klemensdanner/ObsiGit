program BinSearchTree;

  type
    TreeNodePtr = ^TreeNode;
    TreeNode = record
      left, right: TreeNodePtr;
      data: integer;
    end;
    TreePtr = TreeNodePtr;


  procedure WriteTree(tree: TreePtr);
  begin
    if tree <> nil then begin
      WriteTree(tree^.left);
      Write(tree^.data:3);
      WriteTree(tree^.right);
    end;
  end;

  //----- Gemini


{ --- Hilfsprozedur: Einfügen --- }
procedure Insert(var node: TreePtr; value: integer);
begin
  if node = nil then
  begin
    New(node);
    node^.data := value;
    node^.left := nil;
    node^.right := nil;
  end
  else
  begin
    if value < node^.data then
      Insert(node^.left, value)
    else
      Insert(node^.right, value);
  end;
end;

{ --- Hauptaufgabe: Baum generieren --- }
procedure GenerateTree(var root: TreePtr);
begin
  { Sicherstellen, dass der Baum leer startet }
  root := nil; 
  
{ Die 50 wird die Wurzel }
  Insert(root, 50);
  
  { Linker Hauptast }
  Insert(root, 25);
  Insert(root, 12);
  Insert(root, 37);
  Insert(root, 6);
  Insert(root, 18);
  Insert(root, 30);
  Insert(root, 43);
    Insert(root, 3);
  
  { Rechter Hauptast }
  Insert(root, 75);
  Insert(root, 62);
  Insert(root, 87);
  Insert(root, 55);
  Insert(root, 68);
  Insert(root, 81);
  Insert(root, 95);
    Insert(root, 18);
  
  WriteLn('Baum wurde generiert.');
end;

{ --- Hauptaufgabe: Baum löschen --- }
procedure DisposeTree(var node: TreePtr);
begin
  if node <> nil then
  begin
    DisposeTree(node^.left);
    DisposeTree(node^.right);
    Dispose(node);
    node := nil;
  end;
end;

{ --- Hauptprogramm zum Testen --- }



  //----- \Gemini

  function BinSearchWay(tree: TreePtr; x: integer): string;
  begin
    if tree <> nil then begin
      if x = tree^.data then begin
        BinSearchWay := ''; //element found, no further way needed
      end else if x > tree^.data then begin
        BinSearchWay := 'r' + BinSearchWay(tree^.right, x);
      end else if x < tree^.data then begin
        BinSearchWay := 'l' + BinSearchWay(tree^.left, x);
      end;
    end else begin
      BinSearchWay := 'Value not found';
    end;
  end;


  function BinSearchWayIter(tree: TreePtr; x: integer): string;
    var
      st: TreeNodePtr;
      pathString: string;
  begin
    if tree = nil then begin
      WriteLn('Error, empty tree');
      Exit;
    end;
    
    pathString := '';
    st := tree;
    while (st <> nil) and (st^.data <> x) do begin
      if x > st^.data then begin
        st := st^.right;
        pathString := pathString + 'r ';
      end else if x < st^.data then begin
        st := st^.left;
        pathString := pathString + 'l ';
      end;
    end;

    if st = nil then begin
      BinSearchWayIter := 'not_found';
    end else begin
      BinSearchWayIter := pathString;
    end;
  end;


  function Count(tree: TreeNodePtr; x: integer): integer;
  begin
    if tree <> nil then begin
      if tree^.data = x then begin
        Count := 1 + Count(tree^.left, x) + Count(tree^.right, x);
      end else begin
        Count := Count(tree^.left, x) + Count(tree^.right, x);
      end;
    end else begin
      Count := 0;
    end;
  end;

  function CountBinTree(t: TreeNodePtr; x: integer): integer;
    var
      st: TreeNodePtr;
      counter: integer;
  begin
    if t = nil then begin
      Exit;
    end;

    st := t;
    counter := 0;
    while st <> nil do begin
      if st^.data < x then begin
        st := st^.right;
      end else if st^.data = x then begin
        inc(counter);
        st := st^.right;
      end else begin
        st := st^.left;
      end;
    end;

    CountBinTree := counter;
  end;


  function CountBinTreeRec(t: TreeNodePtr; x: integer): integer;
  begin
    if t <> nil then begin
      if x > t^.data then begin
        CountBinTreeRec := CountBinTreeRec(t^.right, x);
      end else if x = t^.data then begin
        CountBinTreeRec := 1 + CountBinTreeRec(t^.right, x);
      end else begin
        CountBinTreeRec := CountBinTreeRec(t^.left, x);
      end;
    end else begin
      CountBinTreeRec := 0;
    end;
  end;

  function NumberOfLeaves(t: TreePtr): integer;
  begin
    if t = nil then begin
      NumberOfLeaves := 0;
      Exit;
    end;

    if (t^.right = nil) and (t^.left = nil) then begin
      NumberOfLeaves := 1;
    end else begin
      NumberOfLeaves := NumberOfLeaves(t^.left) + NumberOfLeaves(t^.right);
    end;
  end;


  // returns the node with the greatest value <= x
  function Floor(t: TreePtr; x: integer): TreeNodePtr;
    var
      res: TreeNodePtr;
  begin
    if t = nil then begin
      Floor := nil;
      Exit;
    end;

    if t^.data = x then begin
      Floor := t;
    end else if t^.data > x then begin
      Floor := Floor(t^.left, x);
    end else begin // t^.data < x - möglich, vll aber rechts noch was größeres
      res := Floor(t^.right, x);
      if res <> nil then begin
        Floor := res;
      end else begin
        Floor := t;
      end;
    end;
  end;


  function MinVal(t: TreePtr): integer;
    var
      min, minCurr, minL, minR: integer;
  begin
    if t = nil then begin
      MinVal := high(integer);
      Exit;
    end;

    minCurr := t^.data;
    minL := MinVal(t^.left);
    minR := MinVal(t^.right);

    if minL < minR then begin
      min := minL;
    end else begin
      min := minR;
    end;

    if min < minCurr then begin
      minCurr := min;
    end;

    MinVal := minCurr;
  end;



  var
    tree: TreePtr;


begin
  GenerateTree(tree);
  WriteTree(tree);
  WriteLn;

  WriteLn(BinSearchWayIter(tree, 68));

  WriteLn('count: ', Count(tree, 18));
  WriteLn('count: ', CountBinTree(tree, 18));
  WriteLn('count: ', CountBinTreeRec(tree, 18));

  WriteLn('NumberOfLeaves: ', NumberOfLeaves(tree));
  WriteLn('MinVal > ', MinVal(tree));



  WriteLn; WriteLn;
  DisposeTree(tree);
end.