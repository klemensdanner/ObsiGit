# 1 Laufzeitkomplexität

![[Pasted image 20260121004818.png]]

Algorithmus 2:
![[Pasted image 20260121004845.png]]

<div class="page-break" style="page-break-before: always;"></div>

#### b) Asymptotische Laufzeitkomplexität

Die asympthotische Laufzeitkomplexität lässt sich einfach aus den Laufzeitfunktionen ablesen. Da die höchste Potenz jeweils 1 beträgt, ist die asympthotische Laufzeitkomplexität jeweils O(n).
Trotzdem ist der iterative Algorithmus natürlich schneller.

<div class="page-break" style="page-break-before: always;"></div>

# 2 Zweidimensionale Felder sortieren

### 2.1 Lösungsidee
In dieser Aufgabe sollen die Zeilen sortiert werden. Man braucht zunächst eine Möglichkeit, Zeilen zu vergleichen. Dazu wird eine Funktion RowGreaterThan definiert, welche zwei Zeilen vergleicht, in dem sie zunächst alle gleichen Werte überspringt und dann den nächsten Wert vergleicht. Diese Funktion lässt sich einfach implimentieren, weil nur gleich lange Zeilen verglichen werden sollen.

Die Prozedur SortLinesByColumns implimentiert ein normales Einfügesortieren. Dabei wird das nächste Element immer in einen sortierten Bereich eingefügt (hier von first bis i).
Zunächst wird das erste Element, welches nicht im sortierten Bereich liegt gespeichtert, werden die Elemente im sortierten Bereich in einer while-Schleife so lange nach rechts verschoben, bis die Einfügeposition gefunden wurde.

<div class="page-break" style="page-break-before: always;"></div>

### 2.2 Quellcode

```c
PROGRAM SortMatrix;

  CONST
    rows = 5;
    columns = 5;
  
  TYPE
    Row = ARRAY[1..columns] OF INTEGER;
    Matrix = ARRAY[1..rows] OF Row;

  PROCEDURE ReadMatrix(VAR m: Matrix);
    VAR
      i, j: INTEGER;
  BEGIN
    FOR i := 1 TO rows DO BEGIN
      Write('Enter a row with ', columns, ' columns > ');
      FOR j := 1 TO columns DO BEGIN
        Read(m[i][j]);
      END;
    END;
  END;

  PROCEDURE WriteMatrix(m: Matrix);
    VAR
      i, j: INTEGER;
  BEGIN
    FOR i := 1 TO rows DO BEGIN
      Write('[ ');
      FOR j := 1 TO columns DO BEGIN
        Write(m[i][j]:2);
      END;
      Write(' ]');
      WriteLn;
    END;
  END;


  FUNCTION RowGreaterThan(a, b: Row): BOOLEAN; (*returns true if a > b*)
    VAR
      len, i: INTEGER;
  BEGIN
    i := 1;
    len := length(a);

    WHILE (i <= len) AND (a[i] = b[i]) DO BEGIN
      inc(i);
    END;

    RowGreaterThan := (i <= len) AND (a[i] > b[i]);
  END;

  PROCEDURE SortLinesByColumns(VAR m: Matrix);
    VAR
      first, last: INTEGER;
      i, j: INTEGER;
      tmp: Row;
  BEGIN
    first := 1;
    last := rows;

    FOR i := first TO last - 1 DO BEGIN
      (* sorted area: first .. i*)
      tmp := m[i + 1];
      j := i;
      WHILE (j >= first) AND RowGreaterThan(m[j], tmp) DO BEGIN
        m[j + 1] := m[j];
        j := j - 1;
      END;
      m[j + 1] := tmp;
    END;
  END;

  VAR
    m: Matrix;

BEGIN
  ReadMatrix(m);
  WriteLn;
  WriteMatrix(m);
  WriteLn;

  SortLinesByColumns(m);
  WriteMatrix(m);
  WriteLn;
END.
```

