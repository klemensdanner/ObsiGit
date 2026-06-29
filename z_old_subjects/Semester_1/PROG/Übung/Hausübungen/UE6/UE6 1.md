## 1 Einfach verkettete Liste
### 1.1 Lösungsidee
Die Prozedur RemoveMax wird folgendermaßen implementiert.
Mittels Abfrage wird zuerst ausgeschlossen, dass es sich um eine leere Liste handelt.
Dann wird die Liste mithilfe einer Schleife iteriert. In jedem Schleifendurchlauf wird geprüft, ob der aktuelle Datenwert größer als der bisher größte Datenwert ist. Wenn das der Fall ist wird der Zeiger auf den Knoten mit der größeren Zahl und der Zeiger auf den Wert davor gespeichert.
Wenn die Liste vollständig durchlaufen ist, kann man jetzt den Knoten mit dem größten Datenwert von der Liste aushängen, indem man die next Komponente des vorherigen Knotens mit der Adresse des Nachfolgeknotens überschreibt.
Die Adresse des gefundenen Knoten mit dem höchsten Datenwert wird über den Ausgangsparameter maxNode zurückgegeben.
Zum Testen werden noch weitere Prozeduren erstellt, wie etwa zum Hinzufügen eines Knotens, zum Ausgeben einer Liste oder zum Disposen.

<div class="page-break" style="page-break-before: always;"></div>
### 1.2 Quellcode

```pascal
PROGRAM SinglyLinkedList;

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
      newNode^.next := NIL; (*Wert wird hinten angefügt*)

      (*Liste leer*)
      IF (list = NIL) THEN
        list := newNode
      ELSE BEGIN
        last := list;
        (*Liste nicht leer*)
        WHILE (last^.next <> NIL) DO BEGIN
          last := last^.next;
        END;
        (*jetzt ist last^.next = nil. Also Fügen wir dort Knoten ein*)
        last^.next := newNode;
      END;
  END;

  PROCEDURE ReadList(VAR list: ListPtr);
    VAR
      val: INTEGER;
  BEGIN
    WriteLn('Enter some int values for your list (end with 0): ');
    Write('> '); ReadLn(val);
    WHILE (val <> 0) DO BEGIN
      AddNode(list, val);
      Write('> '); ReadLn(val);
    END;

  END;

  PROCEDURE DisposeList(VAR list: ListPtr);
    VAR
      tmpList: ListNodePtr;

    BEGIN
      WHILE (list <> NIL) DO BEGIN
        tmpList := list;
        list := list^.next;
        Dispose(tmpList);
      END;
    END;

  PROCEDURE WriteList(list: ListPtr);
  BEGIN
    Write('[');
    WHILE (list <> NIL) DO BEGIN
      Write(list^.data:3);
      list := list^.next;
    END; (*while*)
    Write('  ]');
    WriteLn;


  END;

  PROCEDURE RemoveMax(VAR list: ListPtr; VAR maxNode: ListNodePtr);
    VAR
      curr: ListNodePtr;
      maxNodePtr: ListNodePtr;
      prev: ListNodePtr;
      prevMaxNodePtr: ListNodePtr;
  BEGIN
    (*emty list*)
    IF (list = NIL) THEN BEGIN
      maxNode := NIL;
      Exit;
    END;

    (*not emty list*)
    prev := NIL;
    curr := list;
    maxNodePtr := curr; (* init für den Fall, dass die while Schleife übersprungen wird weil nur ein Element drin ist*)
    prevMaxNodePtr := NIL;
    WHILE (curr <> NIL) DO BEGIN
      IF (curr^.data > maxNodePtr^.data) THEN BEGIN
        maxNodePtr := curr;
        prevMaxNodePtr := prev;
      END; (* if*)
      
      prev := curr;
      curr := curr^.next;
    END; (*while*)
    (*jetzt: maxnodePtr ist der ptr zum node mit dem höchsten datenwert*)
    (*jetzt muss dieser node gelöscht werden*)
    
    (*Fall 1: 1. wert ist größter Wert (zu verändernder Wert ist im Compound einer Node sondern in der Startvariable list)*)
    IF prevMaxNodePtr = NIL THEN BEGIN (*Bedingung in der while Schleife nie erflüllt*)
      list := list^.next;
    END ELSE BEGIN
      prevMaxNodePtr^.next := maxNodePtr^.next; (* "Aushängen" des größten Wertes. Hier könnte man disposen, aber weil die Adresse zurückgegeben wird, dispose ich nicht, damit man noch was damit machen kann*)
    END; (*if*)
    maxNode := maxNodePtr; (*Zuweisen vom Rückgabewert*)
  END;

  VAR
    l: ListPtr;
    maxValPtr: ListNodePtr;
BEGIN
  ReadList(l);
  WriteLn('list entered: ');
  WriteList(l);
  WriteLn('max val removed:');
  RemoveMax(l, maxValPtr);
  WriteList(l);
  IF (maxValPtr <> NIL) THEN
    WriteLn('Value removed: ', maxValPtr^.data)
  ELSE
    WriteLn('Emty List');
  Dispose(maxValPtr);
  DisposeList(l);
END.
```

