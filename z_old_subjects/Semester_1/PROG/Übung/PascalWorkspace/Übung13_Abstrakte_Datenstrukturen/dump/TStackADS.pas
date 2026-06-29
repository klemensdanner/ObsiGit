// TStackADS
// Test program for unit StackADS

program TStackADS;
  uses
    StackADS;

  var
    i, e: integer;

begin
  Init;
  for i := 1 to 10 do begin
    Push(i);
  end;

  for i := 1 to 10 do begin
    Pop(e);
    Write(e:4);
  end;
  WriteLn;


  //do anything ....
  // if the stack is needed later, it can be inisialized again

  Init;
  for i := 75 downto 55 do begin
    Push(i);
  end;

  for i := 1 to 
end.