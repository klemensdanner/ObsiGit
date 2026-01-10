// implimentation of a module for calculation of arithmetic mean

UNIT ArithmeticMeanUnit;

INTERFACE
  procedure InitMean;
  procedure Mean(value: REAL; var meanVAl: REAL);
  

IMPLEMENTATION
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

  procedure InitMean;
  begin
    //initialize global memory variables -- wird hier nur beim ersten Aufruf ausgeführt
    n := 0;
    sum := 0.0;
  end;

BEGIN
  //initialize global memory variables -- wird hier nur beim ersten Aufruf ausgeführt
  n := 0;
  sum := 0.0;
END.