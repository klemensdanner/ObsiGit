program StyleMaster;

uses SysUtils;

const
  { Diese Liste enthaelt alle Wörter, die GROSS geschrieben werden müssen.
    Standard-Prozeduren wie WriteLn fehlen absichtlich (bleiben MixedCase). }
  KeyCount = 64; 
  Keywords: array[1..KeyCount] of string = (
    'and', 'array', 'begin', 'boolean', 'byte', 'cardinal', 'case', 'char', 
    'comp', 'const', 'constructor', 'destructor', 'div', 'do', 'double', 
    'downto', 'else', 'end', 'extended', 'file', 'for', 'function', 'goto', 
    'if', 'implementation', 'in', 'int64', 'integer', 'interface', 'label', 
    'longint', 'mod', 'nil', 'not', 'of', 'or', 'packed', 'pointer', 
    'procedure', 'program', 'real', 'record', 'repeat', 'set', 'shl', 
    'shortint', 'shr', 'single', 'smallint', 'string', 'text', 'then', 'to', 
    'type', 'unit', 'until', 'uses', 'var', 'while', 'with', 'word', 'xor',
    'true', 'false'
  );

{ --- HILFSFUNKTIONEN --- }

{ Prüft, ob Zeichen Teil eines Wortes ist }
function IsIdentifierChar(c: Char): Boolean;
begin
  IsIdentifierChar := (c in ['A'..'Z', 'a'..'z', '0'..'9', '_']);
end;

{ Wandelt Wort in UPPERCASE, wenn es in der Liste ist }
function ToUpperKeyword(w: string): string;
var
  i: Integer;
begin
  for i := 1 to KeyCount do
  begin
    if CompareText(w, Keywords[i]) = 0 then
    begin
      ToUpperKeyword := UpperCase(w);
      Exit;
    end;
  end;
  ToUpperKeyword := w;
end;

{ --- SCHRITT 1: Kommentare umwandeln --- }
{ Wandelt // in (* *) um, beachtet dabei Strings }
function FixComments(line: string): string;
var
  i: Integer;
  inString: Boolean;
  codePart, commentPart: string;
begin
  inString := False;
  FixComments := line;

  for i := 1 to Length(line) - 1 do
  begin
    if line[i] = '''' then inString := not inString;

    { Wenn // gefunden und nicht im String }
    if (not inString) and (line[i] = '/') and (line[i+1] = '/') then
    begin
      codePart := Copy(line, 1, i - 1);
      commentPart := Copy(line, i + 2, Length(line));
      FixComments := codePart + '(*' + commentPart + '*)';
      Exit;
    end;
  end;
end;

{ --- SCHRITT 2: Keywords grossschreiben --- }
{ Beachtet Strings und Kommentare, damit dort nichts veraendert wird }
function FixKeywords(line: string): string;
var
  outS, word: string;
  i: Integer;
  inString, inCurly, inStar: Boolean;
begin
  outS := '';
  word := '';
  inString := False;
  inCurly := False;  { Fuer { ... } //}
  inStar := False;   { Fuer (* ... *) }

  i := 1;
  while i <= Length(line) do
  begin
    { 1. Status pruefen: Sind wir in einem String oder Kommentar? }
    
    { String Toggle }
    if (line[i] = '''') and not inCurly and not inStar then
      inString := not inString;

    { Curly Comment {  Toggle }
    if (line[i] = '{') and not inString and not inStar then inCurly := True;
    if (line[i] = '}') and inCurly then inCurly := False;

    { Star Comment (* *) Toggle }
    if (i < Length(line)) and (line[i] = '(') and (line[i+1] = '*') 
       and not inString and not inCurly then
       inStar := True;
       
    { Ende von Star Comment pruefen }
    if (i > 1) and (line[i-1] = '*') and (line[i] = ')') and inStar then
       inStar := False;

    { 2. Wortverarbeitung }
    { Wir verarbeiten Keywords NUR, wenn wir NICHT in String/Kommentar sind }
    
    if IsIdentifierChar(line[i]) then
    begin
      word := word + line[i];
    end
    else
    begin
      { Wort ist zu Ende oder wir haben ein Sonderzeichen }
      if word <> '' then
      begin
        { Nur umwandeln, wenn wir in "freiem Code" sind }
        if (not inString) and (not inCurly) and (not inStar) then
          outS := outS + ToUpperKeyword(word)
        else
          outS := outS + word; { Sonst unverändert übernehmen }
          
        word := '';
      end;
      
      outS := outS + line[i];
    end;

    Inc(i);
  end;

  { Letztes Wort falls vorhanden }
  if word <> '' then
  begin
    if (not inString) and (not inCurly) and (not inStar) then
      outS := outS + ToUpperKeyword(word)
    else
      outS := outS + word;
  end;

  FixKeywords := outS;
end;


{ --- HAUPTPROGRAMM --- }
var
  infile, outfile: Text;
  inName, outName, line, tempLine: string;

begin
  WriteLn('--- Pascal Style Master ---');
  WriteLn('1. Wandelt // Kommentare in (* ... *)');
  WriteLn('2. Schreibt Keywords (BEGIN, VAR, INTEGER...) gross');
  WriteLn('---------------------------');

  Write('Input-Datei (Pfad): ');
  ReadLn(inName);

  Write('Output-Datei (Pfad): ');
  ReadLn(outName);

  Assign(infile, inName);
  {$I-} Reset(infile); {$I+}
  if IOResult <> 0 then
  begin
    WriteLn('FEHLER: Input-Datei "', inName, '" nicht gefunden!');
    ReadLn;
    Halt;
  end;

  { Ordner erstellen, falls nötig }
  if ExtractFilePath(outName) <> '' then
    ForceDirectories(ExtractFilePath(outName));

  Assign(outfile, outName);
  Rewrite(outfile);

  while not EOF(infile) do
  begin
    ReadLn(infile, line);
    
    { Erst Kommentare fixen }
    tempLine := FixComments(line);
    
    { Dann Keywords fixen }
    tempLine := FixKeywords(tempLine);
    
    WriteLn(outfile, tempLine);
  end;

  Close(infile);
  Close(outfile);

  WriteLn('Erfolg! Datei gespeichert unter: ', outName);
  WriteLn('Enter druecken zum Beenden.');
  ReadLn;
end.