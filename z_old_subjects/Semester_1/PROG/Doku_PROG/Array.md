
```c

	        Index Datentyp
			     |
se1G1 = ARRAY [1..15] of Student




se = ARRAY [1..3] of ARRAY [1..20] of Student

schöner

      ARRAY[1..3][1..20] of Student
bzw.  ARRAY[1..3, 1..20] of Student --> schönes zweidimensionales array


--> nur gleiche Typen erlaubt
```


Wie weiß man, wann das array aufhört, es muss gespeichert werden, wieviele Elemente sinnvoll befüllt sind. Dazu muss eine Zusatzvariable gespeichert werden.
Felder dürfen keine Löcher haben, wenn man ein Element löscht, müssen die anderen Elemente verschoben werden.