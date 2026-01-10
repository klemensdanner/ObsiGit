(* Einnahmen- / Ausgabenrechnung:                         Author, 2025-10-18 *)
(* ------                                                                    *)
(* Lest Buchungen ein und gibt Einnahmen und Ausgaben aus                    *)
(* ========================================================================= *)

PROGRAM EinnahmenAusgaben;

  VAR
  value, totalpos, totalneg: INTEGER;

BEGIN (*EinnahmenAusgaben*)
  value := 1;
  totalneg := 0;
  totalpos := 0;

  while value <> 0 do // Solange value ungleich 0 wird eingelesen
  BEGIN
    ReadLn(value);

    //Zuweisungen je nach Vorzeichen
    if value > 0 THEN
      totalpos := totalpos + value
    else
      totalneg := totalneg + value
  END;

//Ausgabe
WriteLn('Einnahmen: ', totalpos);
WriteLn('Ausgaben: ', totalneg);
WriteLn('Gesamt: ', (totalpos + totalneg));

END. (*EinnahmenAusgaben*)