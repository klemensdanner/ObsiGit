(* Title:                                                 Author, 2025-10-15 *)
(* ------                                                                    *)
(* Description                                                               *)
(* ========================================================================= *)



(* HelloWorld:                                                               *)
(* -----------                                                               *)
(* This is a simple hello world program to test the VS Code workspace.       *)
(* ========================================================================= *)
PROGRAM MeanPgm;

//Deklarationsteil
  VAR
    total, numbers, value: INTEGER;
    mean: REAL;

BEGIN
  WriteLn('MeanPgm : Calculation of Mean');
  total := 0;
  numbers := 0;

  Write('value > ');
  ReadLn(value);

  WHILE value > 0 DO
  BEGIN
    total := total + value;
    numbers := numbers + 1;

    Write('value > ');
    ReadLn(value);
  END; (* WHILE *)

  IF numbers > 0 THEN
  BEGIN
    mean := total / numbers;
    WriteLn('mean = ', mean:5:2);  (* 5 chars, 2 decimals *)
    
  END
  ELSE
    WriteLn('Zero numbers, no mean.');

END.