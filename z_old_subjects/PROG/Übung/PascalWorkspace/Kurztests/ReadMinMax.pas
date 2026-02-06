program MinMax;

procedure ReadMinMax(VAR min,max: integer);

var
  value, i: integer;

begin
  for i := 1 to 10 do
    begin
      Read(value);
      if value > max then
        max := value
      else
        begin
          if value < min then
            min := value;
        end;
      end;
end;


var
  min, max: integer;

begin
  min := 0;
  max := 0;

  ReadMinMax(min,max);
  WriteLn('Min: ', min);
  WriteLn('Max: ', max);


end.