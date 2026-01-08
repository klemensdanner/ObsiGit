(* Binom4:                                                    DA, 2025-10-22 *)
(* ------                                                                    *)
(* Program for calculating the binomial coefficient using a function for     *)
(* calculating the factorial.                                                *)
(* ========================================================================= *)
PROGRAM Binom4;

  FUNCTION Factorial(n: INTEGER): INTEGER;
    VAR
      i: INTEGER;
      nf: INTEGER;
  BEGIN (* Factorial *)
    nf := 1;
    FOR i := 2 TO n DO BEGIN
      nf := nf * i;
    END; (* FOR *)  
    Factorial := nf;
  END; (* Factorial *)

  VAR
    n, k: INTEGER;
    b: INTEGER;
BEGIN (* Binom4 *)
  WriteLn('Calculate binomial coefficient for n choose k');
  Write('n > '); ReadLn(n);
  Write('k > '); ReadLn(k);

  b := Factorial(n) DIV (Factorial(n-k) * Factorial(k));
  WriteLn('binom. coefficient = ', b);

  WriteLn;
END. (* Binom4 *)