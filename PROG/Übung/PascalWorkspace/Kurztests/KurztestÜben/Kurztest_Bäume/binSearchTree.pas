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
    else if value > node^.data then
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
  
  { Rechter Hauptast }
  Insert(root, 75);
  Insert(root, 62);
  Insert(root, 87);
  Insert(root, 55);
  Insert(root, 68);
  Insert(root, 81);
  Insert(root, 95);
  
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









  var
    tree: TreePtr;


begin
  GenerateTree(tree);
  WriteTree(tree);
  WriteLn;

  WriteLn(BinSearchWay(tree, 68));
  WriteLn(BinSearchWayIter(tree, 68));



  WriteLn; WriteLn;
  DisposeTree(tree);
end.