(* Title:                                                 Danner, 2025-10-15 *)
(* ------                                                                    *)
(* First test of Pascal language                                             *)
(* ========================================================================= *)

PROGRAM First;
  VAR
    value: INTEGER;
    temp: REAL;
    ch : CHAR;
    i: INTEGER;
    j: INTEGER;
BEGIN (* First *)
(*
    //Value ausgeben:
    value := 1;
    WriteLn('value = ', value);
    WriteLn;*)

(*
    //Temp einlesen und ausgeben
    Write('temperature > ');
    ReadLn(temp);
    WriteLn('temperature = ', temp:8:3); //Beispiel: 8 gibt die Gesamtlänge der Zahl. 3 ist die Anzahl der Kommastellen.
    // Bei mehr eingegebenen Kommastellen wird abgeschnitten, ohne Rundung, bei zu vielen Vorkommastellen wird die Zahl in der Ansicht verschoben.

    ch := '=';
    WriteLn('character = ', ch);
    *)


(*
    //IF statements & danging else problem // anschauen!!
    IF (value > 0) THEN BEGIN
      IF (value > 10) THEN
        WriteLn('größer 10')
      END
    ELSE BEGIN
        WriteLn('not größer 10'); //danging else problem: wo gehört das Else dazu? zum nächstgelegenem IF
    END *)
    

  i := 1;


  //While Schleife
  WHILE (i<10) DO BEGIN
    Write(i:3, ' ');
    i := i + 1; (*INC(i)*)
  END; (* WHILE *)

  WriteLn;

  //Repeat until Schleife
  REPEAT //lt. Grammatik wird kein Compound statement benötigt.
    i := i - 1; // (oder DEC(i))
    Write(i:3, ' ');
  UNTIL i=1;

  WriteLn;

  //For Schleife
  FOR i := 9 DOWNTO 1 DO BEGIN
    Write(i:3, ' ');
  END;


WriteLn;

//Matrix ausgeben anschauen
FOR i := 1 TO 4 DO BEGIN
  FOR j := 1 to 3 do begin
  write(i*j:3);
  WriteLn;
  END
end;




END. (* First *)