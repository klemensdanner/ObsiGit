(* Binom1:                                                    DA, 2025-10-22 *)
(* ------                                                                    *)
(* calc the binomial coefficient                                             *)
(* ========================================================================= *)

PROGRAM Binom1;
  VAR
    n, k: INTEGER;
    b: INTEGER;
    nFactorial, nkFactorial, kFactorial: INTEGER;
    i: INTEGER;
BEGIN (* Binom1 *)
  WriteLn('Calculate binomial coefficient for n choose k');

  Write('n > '); ReadLn(n);
  Write('k > '); ReadLn(k);


  nFactorial := 1;
  for i:= 2 to n do BEGIN
    nFactorial := nFactorial * i;
  END;


  nkFactorial := 1;
  for i:= 2 to (n-k) do BEGIN
    nkFactorial := nkFactorial * i;
  END;


  kFactorial := 1;
  for i:= 2 to k do BEGIN
    kFactorial := kFactorial * i;
  END;


b:= nFactorial DIV (nkFactorial*kFactorial);
WriteLn(b);


END. (* Binom1 *)