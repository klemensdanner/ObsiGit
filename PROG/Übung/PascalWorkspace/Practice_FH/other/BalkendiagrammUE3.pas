(* BarChart:                                                  DA, 2025-10-25 *)
(* ------                                                                    *)
(* Erzeugt Balkendiagramm mit Prozedur                                       *)
(* ========================================================================= *)


PROGRAM Balkendiagramm;


  //Funktion zur Berechnung vom Max
  FUNCTION Max2(a, b: INTEGER): INTEGER;
	var maximum: INTEGER;
	BEGIN
	IF a > b then
		maximum := a
	ELSE
		maximum := b;
  Max2 := maximum
	END;




  PROCEDURE BarChart(ch: CHAR; n1, n2, n3, n4, n5: INTEGER);
  //Block
  VAR
  nMax: INTEGER;
  row: string;
  addCharTo: CHAR;

  BEGIN
    //Prüfen ob Werte im Wertebreich liegen
    IF (n1 in [1..10]) and (n2 in [1..10]) and (n3 in [1..10]) and (n4 in [1..10]) and (n5 in [1..10]) then
      BEGIN
        //Maximum für Anzahl der Zeilen ermitteln
        nMax := Max2(Max2(Max2(Max2(n1,n2),n3),n4),n5)

        for j := nMax downto 1 do
          BEGIN

            //Zeile basteln, ausgeben
            
            
            
            
            
            row := row + //AddChar

            WriteLn(j); //Nummer und Zeile ausgeben
            Write('|', row);
          END;

      END
    ELSE
      WriteLn('Der Wertebereich ist 1 bis 10')
  END;







BEGIN
END.