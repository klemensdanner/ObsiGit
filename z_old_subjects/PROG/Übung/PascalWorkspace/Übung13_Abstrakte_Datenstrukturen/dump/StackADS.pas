// StackADS
// Stack implemented as an abstract data structure
// --> only one instance

unit StackADS;

interface

  procedure Init;
  procedure Push(e: integer);
  procedure Pop(var e: integer);
  
  function Empty: boolean;
  function Full: boolean;


implementation
  const
    maxElements = 100;
  
  var
    top: integer;
    data: array[1..maxElements] of integer;

  procedure Init;
  begin
    top := 0;
  end;

  function Empty: boolean;
  begin
    Empty := (top = 0);
  end;

  function Full: boolean;
  begin
    Full := (top = maxElements);
  end;

  procedure Push(e: integer);
  begin
    if Full then begin
      WriteLn('Stack overflow');
    end else begin
      inc(top);
      data[top] := e;
    end;
  end;

  procedure Pop(var e: integer);
  begin
    if Empty then begin
      WriteLn('Stack underflow');
    end else begin
      e := data[top];
      dec(top);
    end;
  end;

begin
  Init;
end.