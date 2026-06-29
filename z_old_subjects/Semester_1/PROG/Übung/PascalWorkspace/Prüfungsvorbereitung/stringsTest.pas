program strings;

  function Contains(s, p: string): boolean;
    var
      slen, pLen, i, j, pos: integer;
  begin
    i := 1;
    pos := 0;
    slen := length(s);
    pLen := length(p);
    while (pos = 0) and (i <= (slen - pLen + 1)) do begin
      j := 1;
      while (j <= pLen) and (p[j] = s[i + j - 1]) do begin
        inc(j);
      end;
      if j > pLen then begin //voll durchgelaufen, Treffer
        pos := i;
      end;
      inc(i);
    end;
    Contains := (pos <> 0);
  end;

  var
    s, p: string;
begin
  s := 'bcabcdfg';
  p := 'abc';

  if Contains(s, p) then
    WriteLn('success');

end.