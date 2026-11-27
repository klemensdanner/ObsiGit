> [!PDF|yellow] [[12-C++-Templates.pdf#page=8&selection=43,0,45,40&color=yellow|12-C++-Templates, p.7]]
> > // print("hello"); // XXX: deleted function
> 
> Dieser Datentyp wurde ausgenommen

> [!PDF|yellow] [[12-C++-Templates.pdf#page=8&selection=92,20,92,34&color=yellow|12-C++-Templates, p.7]]
> > Polymorphismus
> 
> aber bereits zur Compiletime ist der Typ bekannt

> [!PDF|yellow] [[12-C++-Templates.pdf#page=9&selection=22,3,22,15&color=yellow|12-C++-Templates, p.8]]
> > incompatible
> 
> - in C passiert dann aber nichts - man bekommt trotzdem ein Ergebnis
> - in c++ ist das aber typsicher, d.h. T muss immer der selbe Typ sein, sonst gibts einen Fehler

> [!PDF|yellow] [[12-C++-Templates.pdf#page=10&selection=33,0,38,1&color=yellow|12-C++-Templates, p.9]]
> > x + x 
> 
> es könnte ja sein, dass hier links ein lvalue rauskommt, also kommt kein Fehler
> - bei konkreter Implementierung kann es aber fehlschlagen, z.B. wenn man einen int einsetzt
> - Tipp: Templates mit konkreten Datentypen ausprobieren

> [!PDF|yellow] [[12-C++-Templates.pdf#page=11&selection=110,0,112,10&color=yellow|12-C++-Templates, p.10]]
> > auto add3(auto a, auto b)
> 
> das hier ist genauso auch ein Template, also auch das hier mit konkreten Typen testen.
> - so hier ist aber nicht sichergestellt, wenn wir auto schreiben; dass add3 mit dem selben Typen aufgerufen wird - in add2 könnte man schreiben `add2(T1, T1)` um das sicherzustellen.



> [!PDF|yellow] [[12-C++-Templates.pdf#page=15&selection=60,0,62,14&color=yellow|12-C++-Templates, p.14]]
> > using function_type = OUT (\*)(IN);
> 
> das ist einfach irgendeine Funktion (eine funktion ist ja ein Pointer, daher der Stern)

> [!PDF|yellow] [[12-C++-Templates.pdf#page=16&selection=9,0,11,18&color=yellow|12-C++-Templates, p.15]]
> > void swap(T& a, T& b) {
> 
> setzt voraus, dass es einen Zuweisungs bzw. Kopierkonstruktor für den Typ gibt - bei uniqueptr z.B. nicht, dann würde das fehlschlagen!


> [!PDF|yellow] [[12-C++-Templates.pdf#page=17&selection=19,0,24,1&color=yellow|12-C++-Templates, p.16]]
> > `void print(T first, Types... rest) { std::print("{}, ", first); print(rest...); }`
> 
> zur Compilezeit ist der Typ hier für jeden Typ bekannt, d.h. dass eine variable Anzahl von Parametern trotzdem typsicher ist




