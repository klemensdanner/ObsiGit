(* Binom3:                                                    DA, 2025-10-22 *)
(* ------                                                                    *)
(* Program for calculating the binomial coefficient using a function for     *)
(* calculating the factorial.                                                *)
(* ========================================================================= *)
PROGRAM Binom3;

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
    nFactorial, nkFactorial, kFactorial: INTEGER;
BEGIN (* Binom3 *)
  WriteLn('Calculate binomial coefficient for n choose k');
  Write('n > '); ReadLn(n);
  Write('k > '); ReadLn(k);

  nFactorial := Factorial(n);
  nkFactorial := Factorial(n-k);
  kFactorial := Factorial(k);

  b := nFactorial DIV (nkFactorial * kFactorial);
  WriteLn('binom. coefficient = ', b);

  WriteLn;
END. (* Binom3 *)