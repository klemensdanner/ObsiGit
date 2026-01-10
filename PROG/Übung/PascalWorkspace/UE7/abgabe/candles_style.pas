PROGRAM Candles;

  FUNCTION CandlesRec(h: INTEGER): INTEGER;
  BEGIN
    IF h = 1 THEN BEGIN
      CandlesRec := 1;
    END ELSE BEGIN
      CandlesRec := 1 + (3 * CandlesRec(h-1));
    END;
  END;

  FUNCTION CandlesIt(h: INTEGER): INTEGER;
    VAR
      i: INTEGER;
      result: INTEGER;
  BEGIN 
    result := 1;
    FOR i := 2 TO h DO BEGIN
      result := 1 + (3 * result);
    END;
    CandlesIt := result;
  END;

  VAR
    userInput: INTEGER;

BEGIN
  Write('How high is the tree? > ');
  ReadLn(userInput);
  
  IF userInput > 0 THEN BEGIN
    Write('CandlesRec:');
    WriteLn(CandlesRec(userInput):3);

    Write('CandlesIt:');
    WriteLn(CandlesIt(userInput):3);
  END ELSE BEGIN
    WriteLn('Enter a positive value');
  END;
END.