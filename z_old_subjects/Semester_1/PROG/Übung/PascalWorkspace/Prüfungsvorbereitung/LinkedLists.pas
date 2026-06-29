program LinkedLists;

  type
    ListNodePtr = ^ListNode;
    ListNode = record
      data: integer;
      next, prev: ListNodePtr;
    end;
    ListPtr = ListNodePtr;

  procedure Append(var l: ListPtr; val: integer);
    var
      curr, node: ListPtr;
  begin
    New(node);
    node^.next := nil;
    node^.data := val;

    curr := l;
    if l = nil then begin
      node^.prev := nil;
      l := node;
    end else begin
      while curr^.next <> nil do begin
        curr := curr^.next;
      end;
      //curr ist am letzten Knoten
      node^.prev := curr;
      curr^.next := node;
    end;
  end;
  
  procedure FillList(var l: ListPtr);
    var
      i: integer;
  begin
    for i := 1 to 10 do begin
      Append(l, i);
    end;
  end;

  procedure ReadList(var l: ListPtr);
    var
      val: integer;
  begin
    val := -1;
    while val <> 0 do begin
      Write(' > ');
      ReadLn(val);
      if val <> 0 then begin
        Append(l, val);
      end;
    end;
  end;

  procedure DisposeList(var l: ListPtr);
    var
      tmp, curr: ListNodePtr;
  begin
    curr := l;
    tmp := l;
    while curr <> nil do begin
      tmp := curr;
      curr := curr^.next;
      Dispose(tmp);
    end;
    tmp := nil;
    curr := nil;
    l := nil;
  end;

  procedure WriteList(l: ListPtr);
  begin
    while l <> nil do begin
      Write(l^.data:3);
      l := l^.next;
    end;
    WriteLn;
  end;

  procedure Invert(var list: ListPtr);
    var
      pt, curr, tmp: ListPtr;
  begin
    if list = nil then begin
      Exit;
    end;
    tmp := list;
    curr := list;
    pt := nil;

    while curr <> nil do begin
      pt := curr;
      tmp := curr^.next;
      curr^.next := curr^.prev;
      curr^.prev := tmp;
      curr := tmp;
    end;
    //pt zeigt auf letztes element
    list := pt;
  end;


  procedure InvertSLL(var list: ListPtr);
    var
      prev, curr, succ: ListNodePtr;
  begin
    if (list = nil) or (list^.next = nil) then begin
      Write('Error');
      Exit;
    end;

    curr := list;
    succ := curr^.next; //list <> nil, oben geprüft
    prev := nil;

    while succ <> nil do begin
      curr^.next := prev;
      prev := curr;
      //weitergehen
      curr := succ;
      succ := succ^.next;
    end;
    curr^.next := prev;
    list := curr;
    
  end;

  procedure MoveLastNodeToFront(var list: ListPtr);
    var
      prev, curr: ListPtr;
  begin
    prev := nil;
    curr := list;
    if (list = nil) or (list^.next = nil) then begin
      Write('already sorted');
      Exit;
    end;
    while curr^.next <> nil do begin
      prev := curr;
      curr := curr^.next;
    end;

      prev^.next := nil;
      curr^.next := list;
      list := curr;
  end;

  procedure Merge(var a, b, c: ListPtr);
    var
      aCurr, bCurr: ListPtr;
      aPrev, bCurrNext: ListPtr;
  begin
    aCurr := a;
    bCurr := b;
    aPrev := nil;
    bCurrNext := nil;
    while bCurr <> nil do begin
      aCurr := a;
      aPrev := nil;
      while (aCurr <> nil) and (bCurr^.data > aCurr^.data) do begin
        aPrev := aCurr;
        aCurr := aCurr^.next;
      end;
      bCurrNext := bCurr^.next;
      if aPrev <> nil then begin
        aPrev^.next := bCurr;
      end else begin
        a := bCurr;
      end;
      bCurr^.next := aCurr;
      bCurr := bCurrNext; //schleife weitergehen
    end;
    c := a;
    a := nil;
    b := nil;
  end;



  var
    a, b, c, list: ListPtr;
    i: integer;

begin
  a := nil;
  b := nil;
  c := nil;

  WriteLn('a > '); ReadList(a);
  WriteLn('b > '); ReadList(b);


  WriteLn;WriteLn;WriteLn;
  Write('List a > '); WriteList(a);
  Write('List b > '); WriteList(b);
  Merge(a, b, c);
  Write('List c, merged > '); WriteList(c);


{
  list := nil;
  FillList(list);
  WriteList(list);
  WriteLn;
  //InvertSLL(list);
  MoveLastNodeToFront(list);

  WriteList(list);}
  DisposeList(c);
end.
