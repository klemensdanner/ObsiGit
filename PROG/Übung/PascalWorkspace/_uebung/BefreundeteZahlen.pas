(* Befreundete Zahlen                                         DA, 2025-10-25 *)
(* ------                                                                    *)
(* Bestimmt, ob zwei Zahlen befreudnet sind                                  *)
(* ========================================================================= *)

PROGRAM BefreundeteZahlen1;
VAR a,b: INTEGER;

FUNCTION TeilerSumme(a: INTEGER): INTEGER;
  var Summe, i: INTEGER;
  
  BEGIN
    Summe := 0; //init
    for i := (a - 1) downto 1 do
    BEGIN
      IF (a mod i = 0) then
      Summe := Summe + i;    
    END;

    Teilersumme := Summe;
  END;

FUNCTION BefreundeteZahlen(a,b: INTEGER): BOOLEAN;
  
  BEGIN
    IF (a<1) or (b<1) then //negative Zahlen machen keinen Sinn, und auch 0 sind keine befreundeten Zahlen
    BefreundeteZahlen := false
    ELSE
    BefreundeteZahlen := (a = TeilerSumme(b)) and (b = TeilerSumme(a));
  END;



BEGIN
  Write('Zwei Zahlen eingeben: '); Read(a,b);

  IF BefreundeteZahlen(a,b) then
    WriteLn('Diese Zahlen sind befreundet.')
  ELSE
    WriteLn('Diese Zahlen sind nicht befreundet.');
END.