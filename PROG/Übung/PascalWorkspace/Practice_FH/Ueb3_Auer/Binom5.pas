(* Binom5:                                                    DA, 2025-10-22 *)
(* ------                                                                    *)
(* Program for calculating the binomial coefficient using a function for     *)
(* the binomial coefficient which uses a function for calculating the        *)
(* factorial.                                                                *)
(* ========================================================================= *)
PROGRAM Binom5;

  {FUNCTION Factorial(n: INTEGER): INTEGER; FORWARD;}

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

  FUNCTION BinomialCoefficient(n,k: INTEGER): INTEGER;
  BEGIN (* BinomialCoefficient *)
    BinomialCoefficient := Factorial(n) DIV (Factorial(n-k) * Factorial(k));    
  END; (* BinomialCoefficient *)

  VAR
    n, k: INTEGER;
BEGIN (* Binom5 *)
  WriteLn('Calculate binomial coefficient for n choose k');
  Write('n > '); ReadLn(n);
  Write('k > '); ReadLn(k);
  WriteLn('binom. coefficient = ', BinomialCoefficient(n, k));

  WriteLn;
END. (* Binom5 *)