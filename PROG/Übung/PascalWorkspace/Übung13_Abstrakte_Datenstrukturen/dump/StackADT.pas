// StackADS
// Stack implemented as an abstract data type
// --> any number of instance

unit StackADT;

interface
  const
    maxElements = 100;
  type
    Stack = record
      top: integer;
      data: array[1..maxElements] of integer;
    end;


  procedure Init(var s: Stack);
  procedure Push(var s: Stack; e: integer);
  procedure Pop(var s: Stack; var e: integer);
  
  function Empty(var s: Stack): boolean; // call by ref - for efficiency
  function Full(var s: Stack): boolean;


implementation

  procedure Init(var s: Stack);
  begin
    s.top := 0;
  end;

  function Empty(var s: Stack): boolean;
  begin
    Empty := (s.top = 0);
  end;

  function Full(var s: Stack): boolean;
  begin
    Full := (s.top = maxElements);
  end;

  procedure Push(var s: Stack; e: integer);
  begin
    if Full(s) then begin
      WriteLn('Stack overflow');
    end else begin
      inc(s.top);
      s.data[s.top] := e;
    end;
  end;

  procedure Pop(var s: Stack; var e: integer);
  begin
    if Empty(s) then begin
      WriteLn('Stack underflow');
    end else begin
      e := s.data[s.top];
      dec(s.top);
    end;
  end;


end.