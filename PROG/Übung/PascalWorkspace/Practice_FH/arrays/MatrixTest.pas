(* MatrixTest:                                                da, 2025-11-05 *)
(* ------                                                                    *)
(* 2-dim matrix                                                              *)
(* ========================================================================= *)


PROGRAM Matrixtest;
  
  CONST
    m = 3;
    n = 4;

  Type
    Matrix = array[1..m, 1..n] of integer;



  procedure FillMatrix(var mat: Matrix);
    var 
      i, j: integer; // zum durchlaufen der matrix

  BEGIN
  for i := 1 to m do
    for j := 1 to n do
      mat[i,j] := i*j;
  
  END;



  procedure WriteMatrix(mat: Matrix);
    var
    i, j: integer;
  BEGIN
    for i:= 1 to m do
      BEGIN
      for j := 1 to n do
        Write(mat[i,j]:3);
      Writeln;
      end;


  end;



  var
  mat: Matrix;

BEGIN
  FillMatrix(mat);
  WriteMatrix(mat);
  WriteLn;

  mat[2,3] := 66;
  WriteMatrix(mat);
  WriteLn;

END.
