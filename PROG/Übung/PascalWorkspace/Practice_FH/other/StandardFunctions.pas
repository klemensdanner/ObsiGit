(* StandardFunctions:                                            DA 25-11-12 *)
(* ------                                                                    *)
(* standard functions for numbers                                            *)
(* ========================================================================= *)

program StandardFunctions;

  // x^y, x > 0
  function Power(x,y:real): real;
  begin
    Power := Exp(ln(x)*y);
  end;


var
 r: real;

begin

  //rounds towards even number
  WriteLn('Round 2.49: ', Round(2.49));
  WriteLn('Round 2.51: ', Round(2.51));
  WriteLn('Round 2.5: ', Round(2.5));
  WriteLn('Round 3.5: ', Round(3.5));

  WriteLn('Trunc 3.5: ', Trunc(3.5)); //abschneiden --> 3

  WriteLn('Absolut -3: ', Abs(-3)); //Absolutbetrag

  WriteLn('Int 2.51: ', Int(2.51)); //liefert den Integeranteil aber als Real
  WriteLn('Frac 2.51: ', Frac(5.51));

  WriteLn('Exp(2.1) = ', Exp(2.1)); //e^x
  WriteLn('Ln(3) = ', ln(3));
  WriteLn('power 2^3 = ', power(2,3));
  WriteLn('pi = ', pi);
  WriteLn('Sqr(2) = ', Sqr(2));
  WriteLn('Sqr(2.2) = ', Sqr(2.2));
  WriteLn('Sqrt(16) = ', sqrt(16));

  r := 25; // in degree, --> to radian 1 = pi
  r := (r * pi/180);
  WriteLn(r);
  WriteLn('Sin(r) = ', sin(r)); // trigonometrische standardfunktionen verwenden das Bogenmaß!
  

end.