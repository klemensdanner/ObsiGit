//Test for case

program CaseTest;

var
  i: integer;
  ch: char;

begin
  Write('enter your integer-value: > ');
  ReadLn(i);

  case i of
    1: begin
      WriteLn('i is 1');
      end;
    2, 5: WriteLn('i is 2 or 5: ', i);
    7..9: WriteLn('i is in interval 7 to 9 [7..9]');
    else
      WriteLn('in else');
  end; //case




begin
  Write('enter your char-value: > ');
  ReadLn(ch);

  case ch of
    'a': begin
      WriteLn('ch is a');
      end;
    'b','c','e': WriteLn('i is 2 or 5: ', ch);
    'k'..'n', 'o'..'r': WriteLn('i is in interval');
    else
      WriteLn('in else');
  end; //case


end.