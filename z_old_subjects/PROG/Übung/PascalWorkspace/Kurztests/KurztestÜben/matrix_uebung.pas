program matrixplay;

const
  m = 3;
  n = 3;

Type
  Matrix = array[1..m,1..n] of integer;


procedure MatrixReadIn(VAR mat: Matrix; zeilen, spalten: integer);
var
  i, j: integer;

begin

  WriteLn('Enter your matrix: ');
  for i := 1 to zeilen do
    begin
      for j := 1 to spalten do
        Read(mat[i,j]);
      ReadLn;
    end;
end;


procedure MatrixOutput(mat: Matrix; zeilen, spalten: integer);
var
  i, j: integer;

begin
  for i := 1 to zeilen do
    begin
      for j := 1 to spalten do
        Write(mat[i,j]:3);
      WriteLn;
    end;
end;


procedure MatrixSumRowColumn(mat: Matrix; zeilen, spalten: integer);
var
  i,j: integer;
  sum: integer;

begin
  WriteLn('Zeilensumme: ');
  sum := 0; // init
  for i := 1 to zeilen do
    begin
      for j := 1 to spalten do
        begin
          sum := sum + mat[i,j];
        end; //spalten
      
      Write(sum:4);
      sum := 0;
    end; //Zeilen
  WriteLn;

  WriteLn('Spaltensumme: ');
  sum := 0;
  for j := 1 to spalten do
    begin
      for i := 1 to zeilen do
        begin
          sum := sum + mat[i, j];
        end; //zeilen

      Write(sum:4);
      sum := 0;
    end; //spalten
  WriteLn;
end;

function MagicMatrix(mat: Matrix; zeilen, spalten: integer): BOOLEAN;
var
  i,j: integer;
  sum: integer;
  zeilensumme, spaltensumme, diagonalsumme: integer;

begin
  if zeilen <> spalten then //zeilen = spalten
    Exit;

  sum := 0; // init
  for i := 1 to zeilen do
    begin
      for j := 1 to spalten do
        begin
          sum := sum + mat[i,j];
        end; //spalten
      zeilensumme := sum;
      sum := 0;
    end; //Zeilen



  sum := 0;
  for j := 1 to spalten do
    begin
      for i := 1 to zeilen do
        begin
          sum := sum + mat[i, j];
        end; //zeilen

      spaltensumme := sum;

      sum := 0;
    end; //spalten


  sum := 0;
  for i := 1 to zeilen do //zeilen = spalten
    begin
      sum := sum + mat[i,i];
    end;
  diagonalsumme := sum;

  
  MagicMatrix := ((zeilensumme = spaltensumme) and (spaltensumme = diagonalsumme));

end;




var
  mat: Matrix;

begin
  MatrixReadIn(mat,m,n);
  WriteLn;

  MatrixOutput(mat,m,n);
  WriteLn;

  MatrixSumRowColumn(mat,m,n);

  WriteLn('Is it a magic matrix? ');
  if MagicMatrix(mat, m, n) then
    WriteLn('Ja man')
  else 
    WriteLn('nix da brudi');


end.