(* ListSL:                                                    DA, 2025-11-26 *)
(* ------                                                                    *)
(* singly linked list                                                        *)
(* ========================================================================= *)

program ListSL;
  type
    NodePtr = ^Node;
    Node = record
      next: NodePtr;
      val: integer;
    end;
    ListPtr = ^Node;

  (*h ---- helpers ----- *)

  Function NewNode(val: integer): NodePtr;
    var
      n: NodePtr;
  begin
    New(n); //speicher am hieb allokieren, wenn kein speicher mehr da wär der Wert gleich nil
    n^.next := nil;
    n^.val := val;

    NewNode := n;
  end;


  
  procedure InitList(var l: ListPtr);
  begin
    l := nil;
  end;

  procedure Prepend(var l: ListPtr; n: NodePtr); //vorne einfügen
  begin
    n^.next := l;
    l := n;
  end;

  procedure DisposeList(var l: ListPtr);
    var
      n2Dispose: NodePtr;
  begin
    while (l <> NIL) do begin
      n2Dispose := l;
      l := l^.next;
      Dispose(n2Dispose);
    end; //while
  end;

  procedure WriteList(l: ListPtr);
  begin
    while l <> nil do begin
      Write(l^.val:3);
      l := l^.next;
    end; //while
  WriteLn;
  end;


  function NrOfNodes(l: ListPtr): integer;
  var
    nr: integer;
  begin
    while (l <> nil) do begin
      inc(nr);
    end; (*while*)
    NrOfNodes := nr;
  end;

  function NodeWith(l: ListPtr; val: integer): NodePtr;
  begin
    while (l <> NIL) AND (val <> l^.val) do begin
      l := l^.next;
    end; (*while*)

    NodeWith := l;
  end;


  procedure ReadListWithPrepend(var l: ListPtr);
    var
      i, n, val: integer;
  begin
    WriteLn('Provide the number of values for prepend in list');
    Write('n > '); ReadLn(n);
    InitList(l);
    for i := 1 to n do begin
      Write('val > '); ReadLn(val);
      Prepend(l, NewNode(val));
    end; //for


procedure Append(var l: ListPtr; n: NodePtr); //man geht davon aus, dass in n^next schon null steht, wie in der funktion newnode drin steht
  var
    last: ListPtr;
begin
  if (l = nil) then begin
      l := n;
    while (last^.next <> nil) do begin
      last := last^.next;
    end; //while
    last^.next := n;
  end; //if
end;















  var
    testlist: ListPtr;


begin
  InitList(testlist);
  //Prepend(l, NewNode(10));


  ReadListWithPrepend(testlist);
  WriteList(testlist);
  DisposeList(testlist);

 








end.