PROGRAM MorseCode;

  TYPE
    TreeNodePtr = ^TreeNode;
    TreeNode = RECORD
      left, right: TreeNodePtr;
      ch: CHAR;
    END;
    MorseTreePtr = TreeNodePtr;

  PROCEDURE InsertMorseCode(tree: MorseTreePtr; ch: CHAR; code: STRING);
    VAR
      n, st: MorseTreePtr;
      i: INTEGER;
  BEGIN

    IF tree = NIL THEN BEGIN
      WriteLn('Error: Root Node does not exist');
      Exit;
    END;
    tree^.ch := '/'; (*root*)

    i := 1;
    st := tree;
    n := NIL;
    WHILE i <= length(code) DO BEGIN
      IF code[i] = '.' THEN BEGIN (*links gehen*)
        IF st^.left = NIL THEN BEGIN (*Knoten erstellen, mit dummyWert füllen, in den Baum einhängen, damit man "drüberlaufen kann"*)
          New(n);
          n^.left := NIL;
          n^.right := NIL;
          n^.ch := ' ';
          st^.left := n;
        END;
        st := st^.left;

      END ELSE BEGIN
        IF code[i] = '-' THEN BEGIN (*rechts gehen*)
          IF st^.right = NIL THEN BEGIN
            New(n);
            n^.left := NIL;
            n^.right := NIL;
            n^.ch := ' ';
            st^.right := n;
          END;
          st := st^.right;
        END ELSE BEGIN (*ungültiger Code, Exit*)
          WriteLn('Error: invalid Code - Exit');
          Exit;
        END;
      END;
      inc(i);
    END;

    IF i = 1 + length(code) THEN BEGIN (*st ist an der richigen Stelle, neuer Knoten bereits da, nur mehr Wert ändern*)
      st^.ch := ch;
    END ELSE BEGIN (*Fehler (i muss gleich 1+length(code) sein)*)
      WriteLn('Error');
      Exit;
    END;
  END;


  FUNCTION Lookup(tree: MorseTreePtr; code: STRING): CHAR;
    VAR
      st: MorseTreePtr;
      i: INTEGER;
  BEGIN
    i := 1;
    st := tree;
    WHILE (i <= length(code)) AND (st <> NIL) DO BEGIN
      IF code[i] = '.' THEN BEGIN
        st := st^.left;
      END ELSE BEGIN
        IF code[i] = '-' THEN BEGIN
          st := st^.right;
        END ELSE BEGIN
          WriteLn('Error: invalid Code - Exit');
          Lookup := '?';
          Exit;
        END;
      END;
      inc(i);
    END;

    IF st <> NIL THEN BEGIN
      Lookup := st^.ch;
    END ELSE BEGIN (* nicht enthalten*)
      Lookup := '?';
    END;
  END;

  FUNCTION ConvertMessage(tree: MorseTreePtr; mCode: STRING): STRING;
    VAR
      output, tmpCode: STRING;
      i: INTEGER;
  BEGIN
    output := '';
    IF (tree = NIL) OR (mCode = '') THEN BEGIN
      ConvertMessage := 'Tree Empty or code missing';
      Exit;
    END;
    
    i := 1;
    tmpCode := '';
    output := '';
    WHILE i <= length(mCode) DO BEGIN
      IF NOT (mCode[i] IN [' ', ';']) THEN BEGIN (*bei gültigem Code also nur . oder -, ungültige Zeichen zu tmpCode hinzugefügt und nachher an Lookup weitergegeben*)
        tmpCode := tmpCode + mCode[i];
        IF i = length(mCode) THEN BEGIN
          output := output + Lookup(tree, tmpCode);
        END;
      END ELSE BEGIN (* bei gültigem code also nur ' ' oder ;*)
        IF mCode[i] = ' ' THEN BEGIN
          IF tmpCode <> '' THEN BEGIN (*Fall, dass zuerst ';' und darauffolgend ' ' eingegeben wird, wird ausgeschlossen*)
            output := output + Lookup(tree, tmpCode);
            tmpCode := '';
          END;
        END ELSE BEGIN
          IF mCode[i] = ';' THEN BEGIN
            IF tmpCode <> '' THEN BEGIN (*Fall, dass zuerst ' ' und darauffolgend ';' eingegeben wird, wird ausgeschlossen*)
              output := output + Lookup(tree, tmpCode) + ' ';
              tmpCode := '';
            END;
          END;
        END;
      END;
      inc(i);
    END;

    ConvertMessage := output;
  END;

  FUNCTION TreeValid(tree: MorseTreePtr): BOOLEAN; (*prüft, dass keine Dummywerte mehr vorhanden sind*)
  BEGIN
    IF tree = NIL THEN BEGIN
      TreeValid := TRUE;
    END ELSE BEGIN
      IF tree^.ch = ' ' THEN BEGIN
        TreeValid := FALSE;
      END ELSE BEGIN
        TreeValid := TreeValid(tree^.left) AND TreeValid(tree^.right);
      END;
    END;
  END;

  PROCEDURE DisposeTree(VAR tree: MorseTreePtr);
  BEGIN
    IF tree <> NIL THEN BEGIN
      DisposeTree(tree^.left);
      DisposeTree(tree^.right);
      Dispose(tree);
      tree := NIL;
    END;
  END;

  VAR
    tree: MorseTreePtr;
    mCode: STRING;

BEGIN
  New(tree); (*root erstellen*)
  tree^.right := NIL;
  tree^.left := NIL;
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

  IF TreeValid(tree) THEN BEGIN
    Write('Enter a Code > ');
    ReadLn(mCode);
    WriteLn(ConvertMessage(tree, mCode));
  END ELSE BEGIN
    WriteLn('Tree invalid');
  END;

  DisposeTree(tree);

END.