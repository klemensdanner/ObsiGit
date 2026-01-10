program WWWZugriffszahlen;

{ uses SysUtils;  <-- Nicht mehr benötigt }

const
  ip4max = 4;

type
  IPAddr = array[1..ip4max] of byte;
  IPAddrNodePtr = ^IPAddrNode;
  IPAddrNode = record
    next: IPAddrNodePtr;
    addr: IPAddr;
    count: integer; 
  end; 

function String2IPAddr(strAdress: string): IPAddr;
var
  i: integer;
  subCount: integer;
  subString: string;
  resultArr: IPAddr;
  { Neue Variablen für Val() }
  tempInt: integer;
  errCode: integer;
begin
  subString := '';
  subCount := 1;
  
  { WICHTIG: Ergebnis-Array initialisieren, damit keine Zufallswerte drin stehen }
  for i := 1 to ip4max do resultArr[i] := 0;

  for i := 1 to Length(strAdress) do begin
    if strAdress[i] in ['0'..'9'] then begin
      subString := subString + strAdress[i];
    end else begin
      { Wenn ein Punkt oder anderes Zeichen kommt: }
      if (subString <> '') and (subCount <= ip4max) then begin
        Val(subString, tempInt, errCode);
        if errCode = 0 then
          resultArr[subCount] := tempInt; { Integer in Byte konvertieren }
          
        inc(subCount);
        subString := ''; // Reset
      end;
    end;
  end; // for

  { Letzten Zahlblock verarbeiten (nach der Schleife) }
  if (subString <> '') and (subCount <= ip4max) then begin
    Val(subString, tempInt, errCode);
    if errCode = 0 then
      resultArr[subCount] := tempInt;
  end;

  String2IPAddr := resultArr;
end;

procedure PrintIP(addr: IPAddr);
var
  i: integer;
begin
  { Ich habe die Ausgabe leicht angepasst, damit es wie eine IP aussieht (z.B. 192.168...) }
  for i := 1 to ip4max do begin
    Write(addr[i]);
    if i < ip4max then Write(' '); 
  end;
  WriteLn; { Zeilenumbruch am Ende }
end;









var
  testArray: IPAddr;

begin
  testArray := String2IPAddr('192.168.150.200');
  
  Write('Geparsed: ');
  PrintIP(testArray);
  
  ReadLn; { Damit das Fenster offen bleibt }
end.