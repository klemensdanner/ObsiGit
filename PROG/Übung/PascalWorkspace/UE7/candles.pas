program Candles;

  function CandlesRec(h: integer): integer;
  begin
    if h = 1 then begin
      CandlesRec := 1;
    end else begin
      CandlesRec := 1 + (3 * CandlesRec(h-1));
    end;
  end;

  function CandlesIt(h: integer): integer;
    var
      i: integer;
      result: integer;
  begin 
    result := 1;
    for i := 2 to h do begin
      result := 1 + (3 * result);
    end;
    CandlesIt := result;
  end;

  var
    userInput: integer;

begin
  Write('How high is the tree? > ');
  ReadLn(userInput);
  
  if userInput > 0 then begin
    Write('CandlesRec:');
    WriteLn(CandlesRec(userInput):3);

    Write('CandlesIt:');
    WriteLn(CandlesIt(userInput):3);
  end else begin
    WriteLn('Enter a positive value');
  end;

end.