// StackADT3
// Stack implemented as an abstract data type, dynamic
// --> any number of instance, size is set via newstack

unit StackADT2;

interface
  const
    maxElements = 100;
  type
    Stack = ^StackRec;
    StackRec = record
      top: integer;
      data: array[1..1] of integer;
      maxElements: integer;
    end;


  procedure NewStack(var s: Stack);
  procedure DisposeStack(var s: Stack);
  procedure Push(s: Stack; e: integer);
  procedure Pop(s: Stack; var e: integer);
  
  function Empty(s: Stack): boolean; // call by ref - for efficiency
  function Full(s: Stack): boolean;


implementation

  procedure NewStack(var s: Stack);
  begin
    New(s);
    s^.top := 0;
  end;

  procedure DisposeStack(var s: Stack);
  begin
    Dispose(s);
    s := nil;
  end;


  function Empty(s: Stack): boolean;
  begin
    Empty := (s^.top = 0);
  end;

  function Full(s: Stack): boolean;
  begin
    Full := (s^.top = maxElements);
  end;

  procedure Push(s: Stack; e: integer);
  begin
    if Full(s) then begin
      WriteLn('Stack overflow');
    end else begin
      inc(s^.top);
      s^.data[s^.top] := e;
    end;
  end;

  procedure Pop(s: Stack; var e: integer);
  begin
    if Empty(s) then begin
      WriteLn('Stack underflow');
    end else begin
      (*$R+*)
      e := s^.data[s^.top];
      (*$R+*)
      dec(s^.top);
    end;
  end;


end.