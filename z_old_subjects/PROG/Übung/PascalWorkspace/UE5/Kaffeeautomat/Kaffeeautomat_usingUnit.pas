program Kaffeeautomat_usingUnit;

USES
  Kaffeeautomat_unit;

var
  input: Coins;
  change: Coins;
  userInteraction: string;
  moreCoffee: boolean;


begin

  moreCoffee := true; //init

  while moreCoffee do begin

    WriteLn('Enter your input: ');
    ReadCoins(input);

    CoffeeButtonPressed(input, change);
    WriteLn;

    WriteLn('Here is your change: ');
    WriteCoins(change);

    WriteLn;

    WriteLn('Do you want another coffee? (y/n)');
    ReadLn(userInteraction);

    if (Length(userInteraction) > 0) AND ((userInteraction[1] = 'y') OR (userInteraction[1] = 'Y')) then
      moreCoffee := true
    else
      moreCoffee := false;

  end; (*while*)

end.