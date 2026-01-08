  procedure AddAfter(var l: ListPtr; n: NodePtr; value: integer);
    var
      curr: NodePtr;
  begin
    n^.next := nil;
    if l = nil then begin
      l := n;
      Exit;
    end;
    curr := l;
    while (curr^.next <> nil) do begin
      if curr^.val = value then begin
        n^.next := curr^.next;
        curr^.next := n;
        Exit;
      end;
      curr := curr^.next;
    end;
    if curr^.next = nil then begin
      n^.next := nil;
      curr^.next := n;
    end;
  end;

  procedure AddAfter1(var l: ListPtr; n: NodePtr; value: integer);
    var
      curr: NodePtr;
  begin
    n^.next := nil;
    if l = nil then begin
      l := n;
      Exit;
    end;
    curr := l;
    while (curr^.next <> nil) and (curr^.val <> value) do begin
      curr := curr^.next;
    end;
    if curr^.next = nil then begin
      n^.next := nil;
      curr^.next := n;
    end else begin
      n^.next := curr^.next;
      curr^.next := n;
    end;
  end;