<div class="page-break" style="page-break-before: always;"></div>

### 2.3 Tests

| Anmerkung                                                                                                                                                                                                                | Input / Output                            |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------- |
| Beispiel 0                                                                                                                                                                                                               | ![[Pasted image 20260120231602.png\|400]] |
| Beispiel 1                                                                                                                                                                                                               | ![[Pasted image 20260120231808.png\|400]] |
| <br>1. 1 1 1 1 1 und 1 1 1 1 2 beweisen,<br>dass die Vergeleichsfunktion bis zur<br>letzten Ziffer vergleicht<br><br>2. 1 9 9 9 9 und 2 0 0 0 0 zeigen, dass<br>der erste auftretende Unterschied<br>ausschlaggebend ist | ![[Pasted image 20260120232154.png\|400]] |
| bereits sortiert                                                                                                                                                                                                         | ![[Pasted image 20260120232603.png\|400]] |
| umgekehrt sortiert                                                                                                                                                                                                       | ![[Pasted image 20260120232700.png\|400]] |

<div class="page-break" style="page-break-before: always;"></div>

# 3 Auswahlsortieren auf einfach-verkettete Listen

## 3.1 Lösungsidee
Bei der Implimentierung eines SelectionSorts für eine einfach verkettete Liste ergeben sich einige Besonderheiten im Unterschied zur Anwendung des Algorithmus auf Arrays.
Der größte Unterschied ergibt sich darin, dass man Werte nicht so einfach vertauschen kann, weil dabei der next-Wert des Vorgängers angepasst werden muss. Da man in einer einfach verketteten Liste nicht auf den Vorgänger zugreifen kann, wird hier direkt mit den Vorgängern der eigentlichen Knoten gearbeitet.
In der Prozedur SelectionSort wird die Liste an einen Dummy-Knoten angehängt, damit gegebenenfalls auch das erste Element getauscht werden kann.
Dann wird die Liste in einer Schleife iteriert, falls ein Knoten mit einem kleineren Datenwert gefunden wird, wird er mit dem aktuellen Knoten vertauscht. (mithilfe der Prozedur SwapChildNodes)
Dabei muss der Sonderfall berücksichtigt werden, wenn die zu vertauschenden Knoten nebeneinander liegen, da dann der Parentknoten des zweiten Wertes mit dem Knoten des ersten Wertes ident ist.

<div class="page-break" style="page-break-before: always;"></div>

## 3.2 Quellcode

