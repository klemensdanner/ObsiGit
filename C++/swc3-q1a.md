# SWC3.1 Quiz 1 - 'C'

* Datum: 9. Nov. 2026
* Erlaubte Unterlange: Online-Referenz https://cppreference.com/c
* Nachname: Danner
* Vorname: Klemens



# Längster gemeinsamer Präfix

* Entwickeln Sie ein einfache C-Funktion, die von zwei C-Zeichenketten den längsten gemeinsamen Präfix bestimmt, z.B.

```c
   common\\\\\\\_prefix(3, "ABC", 3, "ABD") // -> "AB"
   common\\\\\\\_prefix(3, "XYZ", 3, "ABD") // -> ""
   ```

* a) Welche Fehlersituationen und Randfälle können auftreten und wie könnte damit umgegangen werden? (1 Punkt)

  * Schwierigkeiten bei leeren strings -- aufpassen auf off by ones
  * null übergeben -- eingabe prüfen
  * prefix kann nur so lange sein wie der kürzeste beider strings
* b) Implementieren Sie die Funktion, die eine dynamisch allokierte Kopie des längsten gemeinsamen Präfix zurückliefert und folgende Schnittstelle besitzt: (3 Punkte)



```c

\\\&#x09;int min(int a, int b) {

\\\&#x09;	if (a <= b) return a;

\\\&#x09;	return b;

\\\&#x09;}


        char\\\\\\\* common\\\\\\\_prefix(size\\\\\\\_t len\\\\\\\_a, char a\\\\\\\[static len\\\\\\\_a], size\\\\\\\_t len\\\\\\\_b, char b\\\\\\\[static len\\\\\\\_b]) {
            // TODO

&#x09;if (a == nullptr || b == nullptr) return null;

\\\&#x09;	// speicher für result allokieren

\\\&#x09;	int res\_len = min(len\_a, len\_b) + 1;

\\\&#x09;	char\* result = malloc(res\_len \* sizeof(char)); // len\_a hat \\0 nicht dabie
		// result durchlaufen - wenn wert gleich, dann hinzufügen; sonst return realloc(result, new\\\\\\\_size)


&#x09;int i = 0;
\\\&#x09;	for (; i < res\_len; ++i) {

\\\&#x09;		if (a\[i] == b\[i]) {

\\\&#x09;			result\[i] = a\[i];

&#x09;		
\\\&#x09;		} else {

&#x09;		result\[i] = '\\0';

&#x09;		return realloc(result, i+1);

&#x09;	}
\\\&#x09;	} // end for

	return realloc(result, i+1);


\\\&#x20;       }
        ```

\\\* c) Schreiben einen regulären Testfall und 1 Randfall jeweils mit Consolen-Ausgabe und erwartetem Resultat. (2 Punkte)

```c
        int main() {
            // TODO

&#x09;

&#x09;char a\[] = "ABC";

&#x09;char b\[] = "ABD";
	char\* test = common\_prefix(3, a, 3, b);

&#x09;printf("%s", test);



&#x09;// randfall:

&#x09;char\* test1 = common\_prefix(0, "", 3, b);

&#x09;printf("%s", test);



&#x09;	




	free(a);

&#x09;free(b);

&#x09;free(test);

&#x09;free(test1);
        }
        ```



