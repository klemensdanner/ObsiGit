// dynamic calculation of arithmetic mean, using parameters to save values

program ArithmeticMean2;
var
  n: integer; //number of values
  sum: real;

procedure Mean(value: REAL; var meanVAl: REAL);

  // s_(n+1) = g(s_n, e)
  // a = f(s_n, e)
  begin
    n := n + 1;
    sum := sum + value;
    meanVAl := (sum) / n;

  end;

var
  //additional test variables
  meanVal: real;

begin
  //initialize global memory variables
  n := 0;
  sum := 0.0;

  Mean(3.5, meanVal);
  WriteLn('Mean: ', meanVal);

  Mean(2.5, meanVal);
  WriteLn('Mean: ', meanVal);

  Mean(6, meanVal);
  WriteLn('Mean: ', meanVal);
end.