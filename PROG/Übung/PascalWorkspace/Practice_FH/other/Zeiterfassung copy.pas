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


{   WriteLn('hours: ', hour);
  WriteLn('minutes: ', min); }


  //Berechnung der Gesamtzeit und Überstunden
  workTime := hour + (min/60);
  { WriteLn(workTime:3:3); }

  overWorkTime := workTime - 8;


  //Abfragen
  IF (workTime < 0) THEN BEGIN
    WriteLn('Eingabe ungueltig');
  END ELSE
    IF (workTime > 12) THEN BEGIN
      WriteLn('Taegliche Hoechstarbeitszeit ueberschritten');
    END ELSE
      IF (overWorkTime <= 0) THEN BEGIN //weniger oder genau 8 Stunden gearbeitet
        compTimeOff := 0;
        WriteLn('Anspruch auf Zeitausgleich: ', compTimeOff:2:2, ' Stunden');
      END ELSE
        IF (overWorkTime > 0) AND (overWorkTime <=2) THEN BEGIN
          compTimeOff := overWorkTime;
          WriteLn('Anspruch auf Zeitausgleich: ', compTimeOff:2:2, ' Stunden');
        END ELSE
          IF (overWorkTime >= 2) THEN BEGIN
            compTimeOff := ((overWorkTime - 2)*1.5)+2;
            WriteLn('Anspruch auf Zeitausgleich: ', compTimeOff:2:2,, ' Stunden')
          END; (* IF *)




{   //Abfragen
  IF (workTime < 0) THEN BEGIN
    WriteLn('Eingabe ungueltig');
  END ELSE BEGIN
    IF (workTime > 12) THEN BEGIN
      WriteLn('Taegliche Hoechstarbeitszeit ueberschritten');
    END ELSE BEGIN
      IF (overWorkTime <= 0) THEN BEGIN //weniger oder genau 8 Stunden gearbeitet
        compTimeOff := 0;
        WriteLn('Anspruch auf Zeitausgleich: ', compTimeOff:2);
      END ELSE BEGIN
        IF (overWorkTime > 0) AND (overWorkTime <=2) THEN BEGIN
          compTimeOff := overWorkTime;
          WriteLn('Anspruch auf Zeitausgleich: ', compTimeOff:2);
        END ELSE BEGIN
          IF (overWorkTime >= 2) THEN BEGIN
            compTimeOff := ((overWorkTime - 2)*1.5)+2;
            WriteLn('Anspruch auf Zeitausgleich: ', compTimeOff:2)
          END; (* IF *)
        END;
      END; (* IF *)
    END; (* IF *)
  END; (* IF *) }  
END. (* Zeiterfassung *)