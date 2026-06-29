PROGRAM Kaffeeautomat_usingUnit;

USES
  Kaffeeautomat_unit;

VAR
  input: Coins;
  change: Coins;
  userInteraction: STRING;
  moreCoffee: BOOLEAN;


BEGIN

  moreCoffee := TRUE; (*init*)

  WHILE moreCoffee DO BEGIN

    WriteLn('Enter your input: ');
    ReadCoins(input);

    CoffeeButtonPressed(input, change);
    WriteLn;

    WriteLn('Here is your change: ');
    WriteCoins(change);

    WriteLn;

    WriteLn('Do you want another coffee? (y/n)');
    ReadLn(userInteraction);

    IF (Length(userInteraction) > 0) AND ((userInteraction[1] = 'y') OR (userInteraction[1] = 'Y')) THEN
      moreCoffee := TRUE
    ELSE
      moreCoffee := FALSE;

  END; (*while*)

END.
