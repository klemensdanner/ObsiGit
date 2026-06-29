



| Name | Datentyp | Wertebereich      | Operat                         | Beschreibung                                                        |
| ---- | -------- | ----------------- | ------------------------------ | ------------------------------------------------------------------- |
| ch   | CHAR     | ‘a’ ... ‘z’       | <, >,=, ==                     | Einzelzeichen                                                       |
| i    | INTEGER  | -32768 bis 32767  | +, -, *, :, mod, <, >,=, >=,<= | ganze Zahl                                                          |
| b    | BOOLEAN  | TRUE<br><br>FALSE | =, <>, NOT                     | Wahrheitswert                                                       |
| r    | REAL     | 0.0               |                                | Gleitkommazahl<br><br>Abwägung: Ressourcenverbrauch, Präzision etc. |

Wertzuweisungen
	b_1 := TRUE
	b_2 := FALSE

VAR // Deklaration
	i : INTEGER


i := 0;   //Wertzuweisung



i := i+1   // auf der linken Seite immer eine Variable. Auf der rechten Seite steht ein auswertbarer Ausdruck




## #String

max. 255 Zeichen. alles drüber wird einfach weggelassen --- kein overflow!


```
|     |     |     |     |     |     |
| --- | --- | --- | --- | --- | --- |


   0     1     2    3    .....   255
   
Also insgesamt 256 Werte, aber im ersten Wert [0] steht die Länge des Strings als Character. Also müsste Ord(string[0]) = length(string)
```



```pascal
smallstring: String[10] macht einen String mit 10 Stellen


WriteLn(s[0]); // Gibt den jeweiligen Buchstaben, der An der Ord(s[0]. Stelle im Ascii zeichensatz liegt)

WriteLn(Ord(s[0])); //Gibt die Länge des Strings
```


Anwendung von Vergleichsoperationen auf strings

```
a < b
aa < b //es wird immer nur der erste char verglichen, bei Bedarf der Zweite etc.
```


