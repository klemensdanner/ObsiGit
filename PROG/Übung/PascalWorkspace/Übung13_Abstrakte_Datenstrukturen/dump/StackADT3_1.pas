unit StackADT3_1;

interface

// const maxElements = 100; // Entfernt, da Größe nun dynamisch

type
  Stack = ^StackRec;

  StackRec = record
    top: integer;
    data: array of integer; // ÄNDERUNG: Jetzt ein dynamisches Array
    maxElements: integer;   // Behält die Größe, die bei NewStack gesetzt wird
  end;

// NewStack benötigt nun einen Parameter für die Größe
procedure NewStack(var s: Stack; size: integer);
procedure DisposeStack(var s: Stack);
procedure Push(s: Stack; e: integer);
procedure Pop(s: Stack; var e: integer);

function Empty(s: Stack): boolean;
function Full(s: Stack): boolean;

implementation

procedure NewStack(var s: Stack; size: integer);
begin
  New(s);
  // Speicher für das dynamische Array reservieren
  SetLength(s^.data, size);
  
  // Die Größe im Feld 'maxElements' speichern
  s^.maxElements := size;
  
  // WICHTIG: Dynamische Arrays beginnen bei Index 0.
  // Damit 'inc(top)' beim ersten Push auf 0 landet, starten wir bei -1.
  s^.top := -1; 
end;

procedure DisposeStack(var s: Stack);
begin
  if s <> nil then begin
    // Speicher des Arrays freigeben
    SetLength(s^.data, 0);
    Dispose(s);
    s := nil;
  end;
end;

function Empty(s: Stack): boolean;
begin
  // Da wir bei -1 starten, ist der Stack leer, wenn top -1 ist
  Empty := (s^.top = -1);
end;

function Full(s: Stack): boolean;
begin
  // Das Array geht von 0 bis maxElements-1.
  // Wenn top bei maxElements-1 angekommen ist, ist der Stack voll.
  Full := (s^.top = s^.maxElements - 1);
end;

procedure Push(s: Stack; e: integer);
begin
  if Full(s) then begin
    WriteLn('Stack overflow');
  end else begin
    // Logik bleibt gleich: Erst erhöhen (-1 -> 0), dann schreiben
    inc(s^.top);
    s^.data[s^.top] := e;
  end;
end;

procedure Pop(s: Stack; var e: integer);
begin
  if Empty(s) then begin
    WriteLn('Stack underflow');
  end else begin
    // Logik bleibt gleich: Erst lesen, dann verringern
    e := s^.data[s^.top];
    dec(s^.top);
  end;
end;

end.