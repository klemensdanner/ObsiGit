(* Swaps:                                                     DA, 2025-11-26 *)
(* ------                                                                    *)
(* First test with pointer variable.                                         *)
(* "Simulate" call by reference using pointer parameters.                    *)
(* ========================================================================= *)
PROGRAM Swaps;
  TYPE
    IntegerPointer = ^INTEGER;  (* ^ ... pointer to *)

  PROCEDURE Swap(VAR x, y: INTEGER);
    VAR
      h: INTEGER;
  BEGIN (* Swap *)
    h := x; 
    x := y;
    y := h;
  END; (* Swap *)

  PROCEDURE Swap2(x, y: IntegerPointer);
    VAR
      h: INTEGER;
  BEGIN (* Swap2 *)
    h := x^; 
    x^ := y^;
    y^ := h;
  END; (* Swap2 *)  

  VAR
    iPtr: IntegerPointer;
    a, b: INTEGER;

BEGIN (* Swaps *)
  (* first test with pointer variable *)
  New(iPtr);
  iPtr^ := 14;  (* ^ dereference operator *)
  WriteLn('int value referenced by iPtr = ', iPtr^);
  WriteLn('value of iPtr = ', LONGINT(iPtr));
  Dispose(iPtr);
  iPtr := NIL;
  WriteLn('value of iPtr = ', LONGINT(iPtr));  

  (* Swap test *)
  a := 2;
  b := 7;
  Swap(a, b);
  WriteLn('a = ', a, ', b = ', b);
  Swap2(@a, @b);    (* @ ... address operator *)
  WriteLn('a = ', a, ', b = ', b);  

END. (* Swaps *)
