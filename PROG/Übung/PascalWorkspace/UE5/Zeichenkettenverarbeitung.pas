program zeichenkettenverarbeitung;


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
      validInput: boolean;
  begin
    i := 0;
    validInput := true;
    while validInput AND (i < n) do begin
      //wörter prüfen und Groß/Kleinschreibung anpassen: Index j ist Länge eines Wortes
      j := 1;
      while validInput AND (j <= length(words[i])) do begin
        if NOT ((words[i][j] in ['a'..'z']) OR (words[i][j] in ['A'..'Z']) OR (words[i][j] in ['0'..'9'])) then begin
          validInput := false;
        end; (*if*)
        





      end; //while
      s := s + words[i];

    end; (*while*)






  end;


  var
    a, b, s: string;


begin
  a:='Teststring';
  b:='TEstSTRING';

  WriteLn(a, length(a));
  writeln(WithoutLastChar(a));
  WriteLn(EqualsIgnoreCase(a,b));
  WriteLn('high(a): ', high(a));

  WriteLn(LowerCase(b));


end.