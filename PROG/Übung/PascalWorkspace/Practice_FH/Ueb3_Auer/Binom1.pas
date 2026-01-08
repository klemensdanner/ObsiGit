(* Binom1:                                                    DA, 2025-10-22 *)
(* ------                                                                    *)
(* Program for calculating the binomial coefficient.                         *)
(* ========================================================================= *)
PROGRAM Binom1;
  VAR
    n, k: INTEGER;
    b: INTEGER;
    i: INTEGER;
    nFactorial, nkFactorial, kFactorial: INTEGER;
BEGIN (* Binom1 *)
  WriteLn('Calculate binomial coefficient for n choose k');
  Write('n > '); ReadLn(n);
  Write('k > '); ReadLn(k);

  nFactorial := 1;
  FOR i := 2 TO n DO BEGIN
    nFactorial := nFactorial * i;
  END; (* FOR *)

  nkFactorial := 1;
  FOR i := 2 TO (n-k) DO BEGIN
    nkFactorial := nkFactorial * i;
  END; (* FOR *)

  kFactorial := 1;
  FOR i := 2 TO k DO BEGIN
    kFactorial := kFactorial * i;
  END; (* FOR *)  

  b := nFactorial DIV (nkFactorial * kFactorial);
  WriteLn('binom. coefficient = ', b);

  WriteLn;
END. (* Binom1 *)
