(* BarChart:                                                  DA, 2025-10-25 *)
(* ------                                                                    *)
(* Erzeugt Balkendiagramm mit Prozedur                                       *)
(* ========================================================================= *)


PROGRAM Balkendiagramm;

  VAR
    n1, n2, n3, n4, n5: INTEGER;
    ch1: string;


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
  nArr: array [1..5] of INTEGER; // Eingabewerte werden zur einfacheren Verarbeitung in ein array eingelesen
  i, j: INTEGER;
  inValueRange: BOOLEAN;
  BEGIN
    //Einlesen ins array
    nArr[1] := n1;
    nArr[2] := n2;
    nArr[3] := n3;
    nArr[4] := n4;
    nArr[5] := n5;

    //Wertebereich prüfen
    i := 1; //init
    inValueRange := true; //init
    while (i<=5) and inValueRange do
    BEGIN

      IF (nArr[i] <= 10) and (nArr[i]>=1) then
        BEGIN
          inValueRange := true;
          i := i + 1;
        END
      ELSE
        inValueRange := false;
    END;

    //BarChart ausgeben, wenn im Wertebereich
    IF inValueRange then
      BEGIN
        //Maximum für Anzahl der Zeilen ermitteln
        nMax := Max2(Max2(Max2(Max2(n1,n2),n3),n4),n5);
        

        for j := nMax downto 1 do
          BEGIN

            //Zeile basteln mit for Schleife
            //prüfen, ob j (Zeile) <= nArr[i]. Wenn ja, dann Leerzeichen+char zum string, wenn nein, '  '

            row := ''; //Zeile init bzw für die nächste Zeile zurücksetzen

            for i := 1 to 5 do
            BEGIN
            IF j <= nArr[i] then
              row := row + ' ' + ch
            ELSE
              row := row + '  ';

            END;

            //Ausgabe einer Zeile
            Write(j:2);
            Write('|', row);
            WriteLn;

          END;
        
        WriteLn('  +----------');
        WriteLn('    1 2 3 4 5');
      END
    ELSE
      WriteLn('Der Wertebereich ist 1 bis 10')
  END;

BEGIN
  WriteLn('Geben Sie einen char und 5 Zahlen zwischen 1 und 10 ein, um ein Balkendiagramm zu erstellen!');
  WriteLn;
  Read(ch1, n1, n2, n3, n4, n5);
  
  if length(ch1) = 1 then
  BEGIN
    WriteLn;
    BarChart(ch1[1], n1, n2, n3, n4, n5);
  END
  ELSE
    WriteLn('Bitte einen Char eingeben!');
END.