(* Binom1:                                                    DA, 2025-10-22 *)
(* ------                                                                    *)
(* calc the binomial coefficient using function                              *)
(* ========================================================================= *)

PROGRAM Binom2;

  FUNCTION Factorial(n: INTEGER): INTEGER;
    VAR
      i : INTEGER; //brauchen wir nur in der Funktion
      nf : INTEGER;
  BEGIN (* Factorial *)
    nf := 1;
    FOR i := 2 to n do BEGIN
      nf := nf*i;
    END;
    Factorial := nf; //diese Factorialvariable wird wegen Programmierstil nur zum Zuweisen des Ergebnisses verwendet.
  END; (* Factorial *)


  VAR
    n, k: INTEGER;
    b: INTEGER;
    nFactorial, nkFactorial, kFactorial: INTEGER;
BEGIN (* Binom1 *)
  WriteLn('Calculate binomial coefficient for n choose k');
  Write('n > '); ReadLn(n);
  Write('k > '); ReadLn(k);

b:= Factorial(n) DIV (Factorial(n-k)*Factorial(k));
WriteLn(b);


END. (* Binom1 *)