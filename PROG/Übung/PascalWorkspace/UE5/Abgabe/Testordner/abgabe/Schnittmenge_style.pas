PROGRAM Schnittmenge;

  CONST
    max = 100;

  TYPE
    IntArray = ARRAY[1..max] OF INTEGER;

  PROCEDURE ReadArray(VAR a: ARRAY OF INTEGER; n: INTEGER);
    VAR
      i: INTEGER;

  BEGIN
    FOR i := 0 TO (n-1) DO
      Read(a[i]);
  END;

  PROCEDURE WriteArray(a: ARRAY OF INTEGER; n: INTEGER);
    VAR
      i: INTEGER;
  BEGIN
    FOR i := 0 TO (n-1) DO
      Write(a[i]:3);
  END;

  FUNCTION IsSorted(a: ARRAY OF INTEGER; n: INTEGER): BOOLEAN;
    VAR
      i: INTEGER;
      sorted: BOOLEAN;

  BEGIN
    i := 0; (*OpenArray-Init*)
    sorted := TRUE;
    WHILE sorted AND (i <= (n-2)) DO BEGIN (*Zugriff auf i+1 & open-array*)
      IF a[i] > a[i+1] THEN
        sorted := FALSE;
      i := i + 1;
    END; (*end while*)
    IsSorted := sorted;
  END;

  PROCEDURE Intersect(a1: ARRAY OF INTEGER; n1: INTEGER; a2: ARRAY OF INTEGER; n2: INTEGER; VAR a3: ARRAY OF INTEGER; VAR n3: INTEGER);
    VAR
      a3max, i, j: INTEGER;
  BEGIN
    (*Eingangskriterien prüfen*)
    IF (NOT IsSorted(a1, n1)) OR (NOT IsSorted(a2, n2)) THEN BEGIN
      n3 := -1;
      Exit;
    END;
    
    a3max := high(a3);
    i := 0;
    j := 0; (*open-array-init*)
    n3 := 0; (*init*)

    WHILE (i <= (n1 - 1)) AND (j <= (n2 - 1)) DO BEGIN   
      IF (a1[i] = a2[j]) THEN BEGIN
        IF n3 <= a3max THEN BEGIN
          a3[n3] := a1[i];
          i := i + 1;
          j := j + 1;
          n3 := n3 + 1;
        END ELSE BEGIN   
          n3 := -1;
          Exit; (*Überlauf*)
        END
      END ELSE
        IF (a1[i] < a2[j]) THEN
          i := i + 1
        ELSE
          j := j + 1;
    END; (*WHILE*)
  END;

  VAR
    a1, a2, a3: IntArray;
    n1, n2, n3 : INTEGER;


BEGIN
  Write('n1 > ');
  Read(n1);

  Write('Enter ', n1, ' values > ');
  ReadArray(a1, n1);
  WriteArray(a1, n1);
  WriteLn;

  Write('n2 > ');
  Read(n2);

  Write('Enter ', n2, ' values > ');
  ReadArray(a2,n2);
  WriteArray(a2,n2); WriteLn;

  Intersect(a1, n1, a2, n2, a3, n3);
  
  IF (n3 = -1) THEN
    WriteLn('An Error occured: input arrays not sorted or overflow')
  ELSE BEGIN
    WriteLn('Those numbers are in both arrays: ');
    WriteArray(a3, n3);
    WriteLn;
  END; (*IF*)

END.
