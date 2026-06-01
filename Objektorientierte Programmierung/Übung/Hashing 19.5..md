der log ist die Stelligkeit einer Zahl (z.b. hat eine 5 stellige zahl den log_10 von 5)

Anzahl der Zeichenketten, bei max. 20 Zeichen ist zum Beispiel (AnzahlChars) ^ 20, d.h. z.B. 30^20 ---- rieeeesige Zahl
Man braucht also eine Abbildung von dieser riesigen Menge auf einen definierten Wertebereich von ints, z.b. 1 bis 9999.

Hashfunktion Möglichkeiten
- alle char ordinalwerte addieren
	- Probleme: relativ aufwendig (alle chars durchgehen), nicht gut verteilt, Reihenfolge kann verdreht werden etc.



### Kollissionsbehandlungsmethoden

#### Chaining