
```pascal
for i := 1 to m do begin
	for j := 1 to n do begin
	...
	end;
end;
```


```pascal
                                  Laufzeit in Zeiteinheiten     |
i := 1;                      | 1                                |
while i <= m do begin        | m + 1 (bei +1 Bedingung falsch)  |
	j := 1;                  | m
	while j <= n do begin    | m * (n + 1)
		...                  | m * n (Alles in der Schleife)
		inc(j);              |
	end;                     |
	inc(i);                  | m
end;                         |
```


--> Gewichtung beachten



| Gew | m   | n   | const |
| --- | --- | --- | ----- |
| 1,0 |     |     |       |
