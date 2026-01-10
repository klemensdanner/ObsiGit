program swaps;

  type
    IntegerPointer = ^INTEGER;
  
  var
   iPtr: IntegerPointer;


  procedure Swap(var x, y: integer);
    var
      h: integer;
    begin
      h := x;
      x := y;
      y := h;
    end;



  //using pointers
  procedure Swap2(x, y: IntegerPointer);
    var
      h: integer;
    begin
      h := x^;
      x^ := y^;
      y^ := h;
    end;

  var
    a, b: integer;


begin
  new(iPtr);

  iPtr^ := 14;

  WriteLn('int value referenced by iPtr = ', iPtr^);
  WriteLn('value of iPtr (adress) = ', LongInt(iPtr));
  Dispose(iPtr);
  iPtr := nil;

  WriteLn('value of iPtr (adress) = ', LongInt(iPtr));
  //WriteLn('int value referenced by iPtr = ', iPtr^); //nil dereferenzieren gibt Laufzeitfehler
  
  a:=5;
  b:=7;

  Swap2(@a,@b);
  WriteLn(a, b);

end.