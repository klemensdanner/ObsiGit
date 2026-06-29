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
  
  procedure SortedInsertAuth(VAR auList: AuthorNodePtr; author: string);
    var
      NewNodePtr: AuthorNodePtr;
      curr, prev: AuthorNodePtr;
  begin
    NewNodePtr := NIL;
    curr := auList;
    prev := NIL;

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
        if (author <> curr^.name) then begin //nichts tun wenn bereits drin
          if (prev = NIL) then begin //Schleife nie betreten -- vorne einfügen
            New(NewNodePtr);
            NewNodePtr^.next := auList;
            auList := NewNodePtr;
            NewNodePtr^.name := author;
          end else begin //irgendwo dazwischen einfügen (zwischen prev und curr)
            New(NewNodePtr);
            NewNodePtr^.name := author;
            NewNodePtr^.next := curr;
            prev^.next := NewNodePtr;
          end; // fertig - eingefügt oder Author bereits in der Liste
        end; //if (author <> curr^.name)
    end;
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
  end;



  function inAuthorList(authorList: AuthorNodePtr; author: string): boolean;
    var
      curr: AuthorNodePtr;
      bResult: boolean;
  begin
    bResult := false;
    curr := authorList;
    while (curr <> nil) and (author <> curr^.name) do begin
      curr := curr^.next;
    end; //while

    if (curr <> nil) then begin
      bResult := true;
    end;

    inAuthorList := bResult;
  end;

  function NrOfBooksOf(author: string): integer;
    var
      curr: BookNodePtr;
      bookCount: integer;
  begin
    curr := pList;
    bookCount := 0;

    while (curr <> nil) do begin
      if inAuthorList(curr^.authors, author) then begin
        inc(bookCount);
      end;
      curr := curr^.next;
    end;

    NrOfBooksOf := bookCount;

  end;


  procedure PrintAuthors(aList: AuthorNodePtr);
    var
      curr: AuthorNodePtr;
  begin
    curr := aList;
    while (curr <> NIL) do begin
      WriteLn('  ', curr^.name);
      curr := curr^.next;
    end;
  end;


  procedure PrintAll;
   var
    curr: BookNodePtr;
  begin
    curr := pList;
    while (curr <> nil) do begin
      WriteLn(curr^.title, ':');
      PrintAuthors(curr^.authors);
      curr := curr^.next;
    end;
  end;

  procedure DisposeAuthors(aList: AuthorNodePtr);
    var
      curr, prev: AuthorNodePtr;
  begin
    curr := aList;
    prev := aList;
    while (curr <> nil) do begin
      prev := curr;
      curr := curr^.next;
      Dispose(prev);
    end;
  end;

  procedure DisposeAll;
    var
      curr: BookNodePtr;
      prev: BookNodePtr;
  begin
    curr := pList;
    while (curr <> nil) do begin
      prev := curr;
      curr := curr^.next;
      DisposeAuthors(prev^.authors);
      Dispose(prev);
    end;
    pList := NIL;
  end;

  var
    title, author: string;
begin
  pList := NIL;
  title := 'title';
  author := 'author';
  while (length(title) > 0) and (length(author) > 0) do begin
    Write('title (Enter to proceed) > ');
    ReadLn(title);
    if (length(title) > 0) then begin
      Write('author (Enter to proceed) > ');
      ReadLn(author);
      if (length(author) > 0) then
        InsertBook(title, author);
    end;
  end;

  PrintAll;
  
  WriteLn;
  Write('The number of Books of which author do you want to print (Enter to exit) > ');
  ReadLn(author);
  If (length(author) > 0) then begin
    WriteLn('Nr. of Books written by ', author, NrOfBooksOf(author):2);
  end;

  DisposeAll;
end.