<div class="page-break" style="page-break-before: always;"></div>

### 1.3 Tests

| Eingabe   | Beschreibung                                               | Ausgabe                                   |
| --------- | ---------------------------------------------------------- | ----------------------------------------- |
| 1 3 5 4   | Standardeingabe                                            | ![[Pasted image 20251205133647.png\|300]] |
| 5 3 4 1 2 | Erster Wert am Größten                                     | ![[Pasted image 20251205133811.png\|300]] |
| 1 3 4 5   | Letzter Wert am Größten                                    | ![[Pasted image 20251205133925.png\|200]] |
| 1 5 4 5   | Wenn der Wert zweimal vorkommt,<br>wird der erste entfernt | ![[Pasted image 20251205134039.png\|200]] |
| 4         | nur 1 Knoten                                               | ![[Pasted image 20251205134101.png\|200]] |
| -         | Leere Liste                                                | ![[Pasted image 20251205134300.png\|300]] |
<div class="page-break" style="page-break-before: always;"></div>

## 2 WWW-Zugriffszahlen

### 2.1 Lösungsidee
Die Hauptprozedur verwendet mehrere Funktionen.

Die Funktion String2IPAddr verwandelt eine als string übergebene IP-Adresse in ein Array of Bytes mit 4 Elementen. Dazu wird in einer Schleife der string iteriert. Wenn ein Char eine Ziffer ist, wird er zu einem Substring hinzugefügt. Wenn ein Punkt kommt, wird dieser Substring mit der Standardprozedur Val in einen Integer konvertiert und der Substring wird neu initialisiert.

Die Funktion SortedInsert ist das Herz des Programmes. Sie sorgt dafür, dass eine IP-Adresse in Form eines Arrays an der richtigen Stelle in eine Liste eingefügt wird. Dabei wird die Liste iteriert und immer der Datenwert des Elements in der Liste mit dem Datenwert des einzufügenden Knoten verglichen. Ist der einzufügende Datenwert plötzlich nicht mehr größer als die Werte der Liste muss der Knoten dort eingefügt werden. Durch Abfragen und Vergleiche etc. werden auch Edge-Cases berücksichtigt.

Die Hauptprozedur userInteraction lest in einer Schleife die IP-Adressen solange ein, bis das 'End of file' erreicht ist. Die Adressen werden mit der Funktion String2IPAddr in Arrays konvertiert und mit der Prozedur SortedInsert in die Liste eingefügt. Danach wird die Liste iteriert und eine Countervariable verwendet um zu prüfen, Wieviele IP-Adressen mehrmals vorkommen.

<div class="page-break" style="page-break-before: always;"></div>

