program sumIT;
var
	k, j, sum, product: integer;



begin
sum := 0;
product := 1;
for j := 1 to 3 do
	begin
		for k := j+1 to j+2 do
      begin
			  sum := sum + (k*j);
      end;
    product := product * sum;
    sum := 0;
	end;
writeln(product);







end.