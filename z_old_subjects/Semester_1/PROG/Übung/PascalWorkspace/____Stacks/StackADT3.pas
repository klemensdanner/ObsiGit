(* StackADT3:                                                 BK, 2026-01-21 *)
(* ------                                                                    *)
(* Stack implemented as an Abstract Data Type (ADT)                          *)
(* --> any number of "instances"                                             *)
(* stack is stored on the heap, size is set via NewStack                     *)
(* ========================================================================= *)
UNIT StackADT3;

INTERFACE
  type
    Stack = pointer;




  PROCEDURE NewStack(VAR s: Stack; maxElems: INTEGER);
  PROCEDURE DisposeStack(VAR s: Stack);

  PROCEDURE Push(s: Stack; e: INTEGER);
  PROCEDURE Pop(s: Stack; VAR e: INTEGER);

  FUNCTION Empty(s: Stack): BOOLEAN;
  FUNCTION Full(s: Stack): BOOLEAN;

IMPLEMENTATION

  TYPE
  StackPtr = ^StackRec;
  StackRec = RECORD
    maxElems: INTEGER;
    top: INTEGER;
    data: ARRAY[1..1] OF INTEGER;
  END; (* StackRec *)

  PROCEDURE NewStack(VAR s: Stack; maxElems: INTEGER);
  BEGIN (* NewStack *)
    GetMem(s, (SizeOf(INTEGER) + SizeOf(INTEGER) + maxElems * SizeOf(INTEGER)));
    StackPtr(s)^.top := 0;
    StackPtr(s)^.maxElems := maxElems;
  END; (* NewStack *)

  PROCEDURE DisposeStack(VAR s: Stack);
  BEGIN (* DisposeStack *)
    FreeMem(s, (SizeOf(INTEGER) + SizeOf(INTEGER) + StackPtr(s)^.maxElems * SizeOf(INTEGER)));
    s := NIL;
  END; (* DisposeStack *)

  PROCEDURE Push(s: Stack; e: INTEGER);
  BEGIN (* Push *)
    IF (Full(s)) THEN BEGIN
      WriteLn('Stack overflow');
    END ELSE BEGIN
      StackPtr(s)^.top := StackPtr(s)^.top + 1;
      (*$R-*)
      StackPtr(s)^.data[StackPtr(s)^.top] := e;
      (*$R+*)
    END; (* IF *)
  END; (* Push *)

  PROCEDURE Pop(s: Stack; VAR e: INTEGER);
  BEGIN (* Pop *)
    IF (Empty(s)) THEN BEGIN
      WriteLn('Stack underflow');
    END ELSE BEGIN
      (*$R-*)
      e := StackPtr(s)^.data[StackPtr(s)^.top];
      (*$R+*)
      StackPtr(s)^.top := StackPtr(s)^.top - 1;
    END; (* IF *)
  END; (* Pop *)

  FUNCTION Empty(s: Stack): BOOLEAN;
  BEGIN (* Empty *)
    Empty := (StackPtr(s)^.top = 0);
  END; (* Empty *)

  FUNCTION Full(s: Stack): BOOLEAN;
  BEGIN (* Full *)
    Full := (StackPtr(s)^.top = StackPtr(s)^.maxElems);
  END; (* Full *)

END. (* StackADT3 *)