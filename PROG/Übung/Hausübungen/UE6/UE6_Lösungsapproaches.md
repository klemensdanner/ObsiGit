
Planung:
var
	pList: BookListPtr;
InsertBook(title, author: string);

- Ist Liste leer? (pList = NIL)
	- Neuen Buchknoten erstellen + init
	- Einhängen
	- InsertAuthorNode(pAuthorList, author)
- sonst:
	- Liste iterieren (curr^.next <> nil) und (title > curr^.title) -- Einfügeposition: feststellen anhand von curr
		- Wenn title = curr^.title, dann
			- nichts tun
		- Wenn (curr^.next = nil) dann
			- HintenEinfügen()



- Ist die Hauptliste leer? (pList = NIL)
	- Dann Hauptliste auf neu erstellten Knoten zeigen lassen und Werte zuweisen und SortedInsertAuth() aufrufen
- Gibts den Knoten schon?
	- Dann nur noch SortedInsertAuth(VAR auList: AuthorNodePtr, author: string) aufrufen
- Knoten gibts noch nicht?
	- curr^.data ist > als n^.data
		- Knoten erstellen und init
		- Author einfügen mit SortedInsertAuth
		- Knoten vor *curr* einfügen



procedure SortedInsertAuth(VAR auList: AuthorNodePtr, author: string);

- Wenn auList = NIL, dann
	- Knoten erstellen + Init
	- auList := NewNodePtr
- ansonsten: Liste bis zu dem Punkt durchlaufen, wo neues Element reinmüsste //
	- Wenn Knoten schon existiert, dann
		- nichts tun
	- Wenn dort kein Knoten existiert, dann
		- Knoten erstellen + init
		- Knoten in die Liste einhängen
			- edge cases beachten:
				- vor ersten Knoten einfügen -- NewNodePtr^.next := auList; auList := NewNodePtr
				- als letzten Knoten einfügen
- Wenn curr = nil --> hinten anfügen
	- sonst:
		- 

*Bedingung: NewNodePtr  <> NIL* -- Liste nicht leer, bereits ausgeschlossen
- Wenn author ungleich curr^.name, dann
	- wenn curr = nil --> hinten einfügen
	- wenn prev = nil:
		- Schleife nie betreten --> vor erstem Element einfügen
	- ansonsten ist man irgendwo dazwischen
		- Knoten erstellen
		- Knoten einhängen
			- dabei: NewNodePtr^.next := prev^.next
			- prev^.next := NewNodePtr





wenn author = curr^.name, dann nichts tun

```
n: 3

5   10   15   20    25
```
--> nach prev und vor curr einfügen




PrintAll;
- BookList iterieren. In der Schleife immer den Titel ausgeben
- Zusätzlich in der Schleife die Funktion PrintAuthors(authorList: AuthorNodePtr) aufrufen

PrintAuthors(authorList: AuthorNodePtr)


function NrOfBooksOf(author: STRING): INTEGER;
Idee:
Hauptliste Iterieren:
- Wenn InAuthorList(pAuthorListPointer, author) = true, dann
	- Counter um 1 erhöhen
Nach der Schleife: Counter ist das Funktionsergebnis


// authorList ist nie leer

InAuthorList(authorList: AuthorNodePtr, author: string);
- Mit Schleife Liste iterieren, solange author <> curr^.name
- Dann state von curr interpretieren:
	- Wenn curr = nil, dann
		- nicht gefunden, FALSE zurückgeben
	- Ansonsten:
		- TRUE