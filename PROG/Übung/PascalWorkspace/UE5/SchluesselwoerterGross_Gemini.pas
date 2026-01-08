program SchluesselKonverter;

uses SysUtils; { Notwendig für UpperCase und LowerCase }

const
  { Anzahl der Keywords wurde erhöht }
  KeyCount = 64; 
  
  Keywords: array[1..KeyCount] of string = (
    { --- Steuerbefehle & Reservierte Wörter --- }
    'and', 'array', 'begin', 'case', 'const', 'constructor', 'destructor', 
    'div', 'do', 'downto', 'else', 'end', 'file', 'for', 'function', 
    'goto', 'if', 'implementation', 'in', 'interface', 'label', 'mod', 
    'nil', 'not', 'of', 'or', 'packed', 'procedure', 'program', 'record', 
    'repeat', 'set', 'shl', 'shr', 'then', 'to', 'type', 'unit', 'until', 
    'uses', 'var', 'while', 'with', 'xor',

    //true und false adden
    'true', 'false',
    
    { --- Datentypen --- }
    'boolean', 'byte', 'cardinal', 'char', 'comp', 'double', 'extended', 
    'int64', 'integer', 'longint', 'pointer', 'real', 'shortint', 
    'single', 'smallint', 'string', 'text', 'word'
  );

{ Prüft, ob ein Zeichen zu einem Wort gehört (Buchstaben, Zahlen, Unterstrich) }
function IsIdentifierChar(c: Char): Boolean;
begin
  IsIdentifierChar := (c in ['A'..'Z', 'a'..'z', '0'..'9', '_']);
end;

{ Wandelt das Wort in Großbuchstaben um, falls es in der Liste steht }
function ToUpperKeyword(w: string): string;
var
  i: Integer;
begin
  for i := 1 to KeyCount do
  begin
    { Vergleich ist case-insensitive (unempfindlich gegen Groß-/Kleinschreibung) }
    if CompareText(w, Keywords[i]) = 0 then
    begin
      ToUpperKeyword := UpperCase(w);
      Exit;
    end;
  end;

  ToUpperKeyword := w; // Kein Keyword -> bleibt wie es ist
end;

function ProcessLine(s: string): string;
var
  outS, word: string;
  i: Integer;
begin
  outS := '';
  word := '';

  for i := 1 to Length(s) do
  begin
    if IsIdentifierChar(s[i]) then
      word := word + s[i]
    else
    begin
      if word <> '' then
      begin
        outS := outS + ToUpperKeyword(word);
        word := '';
      end;
      outS := outS + s[i]; // Trennzeichen (Leerzeichen, Klammer, Punkt...) übernehmen
    end;
  end;

  { Letztes Wort der Zeile verarbeiten }
  if word <> '' then
    outS := outS + ToUpperKeyword(word);

  ProcessLine := outS;
end;

var
  infile, outfile: Text;
  inName, outName, line: string;

begin
  Write('Input-Datei: ');
  ReadLn(inName);

  Write('Output-Datei: ');
  ReadLn(outName);

  Assign(infile, inName);
  
  {$I-} { Fehlerprüfung aus }
  Reset(infile);
  {$I+} { Fehlerprüfung an }

  if IOResult <> 0 then
  begin
    WriteLn('Fehler: Datei "', inName, '" nicht gefunden.');
    Halt;
  end;

  Assign(outfile, outName);
  Rewrite(outfile);

  while not EOF(infile) do
  begin
    ReadLn(infile, line);
    WriteLn(outfile, ProcessLine(line));
  end;

  Close(infile);
  Close(outfile);
  
  WriteLn('Konvertierung abgeschlossen.');
  WriteLn('Druecken Sie Enter zum Beenden...');
  ReadLn;
end.