(* Swaps:                                                     DA, 2025-10-22 *)
(* ------                                                                    *)
(* Swap the value of two parameters.                                         *)
(* ========================================================================= *)
PROGRAM Swaps;

  PROCEDURE Swap(VAR value1, value2: INTEGER);   (* contains "Formalparameter" *)
    VAR
      h: INTEGER;
  BEGIN (* Swap *)
    test :=2;
    h := value1;
    value1 := value2;
    value2 := h
  END; (* Swap *)

  VAR
    v1, v2: INTEGER;

BEGIN (* Swaps *)
  v1 := 3;
  v2 := 7;
  Swap(v1, v2); (* "Aktualparameter" *)
  WriteLn('swap result: v1 = ', v1, ', v2 = ', v2);
  
  WriteLn;
END. (* Swaps *)
