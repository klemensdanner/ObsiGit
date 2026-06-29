program WWWZugriffszahlen;

  const
    ip4max = 4;
  
  type
    IPAddr = array[1..ip4max] of byte;
    IPAddrNodePtr = ^IPAddrNode;
    IPAddrNode = record
      next: IPAddrNodePtr;
      addr: IPAddr;
      count: integer; //number of accesses
    end; //record
    IPAddrListPtr = IPAddrNodePtr;


  function IPGreaterThan(ip1, ip2: IPAddr): boolean;
    var
      i: integer;
      bEqualValues: boolean;
      bResult: boolean;
  begin
    i := 1;
    bEqualValues := true;
    while (i <= high(ip1)) AND (i <= high(ip2)) AND bEqualValues do begin
      bResult := (ip1[i] > ip2[i]);
      bEqualValues := (ip1[i] = ip2[i]);
      inc(i);
    end;
    IPGreaterThan := bResult;
  end;

  function IPsEqual(ip1, ip2: IPAddr): boolean;
  var
    bResult: boolean;
    i: integer;
  begin
    i := 1;
    bResult := true;
    while (i <= high(ip1)) AND (i <= high(ip2)) AND bResult do begin
      bResult := ip1[i] = ip2[i];
      inc(i);
    end;
      IPsEqual := bResult;    
  end;


  function String2IPAddr(strAdress: string): IPAddr;
    var
      i: integer;
      subCount: integer;
      subString: string;
      resultArr: IPAddr;

      //vars for val procedure
      nStringVal: integer;
      errCode: word;
  begin
    subString := '';
    subCount := 1;

    nStringVal := 0;
    errCode:= 0;
    for i := 1 to Length(strAdress) do begin
      if strAdress[i] in ['0'..'9'] then begin
        subString := subString + strAdress[i];
      end else begin
        val(subString, nStringVal, errCode);
        resultArr[subCount] := nStringVal;
        
        inc(subCount);
        subString := ''; //reset
      end;
    end; //for
    if (subString <> '') then begin
      val(subString, nStringVal, errCode);
      resultArr[subCount] := nStringVal;
    end;
    String2IPAddr := resultArr;
  end;

  procedure PrintIP(addr: IPAddr);
    var
      i: integer;
  begin
    for i := 1 to high(addr) do
      WriteLn(addr[i]:3);
  end;


  //procedure SortedInsert() und Insert besser in einer Funktion, damit die Liste nicht mehrmals durchlaufen wird

  procedure SortedInsert(VAR list: IPAddrListPtr; adress: IPAddr);
    var
      pNewNode: IPAddrNodePtr;
      curr: IPAddrNodePtr;
      prev: IPAddrNodePtr;
  
  begin
    New(pNewNode);
    pNewNode^.addr := adress;
    pNewNode^.next := nil;
    pNewNode^.count := 1;
    
    curr := list; //init
    prev := list;
    

    if (list = nil) then begin
      list := pNewNode;
      Exit; //list empty
    end; //if

    while (curr <> nil) AND IPGreaterThan(pNewNode^.addr, curr^.addr) do begin
      prev := curr;
      curr := curr^.next;
    end;
    //Möglichkeiten: curr = Nil --> Knoten hinten einfügen - prev^.next := n
    // oder: curr <> nil --> Einfügeposition gefunden, dann ist not(pNewNode^.addr > curr^.addr), also (pNewNode^.adress <= curr^.addr)
    //Eingefügt werden muss zwischen prev und curr
    if (curr <> nil) AND IPsEqual(pNewNode^.addr, curr^.addr) then begin //wenn gleich, counter erhöhen, Neue Node wieder disposen
      inc(curr^.count);
      Dispose(pNewNode);
    end else begin
      if (curr = NIL) then begin //hinten einfügen
        prev^.next := pNewNode;
      end else
        if (curr = list) then begin
          pNewNode^.next := list;
          list := pNewNode;
      end else begin // curr <> nil
        pNewNode^.next := prev^.next; //Adr von curr
        prev^.next := pNewNode; //fertig eingehängt
      end; //if
    end; //if
  end;

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

  procedure userInteraction;
    var
      strIP: string;
      arrIPAddr: IPAddr;
      list: IPAddrListPtr;
      multiAddrCount: integer;
      
      //zum Liste iterieren:
      curr: IPAddrNodePtr;
  begin
    list := nil; //init
    while not eof do begin
      ReadLn(strIP);
      arrIPAddr := String2IPAddr(strIP);
      SortedInsert(list, arrIPAddr);
    end;

    //Liste iterieren
    multiAddrCount := 0;
    curr := list;
    while (curr <> nil) do begin
      if (curr^.count > 1) then
        inc(multiAddrCount);
      curr := curr^.next;
    end; //while   

    DisposeList(list);
    list := nil;
    WriteLn('Number of Adresses with more than 1 access: ', multiAddrCount);
  end;

begin
  userInteraction;
end.