program sumIT;
var
	k, j, sum, product: integer;

begin

sum := 0;
product := 1;

for k := 2 to 4 do
	begin
		for j := 2 to k do
			begin
				product := product * (k+j);
			end;
			sum := sum + product;
			product := 1;
	end;
	
writeln(sum);


end.