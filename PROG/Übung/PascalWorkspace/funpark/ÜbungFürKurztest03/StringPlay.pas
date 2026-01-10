program ArrayTogether;

function ArrayComb(a: array of string; n: integer): string;
var
  stringFin, stringTog: string;
  i, j: integer;

BEGIN
  stringFin := '';
  stringTog := '';
  for i := 0 to (n-1) do BEGIN
    stringTog := stringTog + a[i];
  end; //for

  for j := 1 to length(stringTog) do BEGIN
    if stringTog[j] <> ' ' then BEGIN
      stringFin := stringFin + stringTog[j];
    end; //if
  end; //for

  ArrayComb := stringFin;
end;

// --- Das Hauptprogramm zum Testen LG Gemini ---
var
  TestArray: array of string; // Ein dynamisches Array
  Ergebnis: string;
begin
  // 1. Test-Daten vorbereiten
  SetLength(TestArray, 3); // Wir wollen 3 Strings speichern
  TestArray[0] := 'Hallo ';
  TestArray[1] := ' Welt ';
  TestArray[2] := 'Pascal!';

  writeln('Ursprung: "Hallo ", " Welt ", "Pascal!"');

  // 2. Deine Funktion aufrufen
  // Wir übergeben das Array und die Länge (3)
  Ergebnis := ArrayComb(TestArray, 3);

  // 3. Ergebnis ausgeben
  writeln('--------------------------------');
  writeln('Ergebnis: ' + Ergebnis);
  writeln('--------------------------------');

  // Warten, damit sich das Fenster nicht sofort schließt
  writeln('Druecke Enter zum Beenden...');
  readln;
end.