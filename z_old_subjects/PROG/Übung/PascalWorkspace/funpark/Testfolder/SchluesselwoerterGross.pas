program SchluesselKonverter;

const
  KeyCount = 36;
  Keywords: array[1..KeyCount] of string = (
    'and', 'array', 'begin', 'case', 'const', 'div', 'do', 'downto',
    'else', 'end', 'file', 'for', 'function', 'goto', 'if', 'in',
    'label', 'mod', 'nil', 'not', 'of', 'or', 'packed', 'procedure',
    'program', 'record', 'repeat', 'set', 'then', 'to', 'type',
    'until', 'var', 'while', 'with', 'uses'
  );

function IsLetter(c: Char): Boolean;
begin
  IsLetter := (c in ['A'..'Z','a'..'z']);
end;

function ToUpperKeyword(w: string): string;
var
  i: Integer;
begin
  for i := 1 to KeyCount do
    if LowerCase(w) = Keywords[i] then
    begin
      ToUpperKeyword := UpCase(w);
      Exit;
    end;

  ToUpperKeyword := w;  // kein Keyword → unverändert
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
    if IsLetter(s[i]) then
      word := word + s[i]
    else
    begin
      if word <> '' then
      begin
        outS := outS + ToUpperKeyword(word);
        word := '';
      end;
      outS := outS + s[i];   // Zeichen übernehmen
    end;
  end;

  // letztes Wort am Zeilenende
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
  Reset(infile);

  Assign(outfile, outName);
  Rewrite(outfile);

  while not EOF(infile) do
  begin
    ReadLn(infile, line);
    WriteLn(outfile, ProcessLine(line));
  end;

  Close(infile);
  Close(outfile);
end.
