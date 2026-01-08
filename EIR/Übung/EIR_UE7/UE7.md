a)
- Kombinatorische Schaltungen
	- Abbildung durch Wahrheitstabelle / boolsche Gleichung
	- Bsp.: Multiplexer, Decodierer, Encodierer etc.
	- komb. Schaltungen haben kein Gedächtnis
- Sequenzielle Schaltungen
	- haben Gedächtnis
	- Wert hängt vom internem Zustand ab, der im System gespeichert ist
	- wird durch Rückkopplung realisiert - Teil des Ausgangs geht wieder zurück in den Eingang
	- Beispiel:
		- Zähler
		- Endliche Automaten
		- Register
b) Welche 5 Punkte kennzeichnen einen endlichen Automaten? Beschreiben sie diese kurz.
- hat eine Menge von Zuständen (S/Q)
- Mengeneingänge (I für Inputs)
- O für Outputs
- Zustandsüberführungsfunktion
- Ausgabefunktion

c)
- Moore-Automat
	- Zustandsausgabe

### UE7.1
a)

| t   | 0   | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8   | 9   | 10  | 11  | 12  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| I   | auf | auf | auf | auf | auf | auf | auf | auf | auf | ab  | ab  | ab  | auf |
| S   | 0   | 1   | 2   | 3   | 4   | 0   | 1   | 2   | 3   | 4   | 3   | 2   | 1   |
| O   | 1   | 0   | 0   | 0   | 0   | 1   | 0   | 0   | 0   | 0   | 0   | 0   | 0   |



"Wertetabelle" 

| Zustand | auf | ab  | Lamda |
| ------- | --- | --- | ----- |
| 0       | 1   | 4   | 1     |
| 1       | 2   | 0   | 0     |
| 2       | 3   | 1   | 0     |
| 3       | 4   | 2   | 0     |
| 4       | 0   | 3   | 0     |

b)
S={0,1,2,3}
I={0,1}
O={0,1}


- [ ] #eir Übung 7; 7.0c) 7.4)
