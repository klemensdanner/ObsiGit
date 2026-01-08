- globale Variablen
	- einfach, überall manipulierbar
- statisch initialisierte Variablen
- Modul
- veränderte Eingangsparameter je nach Programmstand

Im Folgenden am Beispiel gleitender Mittelwertbildung.
## Gedächtnis mit Parametermanipulation

```pascal
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
```

-- liefert die korrekten Outputs. Variablen nicht global aber trotzdem im Hauptprogramm sichtbar und dürfen dort nicht verändert werden!
-- gemacht wurde es mittels Parametermanipulation



//hier mit
## Gedächtnis mit globaler Variable

```pascal
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
```

Schlechter, da noch weniger Kontrolle

Es sollte so sein, dass keiner direkten Zugriff drauf hat, um vor Manipulationen zu schützen.
--> #Module bzw. in Pascal: #Unit

## Unit
Unit schreiben:
```pascal
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
```

Programm:
```pascal
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
```


