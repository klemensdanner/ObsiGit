(* ArrayTest:                                                 DA, 2025-11-26 *)
(* ------                                                                    *)
(* 1. IntArray                                                               *)
(* 2. IntArray on heap                                                       *)
(* 3. Dynamic IntArray on heap                                               *)
(* ========================================================================= *)
PROGRAM ArrayTest;

  CONST
    n = 50;

  TYPE
    IntArray = ARRAY[0..n-1] OF INTEGER;
    DynamicIntArray = ARRAY[0..0] OF INTEGER;  (* length defined at runtime *)

  VAR
    ia: IntArray;
    iap: ^IntArray;
    dia: ^DynamicIntArray;
    i: INTEGER;
    n2: INTEGER;

BEGIN (* ArrayTest *)
  (* 1. static int array *)
  FOR i := 0 TO n-1 DO BEGIN
    ia[i] := i;
    Write(ia[i]:3);
  END; (* FOR *)
  WriteLn; WriteLn;

  (* 2. int array on heap *)
  New(iap);
  FOR i := 0 TO n-1 DO BEGIN
    iap^[i] := i;
    Write(iap^[i]:3);
  END; (* FOR *)
  Dispose(iap);
  WriteLn; WriteLn;

  (* 3. dynamic int array *)
  Write('number of elements > '); ReadLn(n2);
  GetMem(dia, n2 * SizeOf(INTEGER));
  FOR i := 0 TO n2-1 DO BEGIN
    (*$R-*)  (* disable range checking *)
    dia^[i] := i;
    Write(dia^[i]:3);
    (*$R+*) (* enable range checking *)
  END; (* FOR *)
  FreeMem(dia, n2 * SizeOf(INTEGER));
  WriteLn; WriteLn;
END. (* ArrayTest *)
