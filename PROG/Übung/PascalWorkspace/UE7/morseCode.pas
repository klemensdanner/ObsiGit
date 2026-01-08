program MorseCode;

  type
    TreeNodePtr = ^TreeNode;
    TreeNode = record
      left, right: TreeNodePtr;
      ch: char;
    end;
    MorseTreePtr = TreeNodePtr;

  procedure InsertMorseCode(tree: MorseTreePtr; ch: CHAR; code: STRING);
    var
      n, st: MorseTreePtr;
      i: integer;
  begin

    if tree = nil then begin
      WriteLn('Error: Root Node does not exist');
      Exit;
    end;
    tree^.ch := '/'; //root

    i := 1;
    st := tree;
    n := nil;
    while i <= length(code) do begin
      if code[i] = '.' then begin //links gehen
        if st^.left = nil then begin //Knoten erstellen, mit dummyWert füllen, in den Baum einhängen, damit man "drüberlaufen kann"
          New(n);
          n^.left := nil;
          n^.right := nil;
          n^.ch := ' ';
          st^.left := n;
        end;
        st := st^.left;

      end else begin
        if code[i] = '-' then begin //rechts gehen
          if st^.right = nil then begin
            New(n);
            n^.left := nil;
            n^.right := nil;
            n^.ch := ' ';
            st^.right := n;
          end;
          st := st^.right;
        end else begin //ungültiger Code, Exit
          WriteLn('Error: invalid Code - Exit');
          Exit;
        end;
      end;
      inc(i);
    end;

    if i = 1 + length(code) then begin //st ist an der richigen Stelle, neuer Knoten bereits da, nur mehr Wert ändern
      st^.ch := ch;
    end else begin //Fehler (i muss gleich 1+length(code) sein)
      WriteLn('Error');
      Exit;
    end;
  end;


  function Lookup(tree: MorseTreePtr; code: STRING): CHAR;
    var
      st: MorseTreePtr;
      i: integer;
  begin
    i := 1;
    st := tree;
    while (i <= length(code)) and (st <> nil) do begin
      if code[i] = '.' then begin
        st := st^.left;
      end else begin
        if code[i] = '-' then begin
          st := st^.right;
        end else begin
          WriteLn('Error: invalid Code - Exit');
          Lookup := '?';
          Exit;
        end;
      end;
      inc(i);
    end;

    if st <> nil then begin
      Lookup := st^.ch;
    end else begin // nicht enthalten
      Lookup := '?';
    end;
  end;

  function ConvertMessage(tree: MorseTreePtr; mCode: string): string;
    var
      output, tmpCode: string;
      i: integer;
  begin
    output := '';
    if (tree = nil) or (mCode = '') then begin
      ConvertMessage := 'Tree Empty or code missing';
      Exit;
    end;
    
    i := 1;
    tmpCode := '';
    output := '';
    while i <= length(mCode) do begin
      if not (mCode[i] in [' ', ';']) then begin //bei gültigem Code also nur . oder -, ungültige Zeichen zu tmpCode hinzugefügt und nachher an Lookup weitergegeben
        tmpCode := tmpCode + mCode[i];
        if i = length(mCode) then begin
          output := output + Lookup(tree, tmpCode);
        end;
      end else begin // bei gültigem code also nur ' ' oder ;
        if mCode[i] = ' ' then begin
          if tmpCode <> '' then begin //Fall, dass zuerst ';' und darauffolgend ' ' eingegeben wird, wird ausgeschlossen
            output := output + Lookup(tree, tmpCode);
            tmpCode := '';
          end;
        end else begin
          if mCode[i] = ';' then begin
            if tmpCode <> '' then begin //Fall, dass zuerst ' ' und darauffolgend ';' eingegeben wird, wird ausgeschlossen
              output := output + Lookup(tree, tmpCode) + ' ';
              tmpCode := '';
            end;
          end;
        end;
      end;
      inc(i);
    end;

    ConvertMessage := output;
  end;

  function TreeValid(tree: MorseTreePtr): boolean; //prüft, dass keine Dummywerte mehr vorhanden sind
  begin
    if tree = nil then begin
      TreeValid := true;
    end else begin
      if tree^.ch = ' ' then begin
        TreeValid := false;
      end else begin
        TreeValid := TreeValid(tree^.left) and TreeValid(tree^.right);
      end;
    end;
  end;

  procedure DisposeTree(var tree: MorseTreePtr);
  begin
    if tree <> nil then begin
      DisposeTree(tree^.left);
      DisposeTree(tree^.right);
      Dispose(tree);
      tree := nil;
    end;
  end;

  var
    tree: MorseTreePtr;
    mCode: string;

begin
  New(tree); //root erstellen
  tree^.right := nil;
  tree^.left := nil;
  tree^.ch := '/';

  InsertMorseCode(tree, 'A', '.-');
  InsertMorseCode(tree, 'B', '-...');
  InsertMorseCode(tree, 'C', '-.-.');
  InsertMorseCode(tree, 'D', '-..');
  InsertMorseCode(tree, 'E', '.');
  InsertMorseCode(tree, 'F', '..-.');
  InsertMorseCode(tree, 'G', '--.');
  InsertMorseCode(tree, 'H', '....');
  InsertMorseCode(tree, 'I', '..');
  InsertMorseCode(tree, 'J', '.---');
  InsertMorseCode(tree, 'K', '-.-');
  InsertMorseCode(tree, 'L', '.-..');
  InsertMorseCode(tree, 'M', '--');
  InsertMorseCode(tree, 'N', '-.');
  InsertMorseCode(tree, 'O', '---');
  InsertMorseCode(tree, 'P', '.--.');
  InsertMorseCode(tree, 'Q', '--.-');
  InsertMorseCode(tree, 'R', '.-.');
  InsertMorseCode(tree, 'S', '...');
  InsertMorseCode(tree, 'T', '-');
  InsertMorseCode(tree, 'U', '..-');
  InsertMorseCode(tree, 'V', '...-');
  InsertMorseCode(tree, 'W', '.--');
  InsertMorseCode(tree, 'X', '-..-');
  InsertMorseCode(tree, 'Y', '-.--');
  InsertMorseCode(tree, 'Z', '--..');


  if TreeValid(tree) then begin
    Write('Enter a Code > ');
    ReadLn(mCode);
    WriteLn(ConvertMessage(tree, mCode));
  end else begin
    WriteLn('Tree invalid');
  end;

  DisposeTree(tree);

end.