(* Second:                                                DA, 2025-10-15 *)
(* ------                                                                    *)
(* Some tests with division and modulo                                                               *)
(* ========================================================================= *)



PROGRAM Second;
  VAR
    i: INTEGER;
    r : REAL;
    b: BOOLEAN;




BEGIN (* Second *)
  // whole number division for integer values
  // integer DIV integer --> integer
  //nicht gerundet, einfach abgeschnitten

  i := 10 div 3;
  WriteLn('i = ', i);

Writeln;
  // integer / integer --> real, variable muss vom typ real sein, sonst type mismatch

  r:=10/3;
  Writeln('r = ', r:5:2);


  // real / real --> real

  r:= 10.0 / 2.0;
  WriteLn('r = ', r:5:2);



  //boolean

  b:= FALSE;
  WriteLn('b= ', b);
  b := i<10; //Wahrheitswert so festlegen, nicht durch if Bedingung
  WriteLn(b);


  if b then begin
    Writeln('i ist kleiner als 10')
    end else begin
      WriteLn('i ist nicht kleiner als 10')
    end;



END. (* Second *)