### 2.2 Quellcode
```pascal
PROGRAM WWWZugriffszahlen;

  CONST
    ip4max = 4;
  
  TYPE
    IPAddr = ARRAY[1..ip4max] OF BYTE;
    IPAddrNodePtr = ^IPAddrNode;
    IPAddrNode = RECORD
      next: IPAddrNodePtr;
      addr: IPAddr;
      count: INTEGER; (*number of accesses*)
    END; (*record*)
    IPAddrListPtr = IPAddrNodePtr;

  FUNCTION IPGreaterThan(ip1, ip2: IPAddr): BOOLEAN;
    VAR
      i: INTEGER;
      bEqualValues: BOOLEAN;
      bResult: BOOLEAN;
  BEGIN
    i := 1;
    bEqualValues := TRUE;
    WHILE (i <= high(ip1)) AND (i <= high(ip2)) AND bEqualValues DO BEGIN
      bResult := (ip1[i] > ip2[i]);
      bEqualValues := (ip1[i] = ip2[i]);
      inc(i);
    END;
    IPGreaterThan := bResult;
  END;

  FUNCTION IPsEqual(ip1, ip2: IPAddr): BOOLEAN;
  VAR
    bResult: BOOLEAN;
    i: INTEGER;
  BEGIN
    i := 1;
    bResult := TRUE;
    WHILE (i <= high(ip1)) AND (i <= high(ip2)) AND bResult DO BEGIN
      bResult := ip1[i] = ip2[i];
      inc(i);
    END;
      IPsEqual := bResult;    
  END;


  FUNCTION String2IPAddr(strAdress: STRING): IPAddr;
    VAR
      i: INTEGER;
      subCount: INTEGER;
      subString: STRING;
      resultArr: IPAddr;

      (*vars for val procedure*)
      nStringVal: INTEGER;
      errCode: WORD;
  BEGIN
    subString := '';
    subCount := 1;

    nStringVal := 0;
    errCode:= 0;
    FOR i := 1 TO Length(strAdress) DO BEGIN
      IF strAdress[i] IN ['0'..'9'] THEN BEGIN
        subString := subString + strAdress[i];
      END ELSE BEGIN
        val(subString, nStringVal, errCode);
        resultArr[subCount] := nStringVal;
        
        inc(subCount);
        subString := ''; (*reset*)
      END;
    END; (*for*)
    IF (subString <> '') THEN BEGIN
      val(subString, nStringVal, errCode);
      resultArr[subCount] := nStringVal;
    END;
    String2IPAddr := resultArr;
  END;

  PROCEDURE PrintIP(addr: IPAddr);
    VAR
      i: INTEGER;
  BEGIN
    FOR i := 1 TO high(addr) DO
      Write(addr[i]:5);
    WriteLn;
  END;

  (*procedure SortedInsert() und Insert besser in einer Funktion, damit die Liste nicht mehrmals durchlaufen wird*)

  PROCEDURE SortedInsert(VAR list: IPAddrListPtr; adress: IPAddr);
    VAR
      pNewNode: IPAddrNodePtr;
      curr: IPAddrNodePtr;
      prev: IPAddrNodePtr;
  
  BEGIN
    New(pNewNode);
    pNewNode^.addr := adress;
    pNewNode^.next := NIL;
    pNewNode^.count := 1;
    
    curr := list; (*init*)
    prev := list;
    

    IF (list = NIL) THEN BEGIN
      list := pNewNode;
      Exit; (*list empty*)
    END; (*if*)

    WHILE (curr <> NIL) AND IPGreaterThan(pNewNode^.addr, curr^.addr) DO BEGIN
      prev := curr;
      curr := curr^.next;
    END;
    (*Möglichkeiten: curr = Nil --> Knoten hinten einfügen - prev^.next := n*)
    (* oder: curr <> nil --> Einfügeposition gefunden, dann ist not(pNewNode^.addr > curr^.addr), also (pNewNode^.adress <= curr^.addr)*)
    (*Eingefügt werden muss zwischen prev und curr*)
    IF (curr <> NIL) AND IPsEqual(pNewNode^.addr, curr^.addr) THEN BEGIN (*wenn gleich, counter erhöhen, Neue Node wieder disposen*)
      inc(curr^.count);
      Dispose(pNewNode);
    END ELSE BEGIN
      IF (curr = NIL) THEN BEGIN (*hinten einfügen*)
        prev^.next := pNewNode;
      END ELSE
        IF (curr = list) THEN BEGIN
          pNewNode^.next := list;
          list := pNewNode;
      END ELSE BEGIN (* curr <> nil*)
        pNewNode^.next := prev^.next; (*Adr von curr*)
        prev^.next := pNewNode; (*fertig eingehängt*)
      END; (*if*)
    END; (*if*)
  END;

  PROCEDURE DisposeList(VAR list: IPAddrListPtr);
  VAR
    tmpList: IPAddrNodePtr;

  BEGIN
    WHILE (list <> NIL) DO BEGIN
      tmpList := list;
      list := list^.next;
      Dispose(tmpList);
    END;
  END;

  PROCEDURE userInteraction;
    VAR
      strIP: STRING;
      arrIPAddr: IPAddr;
      list: IPAddrListPtr;
      multiAddrCount: INTEGER;
      
      (*zum Liste iterieren:*)
      curr: IPAddrNodePtr;
  BEGIN
    list := NIL; (*init*)
    WHILE NOT eof DO BEGIN
      ReadLn(strIP);
      arrIPAddr := String2IPAddr(strIP);
      SortedInsert(list, arrIPAddr);
    END;

    (*Liste iterieren*)
    multiAddrCount := 0;
    curr := list;

    WriteLn;
    WHILE (curr <> NIL) DO BEGIN
      PrintIP(curr^.addr);
      IF (curr^.count > 1) THEN
        inc(multiAddrCount);
      curr := curr^.next;
    END; (*while   *)

    DisposeList(list);
    list := NIL;
    WriteLn('Number of Adresses with more than 1 access: ', multiAddrCount);
    WriteLn;
  END;

BEGIN
  userInteraction;
END.
```

