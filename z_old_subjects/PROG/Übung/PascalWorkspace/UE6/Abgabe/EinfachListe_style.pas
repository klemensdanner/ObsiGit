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