// dynamic calculation of arithmetic mean, using parameters to save values

program ArithmeticMean1;

procedure Mean(VAR n: integer; VAR sum: REAL; value: REAL; var meanVAl: REAL);

  // s_(n+1) = g(s_n, e)
  // a = f(s_n, e)
  begin
    n := n + 1;
    sum := sum + value;
    meanVAl := (sum) / n;

  end;


  var

    n: integer; //number of values
    sum: real;

    //additional test variables
    meanVal: real;


begin
  //initialize memory variables
  n := 0;
  sum := 0.0;

Mean(n, sum, 3.5, meanVal);
WriteLn('Mean: ', meanVal);

Mean(n, sum, 2.5, meanVal);
WriteLn('Mean: ', meanVal);

Mean(n, sum, 6, meanVal);
WriteLn('Mean: ', meanVal);
end.