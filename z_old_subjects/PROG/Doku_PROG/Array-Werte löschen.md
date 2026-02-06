```pascal
DeleteFirstOccuranceOf()
```

1. Suchen
2. Elemente verschieben
3. Anzahl der Elemente anpassen

```pascal
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
```


Getestet werden sollen folgende Fälle:
- Beginn, Mitte, Ende und einen char der nicht drin ist



## Matrix
#prüfung Kurztest vll über Matrix erstellen??
openarray parameter ist diesmal nicht dabei
drinnen zählen oder raussuchen, einfügen, löschen


Matrix bestimmen wir vollständig. man braucht also sich die anazhl der befüllten werte nicht merken


## OpenArray Parameter

nur eindimensional und einfache typen


## Verbunddatentyp
```pascal
Student = RECORD
	name: string;
	SVNr: integer;
	dob: Date;
	studNr: integer;
end;

var
	stud1: Student;
	
	
//Zugriff mit
stud1.name
stud1.SVNr
etc.
```

## Gültigkeitsbereiche

![[Pasted image 20251105155449.png|500]]

Der Compailer schaut immer zuerst im Runtimestack ob die variable verfügbar ist, wenn sie da ist, nimmts die, sonst nimmts nächste stufe vom stack / hauptspeicher