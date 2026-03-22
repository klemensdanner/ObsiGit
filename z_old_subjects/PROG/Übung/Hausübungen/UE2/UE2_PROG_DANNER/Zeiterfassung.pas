(* Zeiterfassung:                                             DA, 2025-10-17 *)
(* ------                                                                    *)
(* Gibt den Anspruch auf Zeitausgleich aus                                   *)
(* ========================================================================= *)

PROGRAM Zeiterfassung;
  VAR
    min: INTEGER;
    hour: INTEGER;
    workTime: REAL;
    overWorkTime: REAL; //Gesamtzeit - Normalzeit (8h)
    compTimeOff: REAL; //Zeitausgleich

BEGIN (* Zeiterfassung *)

  //Einlesen der Arbeitszeit
  WriteLn('Eingabe: ');
  ReadLn(hour, min);

  //Berechnung der Gesamtzeit und Überstunden
  workTime := hour + (min/60);
  overWorkTime := workTime - 8;

  //Abfragen
  IF (hour < 0) AND (min < 0) THEN BEGIN //Negative Eingaben ausschließen
    WriteLn('Eingabe ungueltig');
  END ELSE
    IF (workTime > 12) THEN BEGIN
      WriteLn('Taegliche Hoechstarbeitszeit ueberschritten');
    END ELSE
      IF (overWorkTime <= 0) THEN BEGIN //weniger oder genau 8 Stunden gearbeitet
        compTimeOff := 0;
        WriteLn('Anspruch auf Zeitausgleich: ', compTimeOff:2:2, ' Stunden');
      END ELSE
        IF (overWorkTime > 0) AND (overWorkTime <=2) THEN BEGIN //zw. 0 und 2 Überstunden
          compTimeOff := overWorkTime;
          WriteLn('Anspruch auf Zeitausgleich: ', compTimeOff:2:2, ' Stunden');
        END ELSE
          IF (overWorkTime >= 2) THEN BEGIN //mehr als 2 Überstunden --> ab 11. Stunde *1.5
            compTimeOff := ((overWorkTime - 2)*1.5)+2;
            WriteLn('Anspruch auf Zeitausgleich: ', compTimeOff:2:2, ' Stunden');
          END; (* IF *)

END. (* Zeiterfassung *)