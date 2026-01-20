program FamTree;


  procedure P(t: TreePtr; name: string; level: integer);
  begin
    if t <> 0 then begin
      if level = 2 then begin
        WriteLn('Grandparent = ', t^.name);
      end else begin
        if name = t^.name then 
          level := 1;
        else if level = 1 then begin
          level := 2
        end;
        P(t^.right, name, level);
        P(t^.left, name, level);
      end;
    end;
  end;