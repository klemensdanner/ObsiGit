program ExprTest;

const
  lb = 1; // lower bound
  ub = 5; //upperbound

type
  Flower = (rose, violet, daisy);


var
  i: integer;
  r, r2: real;
  f: Flower;
  a: array[lb..ub] of integer;


begin
  WriteLn((3+7)*5-8*3);

  WriteLn(9 div 5);
  WriteLn(9 / 5);
  WriteLn(10 / 5);
  // i := 10 / 5; -- incompatible types - compailer error

  f := rose;
  i := integer(f);
  WriteLn(f, ' = ', i);
  WriteLn('int value for TRUE is: ', Integer(true));


  for i := lb to ub do
    begin
      a[i] := i * 2;
    end;


  i := 13;

  if (i >= lb) and (i <= ub) and (a[i] = 10) then //Kurzschlussauswertung
    begin
      WriteLn('fine');
    end
  else
    WriteLn('sorry bro');




  //{$B+} //vollständige Auswertung
  i := 13;
  if (i >= lb) and (i <= ub) and (a[i] = 10) then //Kurzschlussauswertung
    begin
      WriteLn('fine');
    end
  else
    WriteLn('sorry bro');
  //{$B-} //Kurzschlussauswertung

  r :=  1.00000000000000000000000000000000000000001;
  r2 := 1.00000000000000000000000000000000000000002;

  if (r<r2) then
    writeln('r is kleiner')
  else
    writeln('r is ned kleiner');



end.