<div class="page-break" style="page-break-before: always;"></div>

### 2.3 Tests

| Eingabe                                                                                          | Beschreibung                                                             | Ausgabe                                   |
| ------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------ | ----------------------------------------- |
| ip3.txt                                                                                          | Standardfall<br>-- funktioniert, auch Speicher<br>ist wieder freigegeben | ![[Pasted image 20251210003016.png\|250]] |
| ip1.txt:<br>128.112.128.15<br>128.112.136.35<br>128.112.18.11<br>140.247.50.127<br>128.103.60.24 | keine Adresse kommt zweimal vor, IP-Adressen sind sortiert               | ![[Pasted image 20251210003239.png\|250]] |
| 10.0.0.2<br>10.0.0.1<br>10.00.00.01                                                              | führende Nullen werden ignoriert                                         | ![[Pasted image 20251210003346.png\|250]] |
| -                                                                                                | leere file                                                               | ![[Pasted image 20251210003432.png\|250]] |
| 199.106.69.11<br>128.36.229.30<br>66.94.234.13<br>128.36.229.30<br>128.36.229.30                 | Adressen kommen mehrmals vor,<br>nur Counter wird erhöht                 | ![[Pasted image 20251210003826.png\|250]] |
| 255.255.255.255                                                                                  | Grenzwert 255 und nur 1 Element                                          | ![[Pasted image 20251210004204.png\|250]] |

<div class="page-break" style="page-break-before: always;"></div>

## 3 Bibliotheksverwaltung

### 3.1 Lösungsidee
Die Idee besteht darin, verschachtelt in Listen sortiert einzufügen.
In der Prozedur InsertBook wird zunächst geprüft, ob die Bücherliste noch leer ist. Ist das der Fall, wird der erste Knoten erstellt und eingehängt. Ansonsten wird die Liste solange mit einem Hilfszeiger durchlaufen, bis der einzufügende Wert lexikographisch größer als der Datenwert des jeweiligen Knoten in der Liste ist. Je nachdem, auf welchen Knoten der Hilfszeiger jetzt zeigt, müssen verschiedene Fälle berücksichtigt werden. Im Allgemeinen Fall (Einfügen in der Mitte, Datenwert des Hilfszeigers ist nicht gleich der einzufügenden Daten) wird für den einzufügenden Buchtitel ein neuer Knoten erstellt und der Knoten wird vor dem Knoten, auf den der Hilfszeiger zeigt, eingefügt.
Beim Erstellen eines neuen Knoten in der Bücherliste, muss auch eine neue Liste für die Authoren des Buches erstellt werden. Dies geschieht mittels Aufruf einer dafür vorgesehenen Prozedur (SortedInsertAuth). Sie geht ähnlich vor wie die Hauptprozedur InsertBook: Wenn die übergebene Liste noch leer ist, wird ein neuer Knoten erstellt. Ansonsten wird die Liste solange durchlaufen, bis die Einfügeposition gefunden wurde. Wenn der Name des Authors in der Liste noch nicht existiert, wird er eingefügt.
Die Funktion NrOfBooksOf durchläuft die ganze Bücherliste. Wenn in einer zu einem Buch gehörenden Authorenliste der jeweilige Name gefunden wird (Funktionsaufruf inAuthorList()), wird eine Countervariable inkrimentiert. Die Funktion inAuthorList durchläuft dabei immer die übergebene Liste der Authoren. Wird der Author darin gefunden, ist der Rückgabewert True, ansonsten False.
Die Prozedur PrintAll durchläuft erneut die ganze Liste und darin immer (in einer eigenen Prozedur) die Liste der Authoren. In jedem Schleifendurchlauf wird der Datenwert einmal ausgegeben.
DisposeAll verwendet wieder eine ähnliche Logik.

