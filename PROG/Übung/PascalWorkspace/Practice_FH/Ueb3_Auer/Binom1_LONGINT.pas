(* Binom1_LONGINT:                                            DA, 2025-10-22 *)
(* ------                                                                    *)
(* Program for calculating the binomial coefficient.                         *)
(* ========================================================================= *)
PROGRAM Binom1_LONGINT;
  VAR
    n, k: INTEGER;
    b: LONGINT;
    i: INTEGER;
    nFactorial, nkFactorial, kFactorial: LONGINT;
BEGIN (* Binom1_LONGINT *)
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
END. (* Binom1_LONGINT *)
