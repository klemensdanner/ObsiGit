Alle Namen dürfen idents werden
- ident
- number


ausreichend Platz lassen für sem. Aktionen, evtl. Farbstifte verwenden
1. Grammatik aufstellen
2. Attribute und semantische Aktionen festlegen


number und digit kann man voraussetzen



```
List    = Group {"," Group}. --> Punkt ist immer am Ende einer EBNF Regel
Group   = ident "(" ident ")" "[" Student {"," Student} "]".
Student = ident ":" {Point}.
Point   = number | "--".
```


## Attribute

```
List    = Group {"," Group}. --> Punkt ist immer am Ende einer EBNF Regel
Group   = ident "(" ident ")" "[" Student {"," Student} "]".
Student_↑sum_↑count =                sem sum = 0; count = 0; endsem
					ident ":" 
					{Point_↑p         sem sum += p; count++ endsem
					}.
Point_↑p   = number     p = numberVal
			| "--"      p = 0;
			.
```











Klammern sind unterschiedliche Terminalsymbole, damit Leerzeichen dazwischen auftreten können