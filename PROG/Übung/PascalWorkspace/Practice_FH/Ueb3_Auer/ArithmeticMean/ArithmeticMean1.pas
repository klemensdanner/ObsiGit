(* ArithmeticMean1:                                           DA, 2025-11-19 *)
(* ------                                                                    *)
(* Dynamic calculation of arithmetic mean. Using some memory is required.    *)
(* Solution using parameters.                                                *)
(* ========================================================================= *)
PROGRAM ArithmeticMean1;

  PROCEDURE Mean(VAR n: INTEGER; VAR sum: REAL;
                 value: REAL; VAR meanVal: REAL);
  BEGIN (* Mean *)
    (* a = f(s_n, e) *)                 
    meanVal := (sum + value) / (n + 1); 

    (* s_n+1 = g(s_n, e) *)
    n := n + 1;   
    sum := sum + value;    
  END; (* Mean *)

  PROCEDURE Mean2(VAR n: INTEGER; VAR sum: REAL;
                 value: REAL; VAR meanVal: REAL);
  BEGIN (* Mean2 *)  
    n := n + 1;   
    sum := sum + value;                  
    meanVal := (sum) / (n);
  END; (* Mean2 *)  

  VAR
    (* memory variables *)
    n: INTEGER;  (* number of values for mean calculation *)
    sum: REAL;   (* sum of values for mean calcuation *)

    (* additional test variables *)
    meanVal: REAL;

BEGIN (* ArithmeticMean1 *)

  (* initialize memory variables *)
  n := 0;
  sum := 0.0;

  Mean(n, sum, 3.5, meanVal);
  WriteLn('mean = ', meanVal:5:2);

  Mean(n, sum, 2.5, meanVal);
  WriteLn('mean = ', meanVal:5:2);

  Mean(n, sum, 6, meanVal);
  WriteLn('mean = ', meanVal:5:2);

END. (* ArithmeticMean1 *)
