```pascal
    //IF statements & danging else problem

    IF (value > 0) THEN

      IF (value > 10) THEN

        WriteLn('größer 10')

      ELSE

        WriteLn('not größer 10'); //danging else problem: wo gehört das Else dazu? zum nächstgelegenem IF
```
geht nicht, weil kein compound statement


