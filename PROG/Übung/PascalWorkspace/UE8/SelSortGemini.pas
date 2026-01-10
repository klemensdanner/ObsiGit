program GemiSort;

procedure SelectionSort(VAR list: ListPtr);
    var
      pt: ListNodePtr; // Zeigt auf das letzte SORTIERTE Element
      ptB: ListNodePtr; // Zeigt auf den Parent des kleinsten Elements im unsortierten Teil
      
      // Variablen für den ersten Tausch (Head)
      a, b, childOfB: ListNodePtr;
  begin
    if (list = nil) or (list^.next = nil) then begin
       WriteLn('List is empty or has only one node.');
       Exit;
    end;

    // --- SONDERFALL: Erstes Element (Head) sortieren ---
    // Da das erste Element keinen "Parent" hat, müssen wir list direkt ändern.
    ptB := SmallestNodePt(list);
    
    if ptB <> nil then begin
      // Wir haben ein kleineres Element gefunden -> Tauschen
      b := ptB^.next;       // Das kleinste Element
      childOfB := b^.next;  // Nachfolger vom Kleinsten
      a := list;            // Der aktuelle Kopf (der weggetauscht wird)

      // 1. Kleinstes Element wird neuer Kopf
      b^.next := list^.next; 
      list := b;
      
      // 2. Das alte Kopfelement (a) kommt an die alte Stelle von b
      ptB^.next := a;
      a^.next := childOfB;
    end;

    // --- HAUPTSCHLEIFE: Ab dem 2. Element ---
    // pt zeigt immer auf den Knoten VOR der Stelle, die wir gerade sortieren.
    // Zu Beginn ist list (der neue Head) sortiert, also ist pt = list.
    
    pt := list;

    // Solange es noch mindestens zwei Elemente nach pt gibt (eines zum Prüfen, eines zum Tauschen)
    while (pt^.next <> nil) and (pt^.next^.next <> nil) do begin
      
      // Suche im Rest der Liste (ab pt^.next) nach dem Parent des Kleinsten
      ptB := SmallestNodePt(pt^.next);

      if ptB <> nil then begin
        // Ein Kleineres wurde gefunden -> Tauschen
        // ptB ist der Parent vom Kleinsten. pt ist der Parent von unserer aktuellen Position.
        SwapChildNodes(ptB, pt);
      end;

      // Egal ob getauscht wurde oder nicht: Die Position pt^.next ist jetzt fertig sortiert.
      // Wir rücken den "Grenzzaun" eins weiter.
      pt := pt^.next;
    end;
  end;