# 1 Candles
## 1.1 Lösungsidee

Wenn die Höhe sich um 1 erhöht, scheinen sich alle Kerzen an jeder Seite der neuen "Hauptkerze" (die größte, mittlere in der Visualisierung) zu gruppieren. Da eine Kerze als Dreieck repräsentiert ist, verdreifacht sich die Anzahl der Kerzen, zusätzlich gibt es eine neue "Hauptkerze". Eine Christbaum der Höhe 1 hat genau eine Kerze. Damit ist die rekursive Lösung gefunden.

Die iterative Lösung funktioniert im Prinzip gleich. Die Variable result wird mit 1 initialisiert. Ist die Höhe gleich 1, so wird die Schleife übersprungen und 1 zurückgegeben. Ansonsten wird in einer Schleife bis h hochgezählt und immer das vorläufige Ergebnis verdreifacht und 1 addiert.

<div class="page-break" style="page-break-before: always;"></div>

## 1.2 Quellcode

```pascal
PROGRAM Candles;

  FUNCTION CandlesRec(h: INTEGER): INTEGER;
  BEGIN
    IF h = 1 THEN BEGIN
      CandlesRec := 1;
    END ELSE BEGIN
      CandlesRec := 1 + (3 * CandlesRec(h-1));
    END;
  END;

  FUNCTION CandlesIt(h: INTEGER): INTEGER;
    VAR
      i: INTEGER;
      result: INTEGER;
  BEGIN 
    result := 1;
    FOR i := 2 TO h DO BEGIN
      result := 1 + (3 * result);
    END;
    CandlesIt := result;
  END;

  VAR
    userInput: INTEGER;

BEGIN
  Write('How high is the tree? > ');
  ReadLn(userInput);
  
  IF userInput > 0 THEN BEGIN
    Write('CandlesRec:');
    WriteLn(CandlesRec(userInput):3);

    Write('CandlesIt:');
    WriteLn(CandlesIt(userInput):3);
  END ELSE BEGIN
    WriteLn('Enter a positive value');
  END;
END.
```

<div class="page-break" style="page-break-before: always;"></div>

## 1.3 Tests

| Input | Beschreibung          | Output                                    |
| ----- | --------------------- | ----------------------------------------- |
| 1     | -                     | ![[Pasted image 20251229111617.png\|200]] |
| 2     | -                     | ![[Pasted image 20251229111633.png\|200]] |
| 3     | -                     | ![[Pasted image 20251229111648.png\|200]] |
| 0     | Wert kleiner gleich 1 | ![[Pasted image 20251229111705.png\|200]] |
<div class="page-break" style="page-break-before: always;"></div>


# 2 Floor-Funktion

## 2.1 Lösungsidee

Der Baum soll iterativ so lange durchwandert werden, bis entweder genau der gesuchte Wert gefunden ist, oder einer der Teilbäume NIL ist. In der Schleife wird jeder Wert als potenzieller Treffer gespeichert, der kleiner als der gegebene Wert x ist.
Ist der Zeiger auf den nächsten Knoten (bei mir "st") gleich dem Wert x, wird dieser zurückgegeben, ansonsten der zuletzt gespeicherte Treffer.
Hilfsfunktionen ermöglichen die Ein- und Ausgabe des Baumes.

<div class="page-break" style="page-break-before: always;"></div>

### 2.2 Quellcode
```pascal
PROGRAM FindFloor;
  TYPE
    TreeNodePtr = ^TreeNode;
    TreeNode = RECORD
      left, right: TreeNodePtr;
      data: INTEGER;
    END;
    TreePtr = TreeNodePtr;
  
  PROCEDURE InsertTree(VAR tree: TreePtr; val: INTEGER);
    VAR
      n: TreeNodePtr;
      st, pt: TreeNodePtr;
  BEGIN
    New(n);
    n^.left := NIL;
    n^.right := NIL;
    n^.data := val;

    IF tree = NIL THEN BEGIN
      tree := n;
      Exit;
    END;

    st := tree;
    pt := NIL;
    WHILE st <> NIL DO BEGIN
      pt := st;
      IF val < st^.data THEN BEGIN
        st := st^.left;
      END ELSE BEGIN
        st := st^.right;
      END;
    END;
    
    IF val < pt^.data THEN BEGIN
      pt^.left := n;
    END ELSE BEGIN
      pt^.right := n;
    END;
  END;

  PROCEDURE ReadTree(VAR tree: TreePtr);
    VAR
      val: INTEGER;
  BEGIN
    val := -1;
    WHILE val <> 0 DO BEGIN
      Write(' > ');
      ReadLn(val);
      IF val <> 0 THEN BEGIN
        InsertTree(tree, val);
      END;
    END;  
  END;

  PROCEDURE WriteTree(tree: TreePtr);
  BEGIN
    IF tree <> NIL THEN BEGIN
      WriteTree(tree^.left);
      Write(tree^.data:3);
      WriteTree(tree^.right);
    END;
  END;

  PROCEDURE DisposeTree(VAR tree: TreePtr);
  BEGIN
    IF tree <> NIL THEN BEGIN
      DisposeTree(tree^.left);
      DisposeTree(tree^.right);
      Dispose(tree);
    END;
    tree := NIL;
  END;

  FUNCTION Floor(tree: TreePtr; x: INTEGER): TreeNodePtr;
    VAR
      st: TreeNodePtr;
      possResult, result: TreeNodePtr;
  BEGIN
    IF tree = NIL THEN BEGIN
      Floor := NIL;
      Exit;
    END;
    st := tree;
    possResult := NIL;
    result := NIL;
    
    WHILE (st <> NIL) AND (st^.data <> x) DO BEGIN
      IF st^.data < x THEN BEGIN (*mögl. Treffer, rechts weitersuchen*)
        possResult := st;
        st := st^.right;
      END ELSE BEGIN (* st^.data > x, links weitersuchen*)
        st := st^.left;
      END;
    END;

    IF st = NIL THEN BEGIN
      result := possResult;
    END ELSE BEGIN
      result := st;
    END;
    
    Floor := result;
  END;

  VAR
    t: TreePtr;
    x: INTEGER;
    tmp: TreeNodePtr;

BEGIN
  t := NIL;
  ReadTree(t);
  WriteTree(t);
  WriteLn;

  Write(' Floor of > ');
  ReadLn(x);
  tmp := Floor(t, x);
  IF tmp <> NIL THEN BEGIN
    WriteLn(tmp^.data);
  END ELSE BEGIN
    WriteLn('Error: value invalid or tree empty');
  END;  

  DisposeTree(t);
END.
```

