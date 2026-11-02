# Materialisierte Sichten
- Sicht welche persistent gespeichert wird
- Vereinfachung, Leistungsoptimierung
- bei überwiegend lesendem Zugriff
- auf stabiler Datenbasis - sonst muss das geupdatet werden - aufwändig!

## Query Rewriting
- Der Query-Optimizer ersetzt automatisch Teile einer Abfrage, wenn es dazu bereits eine materialisierte Sicht gibt - also wenn der Teil bereits gecached ist und noch aktuell ist
- kann beim Erstellen der Sicht eingeschaltet werden

## Aktualisierungen
- wann: ON DEMAND, ON COMMIT, regelmäßig mit `START WITH date NEXT date`
- wie: COMPLETE (vollständige Neuberechnung)
	- FAST: inkrementell, durch Logs
	- FORCE: wenn möglich FAST, sonst COMPLETE
	- NEVER: keine Aktualisierung

### Nachteile und trade-offs
- mehr Speicherplatz
- nicht standardisiert
- Pflege ist eher schwierig


# Sicherheitsaskpekte
Schutz vor absichtlicher Manipulation
### Systemsicherheit
### Datensicherheit

Benutzer benötigt Systemrechte (vom Datenbank-Admin) und Objektrechte (Rechte vom Ersteller)

