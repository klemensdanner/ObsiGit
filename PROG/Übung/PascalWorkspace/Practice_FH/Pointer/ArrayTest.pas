program ArrayTest;
  const
    n = 50;


  type 
    IntArray = ARRAY[0..n-1] of integer;
    DynamicIntArray = Array[0..0] of integer; //length defined at runtime

  var
    ia: IntArray;
    i: integer;
    iap: ^IntArray;
    dia: ^DynamicIntArray;
    n2: integer;



begin
  for i := 0 to (n-1) do begin
    ia[i] := i;
    Write(ia[i]:3);
  end; //For
  WriteLn;
  WriteLn;

  (* int array on heap *)
  New(iap);
  for i := 0 to (n-1) do begin
    iap^[i] := i;
    Write(iap^[i]:3);
  end; //For
  Dispose(iap);
  WriteLn;
  WriteLn;

  // dynamic int array
  Write('number of elements > '); ReadLn(n2);
  GetMem(dia, n2 * SizeOf(integer));
  //hier muss man range check ausschalten - deswegen runtime error
    for i := 0 to n2-1 do begin
      dia^[i] := i;
      Write(dia^[i]:3);
    end; //for
    writeln;

  FreeMem(dia, n2 * SizeOf(integer));




end.