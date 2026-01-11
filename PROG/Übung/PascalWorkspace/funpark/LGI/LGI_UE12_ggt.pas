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


  function Multi(a, b: integer): integer; //multiplies 2 numbers using only inc, dec and Add
  begin
    if b > 1 then begin
      dec(b);
      Multi := Add(Multi(a, b), a)
    end else if b = 1 then
      Multi := a
    else
      Multi := 0;
  end;

  function Power(a, b: integer): integer; //calc a^b
  begin
    if b > 0 then
      Power := Multi(Power(a, b-1), a)
    else
      Power := 1;
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

 // WriteLn('ggt of ', a, ' and ', b, ' is ', ggt(a, b));
  WriteLn('Add only using inc and dec > ', Add(a, b));
  WriteLn('Multi > ', Multi(a, b));
  WriteLn('Power (a^b) > ', Power(a, b));

end.