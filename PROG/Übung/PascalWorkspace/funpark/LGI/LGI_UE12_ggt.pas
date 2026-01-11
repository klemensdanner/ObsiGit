program ggtCalc;

  function ggt(a, b: integer): integer; //returns the ggt of two int values
  begin
    if a > b then
      ggt := ggt(a-b, b)
    else if b > a then
      ggt := ggt(a, b-a)
    else
      ggt := a;
  end;

  function Add(a, b: integer): integer; //adds two ints using only inc and dec
  begin
    if b <> 0 then begin
      inc(a); dec(b);
      Add := Add(a, b);
    end else
      Add := a;
  end;

  var
    a, b: integer;

begin
  WriteLn('enter 2 values for calculation > ');
  Write(' > ');
  ReadLn(a);
  Write(' > ');
  ReadLn(b);
  WriteLn;

  WriteLn('ggt of ', a, ' and ', b, ' is ', ggt(a, b));

  WriteLn('Add only using inc and dec > ', Add(a, b));
end.