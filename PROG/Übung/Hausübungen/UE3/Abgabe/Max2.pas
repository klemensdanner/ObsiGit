(* Maximum:                                                   DA, 2025-10-25 *)
(* ------                                                                    *)
(* Eveluates the maximum of 2 or 3 numbers using functions                   *)
(* ========================================================================= *)

PROGRAM Maximum;

// Aufgabe a)
FUNCTION Max2(a, b: INTEGER): INTEGER;
	var maximum: INTEGER;
	
	BEGIN
	IF a > b then
		maximum := a
	ELSE
		maximum := b;
  Max2 := maximum
	END;

// Aufgabe b)
FUNCTION Max3(a, b, c: INTEGER): INTEGER;
  BEGIN
    Max3 := Max2(Max2(a,b),c);
  END;

VAR
  a, b, c: INTEGER;

BEGIN
  Write('Geben Sie drei Zahlen ein. Das Maximum der ersten beiden und aller drei Zahlen wird ermittelt: ');
  WriteLn; Read(a,b,c);

  WriteLn('Maximum der ersten beiden Zahlen: ', Max2(a,b));
  WriteLn('Maximum aller Zahlen: ', Max3(a,b,c));

END.