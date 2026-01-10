program SinglyLinkedList;

type
  ListNodePtr = ^ListNode;
  ListNode = record
    next: ListNodePtr;
    data: integer;
  end;
  ListPtr = ListNodePtr;

  procedure AddNode(var list: ListPtr; val: integer);
    var
      newNode: ListNodePtr;
      last: ListNodePtr;
  begin
      New(newNode);
      newNode^.data := val;
      newNode^.next := NIL; //Wert wird hinten angefügt

      //Liste leer
      if (list = nil) then
        list := newNode
      else begin
        last := list;
        //Liste nicht leer
        while (last^.next <> nil) do begin
          last := last^.next;
        end;
        //jetzt ist last^.next = nil. Also Fügen wir dort Knoten ein
        last^.next := newNode;
      end;
  end;

  procedure ReadList(var list: ListPtr);
    var
      val: integer;
  begin
    WriteLn('Enter some int values for your list (end with 0): ');
    Write('> '); ReadLn(val);
    while (val <> 0) do begin
      AddNode(list, val);
      Write('> '); ReadLn(val);
    end;

  end;

  procedure DisposeList(var list: ListPtr);
    var
      tmpList: ListNodePtr;

    begin
      while (list <> nil) do begin
        tmpList := list;
        list := list^.next;
        Dispose(tmpList);
      end;
    end;

  procedure WriteList(list: ListPtr);
  begin
    Write('[');
    while (list <> nil) do begin
      Write(list^.data:3);
      list := list^.next;
    end; //while
    Write('  ]');
    WriteLn;


  end;

  procedure RemoveMax(VAR list: ListPtr; VAR maxNode: ListNodePtr);
    var
      curr: ListNodePtr;
      maxNodePtr: ListNodePtr;
      prev: ListNodePtr;
      prevMaxNodePtr: ListNodePtr;
  begin
    //emty list
    if (list = NIL) then begin
      maxNode := NIL;
      Exit;
    end;

    //not emty list
    prev := NIL;
    curr := list;
    maxNodePtr := curr; // init für den Fall, dass die while Schleife übersprungen wird weil nur ein Element drin ist
    prevMaxNodePtr := NIL;
    while (curr <> NIL) do begin
      if (curr^.data > maxNodePtr^.data) then begin
        maxNodePtr := curr;
        prevMaxNodePtr := prev;
      end; // if
      
      prev := curr;
      curr := curr^.next;
    end; //while
    //jetzt: maxnodePtr ist der ptr zum node mit dem höchsten datenwert
    //jetzt muss dieser node gelöscht werden
    
    //Fall 1: 1. wert ist größter Wert (zu verändernder Wert ist im Compound einer Node sondern in der Startvariable list)
    if prevMaxNodePtr = NIL then begin //Bedingung in der while Schleife nie erflüllt
      list := list^.next;
    end else begin
      prevMaxNodePtr^.next := maxNodePtr^.next; // "Aushängen" des größten Wertes. Hier könnte man disposen, aber weil die Adresse zurückgegeben wird, dispose ich nicht, damit man noch was damit machen kann
    end; //if
    maxNode := maxNodePtr; //Zuweisen vom Rückgabewert
  end;

  var
    l: ListPtr;
    maxValPtr: ListNodePtr;
begin
  ReadList(l);
  WriteLn('list entered: ');
  WriteList(l);
  WriteLn('max val removed:');
  RemoveMax(l, maxValPtr);
  WriteList(l);
  WriteLn('Value removed: ', maxValPtr^.data);
  Dispose(maxValPtr);
  DisposeList(l);
end.