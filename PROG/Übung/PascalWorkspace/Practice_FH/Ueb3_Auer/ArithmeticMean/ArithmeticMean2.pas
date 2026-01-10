(* ArithmeticMean2:                                           DA, 2025-11-19 *)
(* ------                                                                    *)
(* Dynamic calculation of arithmetic mean. Using some memory is required.    *)
(* Solution using global variables.                                          *)
(* ========================================================================= *)
PROGRAM ArithmeticMean2;

  VAR
    (* memory variables as global variables *)
    n: INTEGER;  (* number of values for mean calculation *)
    sum: REAL;   (* sum of values for mean calcuation *)

  PROCEDURE Mean(value: REAL; VAR meanVal: REAL);
  BEGIN (* Mean *)
    (* a = f(s_n, e) *)                 
    meanVal := (sum + value) / (n + 1); 

    (* s_n+1 = g(s_n, e) *)
    n := n + 1;   
    sum := sum + value;    
  END; (* Mean *)

  PROCEDURE Mean2(value: REAL; VAR meanVal: REAL);
  BEGIN (* Mean2 *)  
    n := n + 1;   
    sum := sum + value;                  
    meanVal := (sum) / (n);
  END; (* Mean2 *)  

  VAR
    meanVal: REAL;

BEGIN (* ArithmeticMean2 *)

  (* initialize global memory variables *)
  n := 0;
  sum := 0.0;

  Mean(3.5, meanVal);
  WriteLn('mean = ', meanVal:5:2);

  Mean(2.5, meanVal);
  WriteLn('mean = ', meanVal:5:2);

  Mean(6, meanVal);
  WriteLn('mean = ', meanVal:5:2);

END. (* ArithmeticMean2 *)
