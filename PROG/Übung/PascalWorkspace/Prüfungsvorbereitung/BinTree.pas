program Trees;

  type
    TreePtr = ^Tree;
    Tree = record
      left, right: TreePtr;
      data: integer;
    end;
    TreeNodePtr = TreePtr;

  function MaxNodeValue(t: TreePtr): integer;
    var
      maxL, maxR, max: integer;
  begin
    if t = nil then begin
      MaxNodeValue := 0;
    end else begin
      maxL := MaxNodeValue(t^.left);
      maxR := MaxNodeValue(t^.right);

      if maxL > maxR then begin
        max := maxL;
      end else begin
        max := maxR;
      end;

      if max > t^.data then begin 
        MaxNodeValue := max;
      end else begin
        MaxNodeValue := t^.data;
      end;
    end;
  end;


  function MaxLeafValue(tree: TreePtr): integer;
    var
      leafValue: integer;
      max, lVal, rVal: integer;
  begin
    if tree = nil then begin
      MaxLeafValue := 0;
    end else begin
      if (tree^.left = nil) and (tree^.right = nil) then begin
        leafValue := tree^.data;
      end;

      lVal := MaxLeafValue(tree^.left);
      rVal := MaxLeafValue(tree^.right);

      if lVal > rVal then begin
        max := lVal;
      end else begin
        max := rVal;
      end;

      if max > leafValue then begin
        MaxLeafValue := max;
      end else begin
        MaxLeafValue := leafValue;
      end;
    end;
  end;


  // ----------Gemini -------------

  { Hilfsfunktion: Erstellt einen neuen Knoten }
function NeuerKnoten(wert: integer): TreePtr;
var
  k: TreePtr;
begin
  New(k);
  k^.data := wert;
  k^.left := nil;
  k^.right := nil;
  NeuerKnoten := k;
end;

{ Prozedur 1: Füllt einen Baum mit 3 Ebenen }
procedure FuelleBaum(var wurzel: TreePtr);
begin
  // Ebene 1 (Wurzel)
  wurzel := NeuerKnoten(50);

  // Ebene 2
  wurzel^.left := NeuerKnoten(30);
  wurzel^.right := NeuerKnoten(70);

  // Ebene 3 (Kinder von links)
  wurzel^.left^.left := NeuerKnoten(20);
  wurzel^.left^.right := NeuerKnoten(40);

  // Ebene 3 (Kinder von rechts)
  wurzel^.right^.left := NeuerKnoten(60);
  wurzel^.right^.right := NeuerKnoten(80);
end;

{ Prozedur 2: Gibt den Baum graphisch aus (liegend) }
{ 'p': Aktueller Knoten, 'ebene': Einrückungstiefe }
procedure ZeigeBaum(p: TreePtr; ebene: integer);
var
  i: integer;
const
  ABSTAND = 6; // Anzahl der Leerzeichen pro Ebene
begin
  if p = nil then
    exit;

  // 1. Erst den rechten Teilbaum rekursiv ausgeben (damit er oben erscheint)
  ZeigeBaum(p^.right, ebene + 1);

  // 2. Den aktuellen Knoten ausgeben
  Writeln; // Neue Zeile für Abstand
  for i := 1 to ebene * ABSTAND do
    Write(' '); // Einrückung basierend auf der Ebene
  
  Writeln(p^.data); // Wert drucken

  // 3. Dann den linken Teilbaum rekursiv ausgeben (damit er unten erscheint)
  ZeigeBaum(p^.left, ebene + 1);
end;

// Hauptprogramm zum Testen
var
  t: TreePtr;

begin
  t := nil;
  
  Writeln('Erstelle Baum mit 3 Ebenen...');
  FuelleBaum(t);
  
  Writeln('Baumstruktur (Wurzel links, Blätter rechts):');
  Writeln('--------------------------------------------');
  
  // Start mit Ebene 0
  ZeigeBaum(t, 0);


  WriteLn('MaxLeafValue > ', MaxLeafValue(t));
  
  Readln; // Warten auf Enter
end.