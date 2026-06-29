(* TStackADT3:                                                BK, 2026-01-21 *)
(* ------                                                                    *)
(* Test program for unit StackADT3.                                          *)
(* ========================================================================= *)
PROGRAM TStackADT3;

  USES
    StackADT4;
  
  VAR
    i: INTEGER;
    e: INTEGER;
    s1, s2: Stack;
    ap: ^Stack;
  
BEGIN (* TStackADT3 *)

  NewStack(s1, 10);
  FOR i := 1 TO 10 DO BEGIN
    Push(s1, i);
  END; (* FOR *)

  {WriteLn('s1^.top = ', s1^.top);
  (*$R-*)
  WriteLn('s1^.data[s1^.top] = ', s1^.data[s1^.top]);
  (*$R+*)
  { s1^.top := 5; }

  New(ap);
  Push(ap, 5);


  NewStack(s2, 30);
  FOR i := 55 TO 75 DO BEGIN
    Push(s2, i);
  END; (* FOR *)

  FOR i := 55 TO 75 DO BEGIN
    Pop(s2, e);
    Write(e:4);
  END; (* FOR *)
  WriteLn;
  DisposeStack(s2);

  FOR i := 1 TO 10 DO BEGIN
    Pop(s1, e);
    Write(e:4);
  END; (* FOR *)
  WriteLn;
  DisposeStack(s1);
  
END. (* TStackADT3 *)