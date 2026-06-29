(* Binom1:                                                    DA, 2025-10-22 *)
(* ------                                                                    *)
(* calc the binomial coefficient with a func. using a function for the factorial*)
(* ========================================================================= *)

PROGRAM Binom5;

  {FUNCTION Factorial(n: INTEGER): INTEGER: FORWARD;
  Es können immer nur Funktionen verwendet, die bereits bekannt sind.
  Im Fall, dass ich eine Funktion brauche, die erst nachher deklariert wird,
  kann man das mit dem Forward lösen}


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

  FUNCTION BinomialCoefficient(n,k: INTEGER): INTEGER;
  BEGIN (* BinomialCoefficient *)
    BinomialCoefficient := Factorial(n) DIV (Factorial(n-k)*Factorial(k));
  END; (* BinomialCoefficient *)


  VAR
    n, k: INTEGER;

BEGIN (* Binom1 *)
  WriteLn('Calculate binomial coefficient for n choose k');
  Write('n > '); ReadLn(n);
  Write('k > '); ReadLn(k);

WriteLn(BinomialCoefficient(n,k));


END. (* Binom1 *)