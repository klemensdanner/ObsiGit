PROGRAM zeichenkettenverarbeitung;
  CONST
    max = 100;

  PROCEDURE ReadStringArray(VAR a: ARRAY OF STRING; VAR n: INTEGER);
    VAR
      i: INTEGER;
  BEGIN
    Write('Anzahl der einzulesenden Woerter > ');
    Readln(n);
    WriteLn('Gib die ', n, ' Woerter ein: ');
    FOR i := 0 TO (n-1) DO BEGIN
      Write((i+1), '. > ');
      ReadLn(a[i]);
    END; (*FOR*)
  END;

  FUNCTION WithoutLastChar(s: STRING): STRING;
  BEGIN
	  WithoutLastChar := copy(s, 1, (length(s)-1));
  END;

  FUNCTION EqualsIgnoreCase(a, b: STRING): BOOLEAN;
  BEGIN
    IF (Upcase(a) = Upcase(b)) THEN
      EqualsIgnoreCase := TRUE
    ELSE
      EqualsIgnoreCase := FALSE;
  END;


  FUNCTION camelCase(words: ARRAY OF STRING; n: INTEGER): STRING;
    VAR
      i, j: INTEGER;
      s: STRING;

  BEGIN
    i := 0;
    s := '';

    WHILE (i < n) DO BEGIN

      IF (length(s)+length(words[i])) > high(s) THEN BEGIN
        camelCase := 'Error';
        Exit;
      END; (*IF*)

      //wörter prüfen
      j := 1;
      WHILE (j <= length(words[i])) DO BEGIN
        IF NOT ((words[i][j] IN ['a'..'z','A'..'Z','0'..'9'])) THEN BEGIN
          camelCase := 'Error';
          Exit;
        END; (*IF*)
        inc(j);
      END; (*WHILE*)
    
    IF (i = 0) THEN (*ersten Buchstaben klein schreiben*)
      words[i] := LowerCase(copy(words[i], 1, length(words[i])))
    ELSE  
      words[i] := UpCase(copy(words[i], 1, 1)) + LowerCase(copy(words[i], 2, (length(words[i])-1)));

    s := s + words[i];
    inc(i);
    END; (*WHILE*)
    camelCase := s;
  END;


  VAR
    a: ARRAY[1..max] OF STRING;
    n: INTEGER;

BEGIN

  ReadStringArray(a, n);
  
  WriteLn;
  //WriteLn('1. Eingegebener Wert, Laenge: ', a[1], length(a[1]):2);
  writeln('1. Wert ohne letztem CHAR: ', WithoutLastChar(a[1]));
  WriteLn('1./2. Wert gleich (Gorss/Kleinschreibung egal): ', EqualsIgnoreCase(a[1], a[2]));
  WriteLn('gesamtes ARRAY geCamelCased > ', camelCase(a, n));

END.
