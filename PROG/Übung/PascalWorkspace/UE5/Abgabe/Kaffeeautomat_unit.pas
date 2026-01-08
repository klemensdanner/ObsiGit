(* Unit for Coffee Machine:                                   DA, 2025-11-22 *)
(* ------                                                                    *)
(* implements a UNIT for controlling a coffee machine                        *)
(* ========================================================================= *)

UNIT Kaffeeautomat_unit;

INTERFACE
  TYPE
    Coins = RECORD
      cent10: INTEGER;
      cent50: INTEGER;
      cent100: INTEGER;
  END;

  PROCEDURE ReadCoins(VAR c: Coins);
  PROCEDURE WriteCoins(c: Coins);

  PROCEDURE CoffeeButtonPressed(input: Coins; VAR change: Coins);

IMPLEMENTATION

  VAR
    totalCoins: Coins;
    noChangeCounter: INTEGER;

  PROCEDURE ReadCoins(VAR c: Coins);
  BEGIN
    Write('10 cent coins > '); ReadLn(c.cent10);
    Write('50 cent coins > '); ReadLn(c.cent50);
    Write('100 cent coins > '); ReadLn(c.cent100);
  END;

  PROCEDURE WriteCoins(c: Coins);
  BEGIN
    WriteLn('10 cent coins > ', c.cent10);
    WriteLn('50 cent coins > ', c.cent50);
    WriteLn('100 cent coins > ', c.cent100);
  END;

  FUNCTION AddCoins(a, b: Coins): Coins;
    BEGIN
      AddCoins.cent10 := a.cent10 + b.cent10;
      AddCoins.cent50 := a.cent50 + b.cent50;
      AddCoins.cent100 := a.cent100 + b.cent100;
    END;

  FUNCTION SubtractCoins(a, b: Coins): Coins;
  BEGIN
    SubtractCoins.cent10 := a.cent10 - b.cent10;
    SubtractCoins.cent50 := a.cent50 - b.cent50;
    SubtractCoins.cent100 := a.cent100 - b.cent100;
  END;

  

  FUNCTION TotalValue(c: Coins): INTEGER;
  BEGIN
    TotalValue := c.cent10*10 + c.cent50*50 + c.cent100*100;
  END;

  FUNCTION CalcChange(c: Coins; VAR error: BOOLEAN): Coins;
    VAR
      change: Coins;
      ValueOfChange: INTEGER;
  
  BEGIN

    change.cent100 := 0; //init
    change.cent50 := 0;
    change.cent10 := 0;

    totalCoins := AddCoins(totalCoins, c); //Eingabe zu Totalcoins addieren, zum Stand aktualisieren

    ValueOfChange := TotalValue(c)-40; //Kaffeepreis

    change.cent100 := change.cent100 + (ValueOfChange DIV 100);
    ValueOfChange := ValueOfChange MOD 100; //Rest für die anderen Münzen
    WHILE change.cent100 > totalCoins.cent100 DO BEGIN
      dec(change.cent100);
      change.cent50 := change.cent50 + 2;
    END; (*WHILE*)

    change.cent50 := change.cent50 + (ValueOfChange DIV 50);
    ValueOfChange := ValueOfChange MOD 50; //Rest
    WHILE change.cent50 > totalCoins.cent50 DO BEGIN
      dec(change.cent50);
      change.cent10 := change.cent10 + 5;
    END; (*WHILE*)

    change.cent10 := change.cent10 + (ValueOfChange DIV 10);

    IF change.cent10 > totalCoins.cent10 THEN BEGIN
      error := TRUE;
      inc(noChangeCounter);
      totalCoins := SubtractCoins(totalCoins, c);
      CalcChange := c;
    END ELSE BEGIN
      totalCoins := SubtractCoins(totalCoins, change);
      error := FALSE;
      noChangeCounter := 0;
      CalcChange := change;
    END; (*IF*)
  END;

  PROCEDURE CoffeeButtonPressed(input: Coins; VAR change: Coins);
    VAR
      error: BOOLEAN;
  BEGIN

    IF noChangeCounter >= 3 THEN BEGIN
      change := input;
      WriteLn('Error - out OF service (NOT enough coins)');
      //WriteLn('Rückgeld: ', change);
      Exit;
    END;

    IF TotalValue(input) < 40 THEN BEGIN
      change := input;
      WriteLn('Zu wenig Geld, gibts keinen Kaffee. :(');
      //WriteLn('Rückgeld: ');
      //WriteCoins(change);
      Exit;
    END; (*IF*)

    change := CalcChange(input, error);

    IF error THEN BEGIN //error: kein Wechselgeld
      WriteLn('Sorry, nicht genug Rueckgeld. Du bekommst dein Geld zurueck');
      WriteLn()
    END ELSE
      WriteLn('Kaffeeeeee!');
  END;


//Initialisation, only first time
BEGIN
  //Wechselgeld
  totalCoins.cent10 := 10;
  totalCoins.cent50 := 5;
  totalCoins.cent100 := 0;

  noChangeCounter := 0;
END.
