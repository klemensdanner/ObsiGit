





  procedure DisposeList(var list: ListPtr);
    var
      sList: ListNodePtr;
      prev: ListNodePtr;
  begin
    sList := list;
    prev := list;
    //Eingangsbedingung prüfen
    if (list <> nil) then begin
      while (sList^.next <> NIL) do begin
        prev := sList;
        sList := sList^.next;
        Dispose(prev);
      end; // while
      
      //jetzt nur mehr letzter Knoten (sList^.next ist jetzt NIL)
      Dispose(sList);
      list := NIL;
    end; (*if*)
  end;











(*-------------------------------functions  by gemini --------------*)


procedure AddNode(VAR list: ListPtr; value: integer);
var
  newNode: ListNodePtr;
begin
  New(newNode);
  newNode^.data := value;
  newNode^.next := list;
  list := newNode;
end;

// Gibt die Liste auf der Konsole aus
procedure PrintList(list: ListPtr);
var
  curr: ListNodePtr;
begin
  curr := list;
  Write('[');
  while (curr <> NIL) do begin
    Write(curr^.data);
    if (curr^.next <> NIL) then Write(', ');
    curr := curr^.next;
  end;
  WriteLn(']');
end;

// Hilfsprozedur, um einen Testfall sauber auszuführen
procedure RunTest(testName: String; values: Array of Integer);
var
  myList: ListPtr;
  removedNode: ListNodePtr;
  i: Integer;
begin
  myList := NIL;
  removedNode := NIL;

  // Liste aufbauen (Rückwärts einfügen, damit Reihenfolge stimmt wie im Array)
  for i := High(values) downto Low(values) do begin
    AddNode(myList, values[i]);
  end;

  WriteLn('--- ', testName, ' ---');
  Write('Vorher:   ');
  PrintList(myList);

  RemoveMax(myList, removedNode);

  Write('Nachher:  ');
  PrintList(myList);
  
  if removedNode <> NIL then begin
    WriteLn('Gelöscht: ', removedNode^.data);
    Dispose(removedNode); // Speicher aufräumen
  end else begin
    WriteLn('Gelöscht: NIL');
  end;
  WriteLn;
end;

{ --- HAUPTPROGRAMM --- }
begin
  // Test 1: Max in der Mitte
  // Erwartet: 50 wird gelöscht
  RunTest('Test 1: Max in der Mitte', [10, 50, 20]);

  // Test 2: Max am Anfang
  // Erwartet: 99 wird gelöscht
  RunTest('Test 2: Max am Anfang', [99, 10, 20]);

  // Test 3: Max am Ende
  // Erwartet: 80 wird gelöscht
  RunTest('Test 3: Max am Ende', [10, 20, 80]);

  // Test 4: Liste mit einem Element
  // Erwartet: Liste wird leer
  RunTest('Test 4: Nur ein Element', [5]);

  // Test 5: Leere Liste
  // Erwartet: Keine Änderung, NIL zurück
  RunTest('Test 5: Leere Liste', []);

  // Test 6: Duplikate (zwei mal Max)
  // Erwartet: Das ERSTE 50 wird gelöscht (lt. Angabe), Liste wird 20 -> 50
  RunTest('Test 6: Doppeltes Max', [20, 50, 50]);
  
  WriteLn('Druecke Enter zum Beenden...');
  ReadLn;
end.