```c
PROGRAM SelSort;

  TYPE
    ListNodePtr = ^ListNode;
    ListNode = RECORD 
      next: ListNodePtr;
      data: INTEGER;
    END;
    ListPtr = ListNodePtr;

  PROCEDURE AddNode(VAR list: ListPtr; val: INTEGER);
    VAR
      newNode: ListNodePtr;
      last: ListNodePtr;
  BEGIN
      New(newNode);
      newNode^.data := val;
      newNode^.next := NIL;

      IF (list = NIL) THEN
        list := newNode
      ELSE BEGIN
        last := list;

        WHILE (last^.next <> NIL) DO BEGIN
          last := last^.next;
        END;

        last^.next := newNode;
      END;
  END;

  PROCEDURE ReadList(VAR l: ListPtr);
    VAR
      val: INTEGER;
  BEGIN
    WriteLn('Enter some int values for your list (end with 0): ');
    Write('> '); ReadLn(val);
    WHILE (val <> 0) DO BEGIN
      AddNode(l, val);
      Write('> '); ReadLn(val);
    END;

  END;

  PROCEDURE DisposeList(VAR l: ListPtr);
    VAR
      curr, pt: ListNodePtr;
  BEGIN
    curr := l;
    WHILE curr <> NIL DO BEGIN
      pt := curr;
      curr := curr^.next;
      Dispose(pt);
      pt := NIL;
    END;
  END;

  PROCEDURE WriteList(l: ListPtr);
    VAR
      curr: ListNodePtr;
  BEGIN
    curr := l;
    WHILE curr <> NIL DO BEGIN
      Write(curr^.data:3);
      curr := curr^.next;
    END;
  END;

  FUNCTION SmallestNodePt(l: ListPtr): ListNodePtr; (*returns parent of the smallest node*)
    VAR
      minPtr, curr, minParent, pt: ListNodePtr;
  BEGIN
    minPtr := l;
    minParent := NIL;
    curr := l;
    pt := NIL;
    WHILE curr <> NIL DO BEGIN
      IF curr^.data < minPtr^.data THEN BEGIN
        minParent := pt;
        minPtr := curr;
      END;
      pt := curr;
      curr := curr^.next;
    END;
    SmallestNodePt := minParent;
  END;

  PROCEDURE SwapChildNodes(ptA, ptB: ListNodePtr); (*swaps Nodes using their parents*)
    VAR
      a, b, childOfA: ListNodePtr;
  BEGIN
    IF (ptA = NIL) OR (ptB = NIL) OR (ptA^.next = NIL) OR (ptB^.next = NIL) THEN BEGIN
      WriteLn('Error: you cannot swap these nodes');
      Exit;
    END;
    a := ptA^.next;
    b := ptB^.next;

    (*Swapping Case 1: nodes to be swapped are neighbours*)
    IF (ptB = a) THEN BEGIN
      a^.next := b^.next;
      b^.next := a;
      ptA^.next := b;      
    END ELSE IF (ptA = b) THEN BEGIN
      b^.next := a^.next;
      a^.next := b;
      ptB^.next := a;
    END ELSE BEGIN (*general case*)
      childOfA := a^.next;

      ptB^.next := a;
      a^.next := b^.next;

      ptA^.next := b;
      b^.next := childOfA;
    END;
  END;

  PROCEDURE SelectionSort(VAR list: ListPtr);
    VAR
      pt: ListNodePtr;
      ptB, dummy: ListNodePtr;
  BEGIN
    IF (list = NIL) OR (list^.next = NIL) THEN BEGIN
      WriteLn('List is empty or has only one node');
      Exit;
    END;


    (* creating a parent dummy node*)
    New(dummy);
    dummy^.next := list;
    dummy^.data := -1;

    pt := dummy;

    WHILE (pt^.next <> NIL) DO BEGIN
      ptB := SmallestNodePt(pt^.next);
      IF ptB <> NIL THEN BEGIN (* smaller node found - swap*)
        SwapChildNodes(pt, ptB);
      END;
      pt := pt^.next;
    END;
    
    list := dummy^.next;
    Dispose(dummy);
    dummy := NIL;

  END;

  VAR
    l: ListPtr;

BEGIN
  l := NIL;
  ReadList(l);
  IF l <> NIL THEN BEGIN
    Write('unsorted >');
    WriteList(l);
    WriteLn;
  END;

  SelectionSort(l);
  IF l <> NIL THEN BEGIN
    Write('sorted   >');
    WriteList(l);
    WriteLn;
  END;
  DisposeList(l);
END.
```

<div class="page-break" style="page-break-before: always;"></div>


## 3.3 Tests

| Anmerkung                                               | Input / Output                            |
| ------------------------------------------------------- | ----------------------------------------- |
| 5 und 1 sind Nachbarn - edge cases                      | ![[Pasted image 20260121003142.png\|400]] |
| 1 muss von ganz hinten nach ganz vorne, Minimum am Ende | ![[Pasted image 20260121003252.png\|400]] |
| umgekehrt sortiert                                      | ![[Pasted image 20260121003452.png\|400]] |
| bereits sortiert                                        | ![[Pasted image 20260121003519.png\|400]] |
| Liste leer                                              | ![[Pasted image 20260121003907.png\|400]] |
| Nur ein Knoten                                          | ![[Pasted image 20260121003948.png\|400]] |
