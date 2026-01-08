//geht ned

PROGRAM StringTest;



function CountChar(s: String; ch: char): integer;
  var
  i, j: integer;

  BEGIN
    j := 0;
    for i := 1 to length(s) do
    BEGIN
      if (s[i] = ch) then
        j := j + 1;
    end;

    CountChar := j
  end;

BEGIN


WriteLn(CountChar('Halloween', 'l'));




end.
