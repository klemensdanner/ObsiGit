// TStackADS
// Test program for unit StackADS

program TStackADS;
  uses
    StackADT2;

  var
    i, e: integer;
    s1, s2: Stack;

begin
  NewStack(s1);
  for i := 1 to 10 do begin
    Push(s1, i);
  end;

  for i := 1 to 10 do begin
    Pop(s1, e);
    Write(e:4);
  end;
  WriteLn;


  NewStack(s2);
  DisposeStack(s1);
  DisposeStack(s2);
  //do anything ....
  // if the stack is needed later, it can be inisialized again


end.