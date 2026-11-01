
- geordnete Probe: Reihenfolge relevant
	- mit Wiederholung
		- Reihenfolge ist relevant und mit Wiederholung, d.h. ein Element kann mehrmals ausgewählt werden, z.B. Fahrradzahlenschloss (gleiche Ziffer kann mehrmals vorkommen, wie 3-3-2 oder 4-4-4)
		- Reihenfolge wichtig, weil 3-3-2 ungleich 2-3-3
		- Berechnung: n^k 
	- ohne Wiederholung
		- Reihenfolge relevant
		- aber ohne Wiederholung, d.h. ein Element kann nicht mehrmals gewählt werden
		- Skifahren - wer von den 20 LäuferInnen steht am Stockerl (1, 2. oder 3. Platz?)
			- hier ist die Reihenfolge relevant - man will 1. sein und nicht 2.
			- ohne Wiederholung, weil ein Läufer nicht gleichzeitig 1. und 2. sein kann. ist er bereits 1. kann er nicht mehr 2. werden. --- also ohne Wiederholung
		- Berechnung
			- 20\*19\*18 --> 20!/(20-3)! --> (n!)/(n-k)!
- ungeordnete Probe: Reihenfolge irrelevant
	- mit Wiederholung
		- Reihenfolge der Auswahl irrelevant und es kann das selbe mehrmals gewählt werden
		- Beispiel Eisbecher mit 5 Kugeln aus 3 verfügbaren Eissorten zusammenstellen
			- Reihenfolge irrelevant: egal ob zuerst Vanille und dann Zitrone -- selbe schüssel
			- mit Wiederholung: man kann mehrmals die selbe Sorte nehmen, z.b. 3 mal vanilleeis
			- Lösung mitels cleverer Abstraktion:
				- Man unterteilt in "Schachteln" mit Trennstrichen: zwischen den Trennstrichen legt man jeweils die Kugeln Eis.
				- Wieviele Anordnungen der Trennstriche (oder der 5 Kugeln eis) gibt es, aus der gesamten Menge der Trennstriche und Kugeln?
				- ---> genau AnzTrennstriche + AnzAuswahl über AnzTrennstriche = AnzTrennstriche + AnzAuswahl über AnzAuswahl; also hier in diesem Beispiel: (2 + 5) über 5 oder (2+5) über 2 = 21 mögliche
	- ohne Wiederholung
		- vgl. geordnete Probe ohne Wiederholung --- Ist es nur relevant wer am Stockerl steht aber die genaue Platzierung nicht, dividiert man durch k!, also 3!, weil es 3! Anordnungen des Stockerls gibt, welche dann "zu viel" im Ergebnis wären.
		- daraus entsteht (20\*19\*18) / 3!, allgemein (n!)/((n-k)!\*k!)), also genau n über k



außerdem gibt es die
Permutation
- ohne Wiederholung
	- geordnete Probe ohne Wiederholung mit n = k
- mit Wiederholung
	- analog, nur dass einzelne Optionen mehrmals vorkommen können bzw. bei der Aufgabenstellung irrelevant sind
	- vgl.: Anzahl der Anodnungen der Buchstaben HAGENBERG
		- Wieviele Anordnungen gibt es? 9 Buchstaben, wenn alle unterschiedlich wären dann wärs Permutation ohne WH, also 9!
		- hier ist das E und das G aber ununterscheidbar, es kommt jeweils 2 mal vor.
		- 9! sind also um den Faktor 2! \* 2! zu viel (Anzahl der Anordnungen der beiden E und G) zu viel
		- ---> es folgt daraus: 9! / (2! \* 2!) gibt die Anzahl der vernünftigen Anordnungen wenn zwischen gleichen Buchstaben kein Unterschied gemacht wird
		- bei AABCC wärs z.B. 5! / (2! \* 2!)