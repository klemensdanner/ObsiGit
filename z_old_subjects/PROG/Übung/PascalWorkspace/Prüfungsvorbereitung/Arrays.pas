program Arrays;

  const
    n = 10;

  type
    CharArray = array[1..n] of char;
    IntArray = array[1..n] of integer;

  procedure Shift(var a: IntArray; s: integer);
    var
      newIndex, i: integer;
      tmp: IntArray;
  begin
    i := 1;
    while i <= n do begin
      newIndex := i + s;
      if newIndex > n then begin
        newIndex := newIndex - n;
      end;
      tmp[newIndex] := a[i];
      inc(i);
    end;
    a := tmp;
  end;

  procedure Trim(var a: CharArray; var len: integer);
    var
      i, lastValidPos, leadingZeros: integer;
  begin
    lastValidPos := 0;
    leadingZeros := 0;
    i := 1;

    while i <= length(a) do begin
      if (lastValidPos = 0) and (a[i] = '0') then begin
        inc(leadingZeros);
        inc(i);
      end else begin
        if a[i] <> '0' then begin
          lastValidPos := i;
        end;
        // jetzt um leadingZeros verschieben
        a[i - leadingZeros] := a[i];
        inc(i);
      end;
    end;
    if lastValidPos = 0 then begin
      len := 0;
    end else begin
      len := lastValidPos - leadingZeros;
    end;
   end;

  procedure ReadIntArray(var a: IntArray);
    var
      val, i: integer;

  begin
    i := 1;
    val := -1;
    while (i <= length(a)) and (val <> 0) do begin
      Write(' > ');
      ReadLn(val);
      if val <> 0 then begin
        a[i] := val;
        inc(i);
      end;
    end;
  end;

  procedure WriteIntArray(a: IntArray);
    var
      i: integer;
  begin
    Write('[ ');
    for i := 1 to length(a) do begin
      Write(a[i]:3);
    end;
    Write(' ]');
  end;

  //-----------------gemini

  procedure GenerateTestCase(var a: CharArray);
var
  i, startPos, endPos, lenCore: integer;
  hasDot: boolean;
begin
  // 1. Initialisierung: Alles mit '0' füllen
  // Das erzeugt automatisch die führenden und nachfolgenden Nullen.
  for i := 1 to n do
    a[i] := '0';

  // 2. Zufälligen Bereich für die "echte" Zahl bestimmen
  // Wir lassen vorne und hinten mind. 1 Platz frei für die Nullen
  // Beispiel für n=10: Start zwischen Index 2 und 4
  startPos := 2 + Random(n div 4); 
  
  // Ende irgendwo vor dem Array-Ende
  endPos := n - (1 + Random(n div 4));

  // Falls durch Zufall Start > Ende, korrigieren wir das (Zahl ist mind. 1 Zeichen lang)
  if startPos > endPos then endPos := startPos;

  // 3. Den Bereich mit Ziffern und max. einem Punkt füllen
  hasDot := false;
  
  for i := startPos to endPos do
  begin
    // Entscheidung: Punkt oder Ziffer? (Punkt nur einmal erlaubt)
    // Wir setzen keinen Punkt an die erste oder letzte Stelle der Zahl
    if (not hasDot) and (i > startPos) and (i < endPos) and (Random(5) = 0) then
    begin
      a[i] := '.';
      hasDot := true;
    end
    else
    begin
      // Zufallsziffer 0-9
      a[i] := Chr(Ord('0') + Random(10));
    end;
  end;

  // 4. WICHTIG für den Test: Ränder fixieren
  // Damit wir sicher wissen, wo die Zahl anfängt und aufhört,
  // setzen wir die erste und letzte Ziffer des Bereichs hart auf ungleich '0'.
  // Sonst wäre "001200" für uns schwer von "001200" (mit nachgestellter 0) zu unterscheiden.
  
  if a[startPos] = '0' then a[startPos] := Chr(Ord('1') + Random(9)); // 1..9
  if a[endPos]   = '0' then a[endPos]   := Chr(Ord('1') + Random(9)); // 1..9
  
  // (Optional) Wenn ein Punkt am Ende stand durch Zufall, überschreiben wir ihn
  if a[endPos] = '.' then a[endPos] := '5';
end;

//---------------gemini

  procedure WriteCharArray(a: CharArray; len: integer);
    var
      i: integer;
  begin
    for i := 1 to len do
      Write(a[i]:3);
    WriteLn;
  end;

  function Unique(var a: IntArray): integer;
    var
      i, j, len: integer;
  begin
    i := 2;
    len := n;
    while i <= len do begin
      if a[i] = a[i - 1] then begin
        for j := i to len do begin
          a[j - 1] := a[j];
        end;
        dec(len);
      end else begin
        inc(i);
      end;
    end;
    //Unique := len;
    WriteLn('len > ', len);
  end;

  procedure CountLauf(a: IntArray; n: integer; var l: integer);
    var
      counter, i, max: integer;
  begin
    if n = 0 then begin // leeres array
      l := 0;
      Exit;
    end;

    counter := 1; 
    max := 1;
    for i := 1 to n - 1 do begin
      if a[i] < a[i + 1] then begin
        inc(counter);
      end else begin
        if counter > max then begin
          max := counter;
        end;
        counter := 1;
      end;

    end;

    if counter > max then begin
      max := counter;
    end;
    l := max;
  end;


  var
    //TestArray: CharArray;
    //len: integer;
    a: IntArray;
    l: integer;


begin
  ReadIntArray(a);
  WriteIntArray(a); WriteLn;


  l := -1;
  CountLauf(a, n, l);
  WriteLn('laengster Lauf > ', l);

  Shift(a, 3);
  WriteIntArray(a); WriteLn;

  //Unique(a);
  //WriteIntArray(a);

  //WriteLn('len > ', Unique(a));
  //WriteIntArray(a);






  //Randomize;
  {GenerateTestCase(TestArray);
  WriteCharArray(TestArray, n);

  Trim(TestArray, len);

  WriteCharArray(TestArray, len);}

end.