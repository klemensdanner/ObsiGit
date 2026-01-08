(* Unit for Coffee Machine:                                   DA, 2025-11-22 *)
(* ------                                                                    *)
(* implements a Unit for controlling a coffee machine                        *)
(* ========================================================================= *)

UNIT Kaffeeautomat_unit;

INTERFACE
  type
    Coins = record
      cent10: integer;
      cent50: integer;
      cent100: integer;
  end;

  procedure ReadCoins(VAR c: Coins);
  procedure WriteCoins(c: Coins);

  procedure CoffeeButtonPressed(input: Coins; VAR change: Coins);

IMPLEMENTATION

  var
    totalCoins: Coins;
    noChangeCounter: integer;

  procedure ReadCoins(VAR c: Coins);
  begin
    Write('10 cent coins > '); ReadLn(c.cent10);
    Write('50 cent coins > '); ReadLn(c.cent50);
    Write('100 cent coins > '); ReadLn(c.cent100);
  end;

  procedure WriteCoins(c: Coins);
  begin
    WriteLn('10 cent coins > ', c.cent10);
    WriteLn('50 cent coins > ', c.cent50);
    WriteLn('100 cent coins > ', c.cent100);
  end;

  function AddCoins(a, b: Coins): Coins;
    begin
      AddCoins.cent10 := a.cent10 + b.cent10;
      AddCoins.cent50 := a.cent50 + b.cent50;
      AddCoins.cent100 := a.cent100 + b.cent100;
    end;

  function SubtractCoins(a, b: Coins): Coins;
  begin
    SubtractCoins.cent10 := a.cent10 - b.cent10;
    SubtractCoins.cent50 := a.cent50 - b.cent50;
    SubtractCoins.cent100 := a.cent100 - b.cent100;
  end;

  

  function TotalValue(c: Coins): integer;
  begin
    TotalValue := c.cent10*10 + c.cent50*50 + c.cent100*100;
  end;

  function CalcChange(c: Coins; VAR error: boolean): Coins;
    var
      change: Coins;
      ValueOfChange: integer;
  
  begin

    change.cent100 := 0; //init
    change.cent50 := 0;
    change.cent10 := 0;

    totalCoins := AddCoins(totalCoins, c); //Eingabe zu Totalcoins addieren, zum Stand aktualisieren

    ValueOfChange := TotalValue(c)-40; //Kaffeepreis

    change.cent100 := change.cent100 + (ValueOfChange div 100);
    ValueOfChange := ValueOfChange mod 100; //Rest für die anderen Münzen
    while change.cent100 > totalCoins.cent100 do begin
      dec(change.cent100);
      change.cent50 := change.cent50 + 2;
    end; (*while*)

    change.cent50 := change.cent50 + (ValueOfChange div 50);
    ValueOfChange := ValueOfChange mod 50; //Rest
    while change.cent50 > totalCoins.cent50 do begin
      dec(change.cent50);
      change.cent10 := change.cent10 + 5;
    end; (*while*)

    change.cent10 := change.cent10 + (ValueOfChange div 10);

    if change.cent10 > totalCoins.cent10 then begin
      error := true;
      inc(noChangeCounter);
      totalCoins := SubtractCoins(totalCoins, c);
      CalcChange := c;
    end else begin
      totalCoins := SubtractCoins(totalCoins, change);
      error := false;
      noChangeCounter := 0;
      CalcChange := change;
    end; (*if*)
  end;

  procedure CoffeeButtonPressed(input: Coins; VAR change: Coins);
    var
      error: boolean;
  begin

    If noChangeCounter >= 3 then begin
      change := input;
      WriteLn('Error - out of service (not enough coins)');
      //WriteLn('Rückgeld: ', change);
      Exit;
    end;

    if TotalValue(input) < 40 then begin
      change := input;
      WriteLn('Zu wenig Geld, gibts keinen Kaffee. :(');
      //WriteLn('Rückgeld: ');
      //WriteCoins(change);
      Exit;
    end; (*if*)

    change := CalcChange(input, error);

    if error then begin //error: kein Wechselgeld
      WriteLn('Sorry, nicht genug Rueckgeld. Du bekommst dein Geld zurueck');
      WriteLn()
    end else
      WriteLn('Kaffeeeeee!');
  end;


//Initialisation, only first time
BEGIN
  //Wechselgeld
  totalCoins.cent10 := 10;
  totalCoins.cent50 := 5;
  totalCoins.cent100 := 0;

  noChangeCounter := 0;
END.