```pascal
  // Funktioniert, weil standardmäßig Kurzschlussauswertung
  i := 13;

  if (i >= lb) and (i <= ub) and (a[i] = 10) then //Kurzschlussauswertung
    begin
      WriteLn('fine');
    end
  else
    WriteLn('sorry bro');
```


```pascal
  //runtime error, weil manuell auf vollständige Auswertung umgestellt wird
  
  
  {$B+} //vollständige Auswertung
  i := 13;
  if (i >= lb) and (i <= ub) and (a[i] = 10) then //Kurzschlussauswertung
    begin
      WriteLn('fine');
    end
  else
    WriteLn('sorry bro');
  {$B-} //Kurzschlussauswertung
```


## Signifikante Stellen
```pascal
  //funktioniert --> r is kleiner
  
  r := 1.000001;
  r2 := 1.000002;

  if (r<r2) then
    writeln('r is kleiner')
  else
    writeln('r is ned kleiner');
```

```pascal
  //Es kommt: sind nicht kleiner, weil die Zahlen intern gleich gespeichert werden. die Zahlen sind so lang, dass sie nicht in die Mantisse reinpassen.
  
  r :=  1.00000000000000000000000000000000000000001;
  r2 := 1.00000000000000000000000000000000000000002;

  if (r<r2) then
    writeln('r is kleiner')
  else
    writeln('r is ned kleiner');
```


## Standardfunktionen

```pascal
  WriteLn('Sin(r) = ', sin(r)); // trigonometrische standardfunktionen verwenden das Bogenmaß!
```

```pascal
odd() liefert true wenn gerade
```

```pascal
Insert() gibts für strings
```
``

``` pascal
  WriteLn('Pos: ', Pos('23',s)); //liefert Startindex im String, wo der gesuchte string vorkommt, ansonsten 0
```

Zahl in string speichern
```pascal
  Str(123.4556:10:2, s);
```


```pascal
  Val('123', i, code); //wandelt string um in int und gibt bei Fehler einen Fehlercode aus

  WriteLn('i = ', i, ' code = ',code)
```

```pascal
delete() kann Zeichen im string löschen

Upcase(s) schreibt den string groß
```

```pascal
random(range)
```