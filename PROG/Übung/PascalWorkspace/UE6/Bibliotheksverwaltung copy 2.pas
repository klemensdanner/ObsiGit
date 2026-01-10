program Bibliotheksverwaltung;

  TYPE
    //AuthorNode
    AuthorNodePtr = ^AuthorNode;
    AuthorNode = record
      next: AuthorNodePtr;
      name: string;
    end;

    //BookNodes
    BookNodePtr = ^BookNode;
    BookNode = record
      prev, next: BookNodePtr;
      title: string;
      authors: AuthorNodePtr;
    end;
    BookListPtr = BookNodePtr;

  var //nötig, weil die Schnittstelle InsertBook keinen Platz für einen Listenparameter hat
    pList: BookListPtr;
  
  procedure SortedInsertAuth(VAR auList: AuthorNodePtr, author: string);
    var
      NewNodePtr: AuthorNodePtr;
      curr, prev: AuthorNodePtr;
  begin
    NewNodePtr := NIL;
    curr := auList;
    prev := auList;

    if (auList = NIL) then begin
      New(NewNodePtr);
      auList := NewNodePtr;
      NewNodePtr^.next := nil;
      NewNodePtr^.name := author;
    end else begin
      while (curr <> NIL) and (author > curr^.name) do begin
        prev := curr;
        curr := curr^.next;
      end; //while
      
      if (curr = nil) then begin //hinten einfügen
        New(NewNodePtr);
        NewNodePtr^.next := nil;
        NewNodePtr^.name := author;
        prev^.next := NewNodePtr;
      end else
        if (author <> curr^.name) then begin //nichts tun wenn bereits hier
          











  end; //procedure


  procedure InsertBook(title: string; author: string);
    var
      newBookPtr: BookNodePtr;
      curr: BookNodePtr;
  begin
    //init
    newBookPtr := nil;
    curr := pList;

    if (pList = nil) then begin
      New(newBookPtr);
      newBookPtr^.prev := NIL;
      newBookPtr^.next := NIL;
      newBookPtr^.title := title;
      newBookPtr^.authors := NIL;
      SortedInsertAuth(newBookPtr^.authors, author);

      pList := newBookPtr;
    end else begin
      //Liste nach dem Wert durchsuchen
      while (curr^.next <> nil) AND (title > curr^.title) do begin
        curr := curr^.next;
      end;
      // Möglichkeiten: Knoten enthalten oder nicht
      if (curr <> nil) and (curr^.title = title) then begin
        //Knoten gibts - curr ist der Knoten
        SortedInsertAuth(curr^.authors, author);
      end else begin
        //Knoten gibts noch nicht -> curr^.title > newBookPtr^.title
        New(newBookPtr);
        newBookPtr^.title := title;
        newBookPtr^.authors := NIL;
        SortedInsertAuth(newBookPtr^.authors, author);

        //einhängen
        if (curr^.title > title) then begin //vor curr einfügen
          newBookPtr^.prev := curr^.prev;
          newBookPtr^.next := curr;
          if (curr^.prev = nil) then begin //curr ist erster Knoten
            pList := newBookPtr;
          end else begin
            curr^.prev^.next := newBookPtr;
          end;
          curr^.prev := newBookPtr;
        end else begin // curr^.title < title --> letztes Element, nach curr einfügen
          newBookPtr^.prev := curr;
          newBookPtr^.next := nil;
          curr^.next := newBookPtr;        

        end;
      end; //else
  end;