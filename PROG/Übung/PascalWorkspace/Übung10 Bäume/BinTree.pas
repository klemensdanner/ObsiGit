program BinTree;

  type
    TreeNodePtr = ^TreeNode;
    TreeNode = record
      left, right: TreeNodePtr;
      value: integer;
    end;
    TreePtr = TreeNodePtr;

  (*------------helpers-----------*)
  
  function NewNode(value: integer): TreeNodePtr;
    var
      n: TreeNodePtr;
  begin
    New(n);
    n^.left := nil;
    n^.right := nil;
    n^.value := value;
    NewNode := n;
  end;

    (*-------algos-------*)

  function TreeOf(n: TreeNodePtr; lt, rt: TreePtr): TreeNodePtr;
  begin
    //assert n<>nil and n <> lt, rt, and ....
    
    n^.left := lt;
    n^.right := rt;
    TreeOf := n;
  end;

  procedure WriteTreePreOrder(t: TreePtr);
  begin
    if (t <> nil) then begin
      Write(t^.value:3);
      WriteTreePreOrder(t^.left);
      WriteTreePreOrder(t^.right);
    end;
  end;

  // left, root, right subtree
  procedure WriteTreeInOrder(t: TreePtr);
  begin
    if (t <> nil) then begin
      WriteTreeInOrder(t^.left);
      Write(t^.value:3);
      WriteTreeInOrder(t^.right);
    end;
  end;


  procedure WriteTreePostOrder(t: TreePtr);
  begin
    if (t <> nil) then begin
      WriteTreePostOrder(t^.left);
      WriteTreePostOrder(t^.right);
      Write(t^.value:3);
    end;
  end;

  function NewTree: TreePtr;
  begin
    NewTree := NIL;
  end;

  procedure DisposeTree(var t: TreePtr);
  begin
    if t <> nil then begin
      DisposeTree(t^.left);
      DisposeTree(t^.right);
      Dispose(t);
      t := nil;
    end;
  end;

  function NrOfNodes(t: TreePtr): integer;
  begin
    if (t = nil) then
      NrOfNodes := 0
    else
      NrOfNodes := 1 + NrOfNodes(t^.left) + NrOfNodes(t^.right);
  end;


  function SumOfNodeVal(t: TreePtr): integer;
  begin
    if (t = nil) then
      SumOfNodeVal := 0
    else
      SumOfNodeVal := t^.value + SumOfNodeVal(t^.left) + SumOfNodeVal(t^.right);
  end;

  procedure WriteTreeGraph(t: TreePtr);
    procedure WTG(t: TreePtr; level: integer);
    begin
      if t <> nil then begin
        WTG(t^.left, level + 1);
        WriteLn(' ': level * 4, t^.value:3, '<');
        WTG(t^.right, level + 1);
      end;
    end;
  begin
    WTG(t, 0);
    WriteLn;
  end;

  procedure InsertRec(var t: TreePtr; n: TreeNodePtr);
  begin
    if t = nil then
      t := n
    else begin
      if n^.value < t^.value then
        InsertRec(t^.left, n)
      else
        InsertRec(t^.right, n);
    end;
  end;

  procedure InsertIter(var t: TreePtr; n: TreeNodePtr);
    var
      st: TreePtr; //subtree
      par: TreeNodePtr; //parent node of subtree

  begin
    if t = nil then
      t := n
    else begin
      st := t;
      par := NIL
      while (st <> nil) do begin
        par := st;
        if (n^.value < st^.value) then begin
          st := st^.left;
        end else begin
          st := st^.right;
        end;
      end;
      //insert left or right?
      if n^.value < par^.value then begin
        par^.left := n;
      end else begin
        par^.right := n;
      end;
    end;
  end;

  procedure Remove(var t: TreePtr; value: integer; var n: TreeNodePtr);
    var
      par: TreeNodePtr;
      st: TreePtr;
      
  begin
    par := nil;
    st: TreePtr;

    while (n <> nil) and (n^.value <> value) do begin //nicht fertig!
      par := n;
      if n^.value < par^.value then begin
        par^.left := n;
      end else begin
        par^.right := n;
      end;

    if n = nil then
      Exit;

    if (n^.right = nil) then begin //no right child
      st := n^.left;
    end else begin //right child has no left child
      if (n^.right^.left = nil) then begin
        st := n^.right;
        st^.left
      


  end;


  var
    t: TreePtr;

begin
  t := NewTree;
  t := TreeOf(NewNode(17),
        TreeOf(NewNode(3), TreeOf(NewNode(2), NewNode(1), nil), NewNode(8)), //linker Teilbaum
        TreeOf(NewNode(23), TreeOf(NewNode(19), NewNode(17), nil), NewNode(25))       
        );



  WriteTreePreOrder(t);
  WriteLn;



  WriteTreeInOrder(t);
  WriteLn;

  WriteTreePostOrder(t);
  WriteLn;

  WriteLn('no of nodes > ', NrOfNodes(t));
  WriteLn('sum of nodeVal > ', SumOfNodeVal(t));
  
  WriteTreeGraph(t);

  DisposeTree(t);

end.