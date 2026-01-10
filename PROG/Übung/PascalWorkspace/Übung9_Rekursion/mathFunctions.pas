program MathFunctions;
  //helpers for stats
  VAR
    calls: LONGINT;
    depth, maxDepth: LONGINT;

  PROCEDURE InitStatistics;
  BEGIN (* InitStatistics *)
    calls := 0;
    depth := 0;
    maxDepth := 0;
  END; (* InitStatistics *)

  PROCEDURE WriteStatistics;
  BEGIN (* WriteStatistics *)
    WriteLn('Statistics');
    WriteLn('  Number of calls = ', calls);
    WriteLn('  Max depth       = ', maxDepth);   
    WriteLn('  depth           = ', depth);    
  END; (* WriteStatistics *)
//----------end helpers








  //factorial
  function FactorialRec(n: longint): longint;
  begin
    inc(calls);
    inc(depth);
    if depth > maxDepth then
      inc(maxDepth);
    if (n = 1) then
      FactorialRec := 1
    else
      FactorialRec := n * FactorialRec(n - 1);
      dec(depth);
  end;


  function FactorialIter(n: longint): longint;
    var
      f, i: longint;
  begin
    f := 1;
    for i := 2 to n do
      f := f*i;
    
    FactorialIter := f;
  end;


  //------- Fibonacci Series ------
  function Fibonacci(n: integer): integer;
  begin
    if (n = 1) or (n = 2) then
      Fibonacci := 1
    else
      Fibonacci := Fibonacci(n-1) + Fibonacci(n-2);
  end;

  function FibonacciRec2(n: integer): integer;
  begin
    
    inc(calls);
    inc(depth);
    if depth > maxDepth then
      maxDepth := depth;

    if (n = 1) or (n = 2) then
      FibonacciRec2 := 1
    else begin
      FibonacciRec2 := FibonacciRec2(n-1) + FibonacciRec2(n-2);
      dec(depth)
    end;
  end;
  var
    n: longint;



  function FibonacciIter(n: integer): integer;
    fib1: integer; //(fib(n-1))
    fib2: integer; //fib(n-2)
    fib, i: integer;
  begin
    fib1 := 1;
    fib2 := 1;
    for 3 to n do begin
      fib := fib1 + fib2;
      fib2 := fib1;
      fib1 := fib;
    end;
    FibonacciIter := fib;  
  end;




begin
  InitStatistics;
  Write('n > '); ReadLn(n);
  {WriteLn('n! (rec) = ', FactorialRec(n));
  WriteStatistics;
  WriteLn('n! (iter) = ', FactorialIter(n));}

  //WriteLn('Fibonacci(n) = ', Fibonacci(n));
  WriteLn('Fibonacci(n) = ', FibonacciRec2(n));
  WriteStatistics;



end.