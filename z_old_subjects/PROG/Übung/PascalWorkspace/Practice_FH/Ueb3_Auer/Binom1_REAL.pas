(* Binom1_REAL:                                               DA, 2025-10-22 *)
(* ------                                                                    *)
(* Program for calculating the binomial coefficient.                         *)
(* ========================================================================= *)
PROGRAM Binom1_REAL;
  VAR
    n, k: INTEGER;
    b: REAL;
    i: INTEGER;
    nFactorial, nkFactorial, kFactorial: REAL;
BEGIN (* Binom1_REAL *)
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

  b := nFactorial / (nkFactorial * kFactorial);
  WriteLn('binom. coefficient = ', b:10:0);

  WriteLn;
END. (* Binom1_REAL *)
