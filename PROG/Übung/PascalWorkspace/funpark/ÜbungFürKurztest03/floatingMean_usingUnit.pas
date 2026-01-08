program FloatingMeanUsingUnit;

uses
  floatingMeanUnit;


var
  moreNumbers: boolean;
  userAnswer: char;
  value: real;
BEGIN

  CurrMeanCalcInit;
  moreNumbers := true;
  while moreNumbers do BEGIN
    Write('enter a real number > ');
    ReadLn(value);
    
    WriteLn('The current Mean is > ', CurrMeanCalc(value):2);

    WriteLn('wanna add another number? (y/n)');
    Readln(userAnswer);

    if (userAnswer = 'n') then
      moreNumbers := false;
  end; //while


END.
