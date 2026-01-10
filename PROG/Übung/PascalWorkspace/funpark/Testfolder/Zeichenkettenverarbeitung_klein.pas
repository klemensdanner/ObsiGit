program zeichenkettenverarbeitung;
  const
    max = 100;

  procedure ReadStringArray(VAR a: array of string; VAR n: integer);
    var
      i: integer;
  begin
    Write('Anzahl der einzulesenden Woerter > ');
    Readln(n);
    WriteLn('Gib die ', n, ' Woerter ein: ');
    for i := 0 to (n-1) do begin
      Write((i+1), '. > ');
      ReadLn(a[i]);
    end; (*for*)
  end;

  function WithoutLastChar(s: string): string;
  begin
	  WithoutLastChar := copy(s, 1, (length(s)-1));
  end;

  function EqualsIgnoreCase(a, b: string): boolean;
  begin
    if (Upcase(a) = Upcase(b)) then
      EqualsIgnoreCase := true
    else
      EqualsIgnoreCase := false;
  end;


  function camelCase(words: array of string; n: integer): string;
    var
      i, j: integer;
      s: string;

  begin
    i := 0;
    s := '';

    while (i < n) do begin

      if (length(s)+length(words[i])) > high(s) then begin
        camelCase := 'Error';
        Exit;
      end; (*if*)

      //wörter prüfen
      j := 1;
      while (j <= length(words[i])) do begin
        if NOT ((words[i][j] in ['a'..'z','A'..'Z','0'..'9'])) then begin
          camelCase := 'Error';
          Exit;
        end; (*if*)
        inc(j);
      end; (*while*)
    
    if (i = 0) then (*ersten Buchstaben klein schreiben*)
      words[i] := LowerCase(copy(words[i], 1, length(words[i])))
    else  
      words[i] := UpCase(copy(words[i], 1, 1)) + LowerCase(copy(words[i], 2, (length(words[i])-1)));

    s := s + words[i];
    inc(i);
    end; (*while*)
    camelCase := s;
  end;


  var
    a: array[1..max] of string;
    n: integer;

begin

  ReadStringArray(a, n);
  
  WriteLn;
  //WriteLn('1. Eingegebener Wert, Laenge: ', a[1], length(a[1]):2);
  writeln('1. Wert ohne letztem Char: ', WithoutLastChar(a[1]));
  WriteLn('1./2. Wert gleich (Gorss/Kleinschreibung egal): ', EqualsIgnoreCase(a[1], a[2]));
  WriteLn('gesamtes Array geCamelCased > ', camelCase(a, n));

end.