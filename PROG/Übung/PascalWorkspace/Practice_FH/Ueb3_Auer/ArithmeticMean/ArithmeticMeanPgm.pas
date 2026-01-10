(* ArithmeticMeanPgm:                                         DA, 2025-11-19 *)
(* ------                                                                    *)
(* Test program for Unit ArithmeticMeanUnit.                                 *)
(* ========================================================================= *)
PROGRAM ArithmeticMeanPgm;

  USES
    ArithmeticMeanUnit;
  
  VAR
    meanVal: REAL;

BEGIN (* ArithmeticMeanPgm *)

  InitMean;
  Mean(3.5, meanVal);
  WriteLn('mean = ', meanVal:5:2);

  Mean(2.5, meanVal);
  WriteLn('mean = ', meanVal:5:2);

  Mean(6, meanVal);
  WriteLn('mean = ', meanVal:5:2); 

  InitMean;
  Mean(10, meanVal);
  WriteLn('mean = ', meanVal:5:2);   

  Mean(20, meanVal);
  WriteLn('mean = ', meanVal:5:2);

  Mean(30, meanVal);
  WriteLn('mean = ', meanVal:5:2);

  WriteLn;
END. (* ArithmeticMeanPgm *)
