program pattern;

  procedure PrintPattern(n: integer);
    var
      i, j: integer;
  begin
    for i := 1 to n do begin
      for j := 1 to n do begin
        if (i = 1) or (j = 1) or (i = n) or (j = n) then begin
          Write('#':2);
        end else begin
          if i mod 2 = 0 then begin
            if j mod 2 = 0 then begin
              Write('X':2);
            end else begin
              Write('O':2);
            end;
          end else begin
            if j mod 2 = 0 then begin
              Write('O':2);
            end else begin
              Write('X':2);
            end;
          end;
        end;
      end;
      WriteLn;
    end;
  end;


begin
  PrintPattern(20);
end.
