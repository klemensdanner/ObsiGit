(* ArithmeticMeanUnit:                                        DA, 2025-11-19 *)
(* ------                                                                    *)
(* Implementation of a module for calculation of arithmetic mean using a     *)
(* module to implement the "memory variables".                               *)
(* ========================================================================= *)
UNIT ArithmeticMeanUnit;

INTERFACE
  PROCEDURE InitMean;
  PROCEDURE Mean(value: REAL; VAR meanVal: REAL);

IMPLEMENTATION

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

  PROCEDURE InitMean;
  BEGIN (* InitMean *)
    (* initialize global memory variables *)
    n := 0;
    sum := 0.0;    
  END; (* InitMean *)

BEGIN (* ArithmeticMeanUnit *)
  (* initialize global memory variables *)
  n := 0;
  sum := 0.0;
END. (* ArithmeticMeanUnit *)
