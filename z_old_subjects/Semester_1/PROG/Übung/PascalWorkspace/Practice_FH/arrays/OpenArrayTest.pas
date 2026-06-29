(* ArrayTest:                                                 DA, 2025-10-29 *)
(* ------                                                                    *)
(* Test with one-dim. array                                                  *)
(* ========================================================================= *)

PROGRAM ArrayTest;
  CONST
    max = 100;
    max2 = 20000;

  Type
    CharArray = Array[1..max] of CHAR;
    CharArray2 = Array[1..max2] of CHAR;
    CharArray3 = Array[Char] of char;

  var
    n, n2: integer;
    a: CharArray;
    a2: CharArray3;
    at: integer;


  PROCEDURE FillArray(VAR a: array of char; n: INTEGER);
    VAR
      i: integer;
     

  BEGIN (* FillArray *)
    Randomize;
    for i := 0 to n-1 do BEGIN
      a[i] := Chr(Random(25)+Ord('a'));
    END;

  END; (* FillArray *)


  PROCEDURE WriteArray(a: array of char; n: INTEGER); // hier wird alles reinkopiert, wegen call by value. Allerdings kann das bei vielen Daten ineffizient sein --> call by reference bevorzugen
    var
      i: integer;
  BEGIN (* WriteArray *)
    for i := 0 to n-1 do BEGIN
      Write(a[i]);
    END; (*for*)
    WriteLn;
  END; (* WriteArray *)



PROCEDURE FirstOccuranceAt(a: array of char; n: integer; ch: CHAR; VAR at: INTEGER);
  VAR
    i: integer;

  BEGIN (* FirstOccuranceAt *)
  i := 0;

  WHILE (i<n) and (a[i] <> ch) DO BEGIN
    i := i + 1;
  END;

  if (i >= n) then
    at := -1 //nicht gefunden
  else
    at := i;

    
  END;

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



PROCEDURE AddArray(var a: array of char; var n: integer; a2: array of char; n2: integer);
  var
    i: integer;


BEGIN (* AddArray *)

  if (n+n2 > (High(a)+1)) then //+1 weil high(a) bei 0 zu zählen beginnt, also 0..4, da kann ich 5 elemente speichern
    WriteLn('Error: not enough space.');
    Exit; //hier legitim, da keine for-Schleife. Die Anfangsbedingung ist nicht erfüllt



  for i := 0 to (n2-1) do
    a[n+i] := a2[i];

  n := n + n2;


  
END; (* AddArray *)


BEGIN (* ArrayTest *)

n:= 20;
FillArray(a, n);
WriteArray(a, n);

n2 := 5;
FillArray(a2, n2);
WriteArray(a2, n2);

AddArray(a, n, a2, n2);
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