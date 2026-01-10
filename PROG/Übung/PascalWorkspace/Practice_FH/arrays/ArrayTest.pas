(* ArrayTest:                                                 DA, 2025-10-29 *)
(* ------                                                                    *)
(* Test with one-dim. array                                                  *)
(* ========================================================================= *)

PROGRAM ArrayTest;
  CONST
    max = 100;

  Type
    CharArray = Array[1..max] of CHAR;

  var
   n: integer;
  a: CharArray;


  PROCEDURE FillArray(VAR a: CharArray; n: INTEGER);
    VAR
      i: integer;
     

  BEGIN (* FillArray *)
    Randomize;
    for i := 1 to n do BEGIN
      a[i] := Chr(Random(25)+Ord('a'));
    END;

  END; (* FillArray *)


  PROCEDURE WriteArray(a: CharArray; n: INTEGER); // hier wird alles reinkopiert, wegen call by value. Allerdings kann das bei vielen Daten ineffizient sein --> call by reference bevorzugen
    var
      i: integer;
  BEGIN (* WriteArray *)
    for i := 1 to n do BEGIN
      Write(a[i]);
    END; (*for*)
    WriteLn;
  END; (* WriteArray *)



PROCEDURE FirstOccuranceAt(a: CharArray; ch: CHAR; VAR at: INTEGER);
  VAR
    i: integer;

  BEGIN (* FirstOccuranceAt *)
  i := 1;

  WHILE ((a[i] <> ch) and (a[i] <> ch)) DO BEGIN
    i := i + 1;
  END;

  if (i>n) then
    at := 0
  else
    at := i;

    
  END;


  PROCEDURE InsertAt(VAR a: CharArray; Var n: INTEGER; ch: Char; at: integer);
    var
      i: integer;
  BEGIN (* InsertAt *)
    if (n >= max) then BEGIN
      WriteLn('Error - no more space available')
      END
    else
      if ((at > n+1) or (at<1)) then
        WriteLn('Error - at out of range')
      else
      BEGIN
        for i:= n downto at do
          a[i+1] := a[i];

        a[at] := ch;
        n := n+1;


      END    
  END; (* InsertAt *)


procedure DeleteFirstOccuranceOf(Var a: CharArray; var n: integer; ch: char);
  var
    i, j: integer;
  BEGIN

  //search for char
  i := 1; //init

  while (i <= n) and (a[i] <> ch) do
    i := i + 1; // Position festgelegt

  // ch found?

  if (i <= n) then
    // move elements to the left
    for j := i to n-1 do //deshalb n-1, weil bei j+1 sonst ins leere zugegeriffen wird
      a[j] := a[j+1]; //Wert den nächsten wert zuordnen

  n := n-1; //eins wurde gelöscht, daher um 1 verschieben
   END;








BEGIN (* ArrayTest *)

n:= 20;
FillArray(a, n);

WriteArray(a, n);
Writeln('n: ', n);
Writeln;

InsertAt(a, n, 'F', 7);

WriteArray(a, n);
Writeln('n: ', n);
Writeln;

{*
DeleteFirstOccuranceOf(a, n, 'F');
WriteArray(a, n);
Writeln('n nach delete: ', n);
Writeln;

DeleteFirstOccuranceOf(a, n, 'x');
WriteArray(a, n);
Writeln('n nach delete: ', n);
Writeln;

DeleteFirstOccuranceOf(a, n, 'y');
WriteArray(a, n);
Writeln('n nach delete: ', n);
Writeln;

DeleteFirstOccuranceOf(a, n, 'e');
WriteArray(a, n);
Writeln('n nach delete: ', n);
Writeln; *}
END. (* ArrayTest *)