unit floatingMeanUnit;

INTERFACE
  function CurrMeanCalc(value: real): real;
  PROCEDURE CurrMeanCalcInit;

IMPLEMENTATION
  var
    n: integer;
    currMean: real;
  
  function CurrMeanCalc(value: real): real;
  BEGIN
    currMean := ((currMean*n)+value)/(n+1);
    inc(n);
    CurrMeanCalc := currMean;

  END;

  PROCEDURE CurrMeanCalcInit;
  BEGIN
    n := 0;
    currMean := 0.0;
  END;


BEGIN
  n := 0;
  currMean := 0.0;



end.