<div class="page-break" style="page-break-before: always;"></div>

### 2.3 Tests

| Input                  | Begründung                                                  | Output                                    |
| ---------------------- | ----------------------------------------------------------- | ----------------------------------------- |
| 2 4 3 5 9 7 6<br>x = 8 | Insert funktioniert und richtiger Floor bei Standard-Input  | ![[Pasted image 20251223123628.png\|200]] |
| 2 4 3 5 9 7 6<br>x = 5 | Wert x kommt im Baum vor                                    | ![[Pasted image 20251223123835.png\|200]] |
| -                      | Leerer Baum                                                 | ![[Pasted image 20251223123950.png\|200]] |
| 4 5 7 9<br>x = 3       | Wert x kleiner als alle Werte im Baum, es gibt keinen Floor | ![[Pasted image 20251223124253.png\|200]] |
| 4 5 7 9<br>x = 10      | Wert x größer als alle Werte im Baum                        | ![[Pasted image 20251223124621.png\|150]] |

<div class="page-break" style="page-break-before: always;"></div>

## 3 Morsen mit Binärbaum

### 3.1 Lösungsidee

Die Prozedur InsertMorseCode soll den angegebenen Code als "Wegweiser" verwenden:
- ist das nächste Zeichen im Code ein '.', wird links fortgeführt
- ist das nächste Zeichen im Code ein '-', wird links fortgeführt
Damit die Reihenfolge der Aufrufe mit den Buchstaben egal ist, werden entlang dem Weg Dummyknoten angelegt, wenn die Knoten entlang eines Pfades noch nicht existieren. Alle diese Werte müssen am Ende mit echten Buchstaben überschrieben sein, was die Funktion TreeValid prüft.

Die Funktion Lookup folgt einem ähnlichen Prinzip, nur dass keine neuen Knoten eingefügt werden müssen. Der Code fungiert als "Wegweiser". Zurückgegeben wird der ch-Wert des Knotens, auf den der Zeiger 'st' nach der Schleife zeigt.

Die Funktion ConvertMessage übernimmt die finale Konvertierung des Codes in einen string.
Der Hauptcode wird dabei Zeichen für Zeichen durchlaufen und dabei ein output zusammengebaut. Immer wenn ein Leerzeichen oder Strichpunkt kommt, endet ein Buchstabe, welcher mit Lookup übersetzt wird und zum output hinzugefügt wird. Bei einem Strichpunkt wird zusätzlich ein Leerzeichen hinzugefügt (Wortende).

<div class="page-break" style="page-break-before: always;"></div>

## 3.2 Quellcode
```pascal
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
```

<div class="page-break" style="page-break-before: always;"></div>

## 3.3 Tests

| Input                                | Beschreibung                                                                                                                   | Output                                    |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------- |
| Standard                             | Allgemeiner Test                                                                                                               | ![[Pasted image 20251227195334.png\|350]] |
| -                                    | leer lassen                                                                                                                    | ![[Pasted image 20251227195618.png\|300]] |
| leerer Baum (tree = nil)             | Fehlermeldung muss kommen                                                                                                      | ![[Pasted image 20251227202335.png\|350]] |
| ' ' folgt auf ;                      | Lookup wird nicht mit einem leeren Code aufgerufen                                                                             | ![[Pasted image 20251227195845.png\|350]] |
| siehe Screenshot                     | gesuchter Knoten existiert im Baum nicht - liefert ein '?' für dasjenige Zeichen                                               | ![[Pasted image 20251227200055.png\|350]] |
| andere Zeichen als Code              | Erwartet: Fehlermeldung + Lookup gibt ein '?' zurück, wenn ein Wert nicht gefunden wird                                        | ![[Pasted image 20251227200441.png\|350]] |
| InsertMorseCode(tree, 'Z', '--...'); | Hier ist beim Hinzufügen eines Buchstabens im Code ein Punkt zu viel. Es gibt also min einen Dummyknoten, der Baum ist invalid | ![[Pasted image 20251227200828.png\|150]] |

