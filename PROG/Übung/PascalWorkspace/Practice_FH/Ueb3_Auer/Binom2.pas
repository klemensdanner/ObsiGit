(* Binom2:                                                    DA, 2025-10-22 *)
(* ------                                                                    *)
(* Program for calculating the binomial coefficient using a procedure for    *)
(* calculating the factorial.                                                *)
(* ========================================================================= *)
PROGRAM Binom2;

  PROCEDURE Factorial(n: INTEGER; VAR nf: INTEGER);
    VAR
      i: INTEGER;
  BEGIN (* Factorial *)
    nf := 1;
    FOR i := 2 TO n DO BEGIN
      nf := nf * i;
    END; (* FOR *)  
  END; (* Factorial *)

  VAR
    n, k: INTEGER;
    b: INTEGER;
    nFactorial, nkFactorial, kFactorial: INTEGER;
BEGIN (* Binom2 *)
  WriteLn('Calculate binomial coefficient for n choose k');
  Write('n > '); ReadLn(n);
  Write('k > '); ReadLn(k);

  Factorial(n, nFactorial);
  Factorial(n-k, nkFactorial);
  Factorial(k, kFactorial);

  b := nFactorial DIV (nkFactorial * kFactorial);
  WriteLn('binom. coefficient = ', b);

  WriteLn;
END. (* Binom2 *)
