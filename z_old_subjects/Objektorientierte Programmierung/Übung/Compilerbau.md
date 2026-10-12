composite pattern

Textfile - lex. Analysator - Parser (Syntaktischer Analysator)
{ } Wiederholungen
\[ ] .. Optionen
() ... Gruppierungen
. ... Regelabschluss
= ... Regeldefinition
| ... Alternativen / oder
"..." ... Terminalsymbol

Non Terminal Symbol ... NTS
Terminalsymbol ... TS

Ein Satz besteht aus:
NTS = Kette.


Re


### Lexikalischer Analysator
Wandelt Zeichen in Terminalsymbole / NTS um
fasst einzelne Zeichen zusammen, z.B. die einzelnen zeichen i, n, t werden als "int" erkannt





### Parser







Analyse erfolgt mittels Grammatik
```
Expr = Od {Op Od}.
Op = "+" | "-" | "*" | "/".
Od = num | "(" Expr ")".
```

Dabei ist num eine Terminalklasse.

Problem: kein Punkt vor Strich

besser:
```
s = Expr EOL.
Expr = Term {("+" | "-") Term}
Term = Fact {("*" | "/") Fact}
Fact = num | "(" Expr ")".


1 + 2 * 3

würde gültig auf 7 berechnen
```
Diese Grammatik erfüllt die LL1 Bedingung, daraus ergibt sich Punkt vor Strich.


Ein parser der von Oben, der top down syntax analyse betreibt, nennt man Parser des rekursiven Abstiegs