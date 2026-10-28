## String funktionen



```
strcmp: 0 wenn equal, wenn erstes kleiner als zweites -- negativ
wenn erstes größer als zweites -- positiv value


strcpy -- zum kopieren
strncpy() -- kopieren mit maximalanzahl - wenn terminalsymbol fehlt ist das 

restrict keyword: arrays überlappen sich nicht beim kopieren


----

snprintf(): etwas in einen anderen string schreiben




mit s->value kann ich auf (*s).value zugreifen - als kurzschreibweise

```


 `realloc()`  kann allokierten speicherplatz, wo sich die größe verändert, verändern und deckt dabei mögliche Fälle ab:
 - neuer Platz ist kleiner -- kein verschieben notwendig
 - neuer Platz ist größer aber genug Platz danach frei -- kein verschieben notwendig
 - neuer Platz ist größer aber kein Platz danach mehr frei -- neuer Platz allokiert und bestehendes rüberkopiert, erste values bleiben erhalten


ternärer Operator:
`condition ? <wenn_true> : <wenn false>


Quicksort funktion syntax:
`qsort(name_array, laenge, goesse_von_einem_element, compare_funktion)`




kleine programmieraufgabe, vll kleine theoriefrage
stoff: C grundlagen schleifen, verzweigungen,
memcopy, free, alloc etc
standardfunktionen für strings kennen
c++ reference kann man verwenden
9.11., bis dahin ist hausübung, dann 1 woche fürs review