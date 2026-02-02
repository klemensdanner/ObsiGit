
```c
H(key: string): int
begin
	h := 0
	for i := 1 to length(key) do begin
		h := h + int(key[i])
	end
	return h
end
```
Das Funktionsergebnis ist der Hashcode

- Hashcodes sind nicht eindeutig
- Es gibt immer mehr Zeichenketten als Ziffern
- Warum?


a: array\[ordinaler Datentyp] of integer;

ordinaler Datentyp ist z.b. \[1..10] aber auch char, integer etc.