<div class="page-break" style="page-break-before: always;"></div>

### 3.2 Quellcode

```pascal
PROGRAM Bibliotheksverwaltung;

  TYPE
    (*AuthorNode*)
    AuthorNodePtr = ^AuthorNode;
    AuthorNode = RECORD
      next: AuthorNodePtr;
      name: STRING;
    END;

    (*BookNodes*)
    BookNodePtr = ^BookNode;
    BookNode = RECORD
      prev, next: BookNodePtr;
      title: STRING;
      authors: AuthorNodePtr;
    END;
    BookListPtr = BookNodePtr;

  VAR (*nötig, weil die Schnittstelle InsertBook keinen Platz für einen Listenparameter hat*)
    pList: BookListPtr;
  
  PROCEDURE SortedInsertAuth(VAR auList: AuthorNodePtr; author: STRING);
    VAR
      NewNodePtr: AuthorNodePtr;
      curr, prev: AuthorNodePtr;
  BEGIN
    NewNodePtr := NIL;
    curr := auList;
    prev := NIL;

    IF (auList = NIL) THEN BEGIN
      New(NewNodePtr);
      auList := NewNodePtr;
      NewNodePtr^.next := NIL;
      NewNodePtr^.name := author;
    END ELSE BEGIN
      WHILE (curr <> NIL) AND (author > curr^.name) DO BEGIN
        prev := curr;
        curr := curr^.next;
      END; (*while*)
      
      IF (curr = NIL) THEN BEGIN (*hinten einfügen*)
          New(NewNodePtr);
          NewNodePtr^.next := NIL;
          NewNodePtr^.name := author;
          prev^.next := NewNodePtr;
      END ELSE      
        IF (author <> curr^.name) THEN BEGIN (*nichts tun wenn bereits drin*)
          IF (prev = NIL) THEN BEGIN (*Schleife nie betreten -- vorne einfügen*)
            New(NewNodePtr);
            NewNodePtr^.next := auList;
            auList := NewNodePtr;
            NewNodePtr^.name := author;
          END ELSE BEGIN (*irgendwo dazwischen einfügen (zwischen prev und curr)*)
            New(NewNodePtr);
            NewNodePtr^.name := author;
            NewNodePtr^.next := curr;
            prev^.next := NewNodePtr;
          END; (* fertig - eingefügt oder Author bereits in der Liste*)
        END; (*if (author <> curr^.name)*)
    END;
  END; (*procedure*)


  PROCEDURE InsertBook(title: STRING; author: STRING);
    VAR
      newBookPtr: BookNodePtr;
      curr: BookNodePtr;
  BEGIN
    (*init*)
    newBookPtr := NIL;
    curr := pList;

    IF (pList = NIL) THEN BEGIN
      New(newBookPtr);
      newBookPtr^.prev := NIL;
      newBookPtr^.next := NIL;
      newBookPtr^.title := title;
      newBookPtr^.authors := NIL;
      SortedInsertAuth(newBookPtr^.authors, author);

      pList := newBookPtr;
    END ELSE BEGIN
      (*Liste nach dem Wert durchsuchen*)
      WHILE (curr^.next <> NIL) AND (title > curr^.title) DO BEGIN
        curr := curr^.next;
      END;
      (* Möglichkeiten: Knoten enthalten oder nicht*)
      IF (curr <> NIL) AND (curr^.title = title) THEN BEGIN
        (*Knoten gibts - curr ist der Knoten*)
        SortedInsertAuth(curr^.authors, author);
      END ELSE BEGIN
        (*Knoten gibts noch nicht -> curr^.title > newBookPtr^.title*)
        New(newBookPtr);
        newBookPtr^.title := title;
        newBookPtr^.authors := NIL;
        SortedInsertAuth(newBookPtr^.authors, author);

        (*einhängen*)
        IF (curr^.title > title) THEN BEGIN (*vor curr einfügen*)
          newBookPtr^.prev := curr^.prev;
          newBookPtr^.next := curr;
          IF (curr^.prev = NIL) THEN BEGIN (*curr ist erster Knoten*)
            pList := newBookPtr;
          END ELSE BEGIN
            curr^.prev^.next := newBookPtr;
          END;
          curr^.prev := newBookPtr;
        END ELSE BEGIN (* curr^.title < title --> letztes Element, nach curr einfügen*)
          newBookPtr^.prev := curr;
          newBookPtr^.next := NIL;
          curr^.next := newBookPtr;        

        END;
      END; (*else*)
    END;
  END;

  FUNCTION inAuthorList(authorList: AuthorNodePtr; author: STRING): BOOLEAN;
    VAR
      curr: AuthorNodePtr;
      bResult: BOOLEAN;
  BEGIN
    bResult := FALSE;
    curr := authorList;
    WHILE (curr <> NIL) AND (author <> curr^.name) DO BEGIN
      curr := curr^.next;
    END; (*while*)

    IF (curr <> NIL) THEN BEGIN
      bResult := TRUE;
    END;

    inAuthorList := bResult;
  END;

  FUNCTION NrOfBooksOf(author: STRING): INTEGER;
    VAR
      curr: BookNodePtr;
      bookCount: INTEGER;
  BEGIN
    curr := pList;
    bookCount := 0;

    WHILE (curr <> NIL) DO BEGIN
      IF inAuthorList(curr^.authors, author) THEN BEGIN
        inc(bookCount);
      END;
      curr := curr^.next;
    END;

    NrOfBooksOf := bookCount;

  END;


  PROCEDURE PrintAuthors(aList: AuthorNodePtr);
    VAR
      curr: AuthorNodePtr;
  BEGIN
    curr := aList;
    WHILE (curr <> NIL) DO BEGIN
      WriteLn('  ', curr^.name);
      curr := curr^.next;
    END;
  END;


  PROCEDURE PrintAll;
   VAR
    curr: BookNodePtr;
  BEGIN
    curr := pList;
    WHILE (curr <> NIL) DO BEGIN
      WriteLn(curr^.title, ':');
      PrintAuthors(curr^.authors);
      curr := curr^.next;
    END;
  END;

  PROCEDURE DisposeAuthors(aList: AuthorNodePtr);
    VAR
      curr, prev: AuthorNodePtr;
  BEGIN
    curr := aList;
    prev := aList;
    WHILE (curr <> NIL) DO BEGIN
      prev := curr;
      curr := curr^.next;
      Dispose(prev);
    END;
  END;

  PROCEDURE DisposeAll;
    VAR
      curr: BookNodePtr;
      prev: BookNodePtr;
  BEGIN
    curr := pList;
    WHILE (curr <> NIL) DO BEGIN
      prev := curr;
      curr := curr^.next;
      DisposeAuthors(prev^.authors);
      Dispose(prev);
    END;
    pList := NIL;
  END;

  VAR
    title, author: STRING;
BEGIN
  pList := NIL;
  title := 'title';
  author := 'author';
  WHILE (length(title) > 0) AND (length(author) > 0) DO BEGIN
    Write('title (Enter to proceed) > ');
    ReadLn(title);
    IF (length(title) > 0) THEN BEGIN
      Write('author (Enter to proceed) > ');
      ReadLn(author);
      IF (length(author) > 0) THEN
        InsertBook(title, author);
    END;
  END;

  PrintAll;
  
  WriteLn;
  Write('The number of Books of which author do you want to print (Enter to exit) > ');
  ReadLn(author);
  IF (length(author) > 0) THEN BEGIN
    WriteLn('Nr. of Books written by ', author, NrOfBooksOf(author):2);
  END;

  DisposeAll;
END.
```
<div class="page-break" style="page-break-before: always;"></div>

### 3.3 Tests

| Beschreibung                                                            | Eingabe / Ausgabe                         |
| ----------------------------------------------------------------------- | ----------------------------------------- |
| Einfügen von 2 Authoren in ein Buch, selber Author in zwei Büchern      | ![[Pasted image 20251209235910.png\|450]] |
| Nichts eingegeben, kein Fehler                                          | ![[Pasted image 20251210000534.png\|450]] |
| Duplikat eingeben --> sollen nur einmal in der Liste aufgenommen werden | ![[Pasted image 20251210000638.png\|200]] |
| lex. Sortierung der Bücher                                              | ![[Pasted image 20251210000924.png\|250]] |
| lex. Sortierung der Authoren                                            | ![[Pasted image 20251210001126.png\|250]] |

