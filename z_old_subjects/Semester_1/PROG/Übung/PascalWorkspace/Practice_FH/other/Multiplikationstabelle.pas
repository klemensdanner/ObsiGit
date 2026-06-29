(* Multiplikationstabelle                                     DA, 2025-10-18 *)
(* ------                                                                    *)
(* Gibt Multiplikationstabelle mit n Zeilen und m Spalten aus                *)
(* ========================================================================= *)

PROGRAM Multiplikationstabelle;
  VAR
    n, m, i, j: INTEGER;

BEGIN
  //Initialisierung
  n := 1;
  m := 1;

  while n <> 0 do BEGIN

    Write('Zeilen: ');
    ReadLn(n);

    IF n <> 0 THEN BEGIN //Bei Eingabe von n=0 direkt abbrechen
      Write('Spalten: ');
      ReadLn(m);

      IF (n > 0) AND (m > 0) THEN BEGIN // Negative Werte ausschließen, Programm weiterführen

        for i := 1 to n do BEGIN

          for j := 1 to m do BEGIN

            Write((i*j):5)

          END; (*innere Zählschleife*)

          WriteLn
        END; (*äußere Zählschleife*)

      END (*if-Abfrage, neg. Werte ausschließen*) ELSE
        Write('Bitte nur positive ganze Zahlen eingeben.'); //Fehlermeldung ausgeben
        WriteLn;
    
    END (*if-Abfrage, bei n=0 abbrechen*)
  END (*While*)
END.