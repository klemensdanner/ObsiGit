(* Binom1:                                                    DA, 2025-10-22 *)
(* ------                                                                    *)
(* calc the binomial coefficient                                             *)
(* ========================================================================= *)

PROGRAM Binom2;
  PROCEDURE Factorial(n: INTEGER; VAR nf: INTEGER);
    VAR
      i : INTEGER; //brauchen wir nur in der Prozedur
  BEGIN (* Factorial *)
    nf := 1;
    FOR i := 2 to n do BEGIN
      nf := nf*i;
    END;
  END; (* Factorial *)


  VAR
    n, k: INTEGER;
    b: INTEGER;
    nFactorial, nkFactorial, kFactorial: INTEGER;
BEGIN (* Binom1 *)
  WriteLn('Calculate binomial coefficient for n choose k');

  Write('n > '); ReadLn(n);
  Write('k > '); ReadLn(k);


  Factorial(n, nFactorial);
  Factorial((n-k), nkFactorial); //Factorial(arithmetischerAusdruck, Variable(dessen Adresse an die Prozedur übergeben wird))
  Factorial(k, kFactorial);


b:= nFactorial DIV (nkFactorial*kFactorial);
WriteLn(b);


END. (* Binom1 *)