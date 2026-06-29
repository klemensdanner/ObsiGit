// dynamic calculation of arithmetic mean, using parameters to save values

program ArithmeticMean;

  USES
    ArithmeticMeanUnit;

  var
  meanVal: real;

begin
  InitMean;
  
  Mean(3.5, meanVal);
  WriteLn('Mean: ', meanVal:5:2);

  Mean(2.5, meanVal);
  WriteLn('Mean: ', meanVal:5:2);

  Mean(6, meanVal);
  WriteLn('Mean: ', meanVal:5:2);

  WriteLn;
  InitMean;

  Mean(10, meanVal);
  WriteLn('Mean: ', meanVal:5:2);

  Mean(20, meanVal);
  WriteLn('Mean: ', meanVal:5:2);

  Mean(30, meanVal);
  WriteLn('Mean: ', meanVal:5:2);

end.