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