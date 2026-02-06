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
    WriteLn('Nr. of Books written by ', author, ':', NrOfBooksOf(author):2);
  END;
  WriteLn;

  DisposeAll;
END.