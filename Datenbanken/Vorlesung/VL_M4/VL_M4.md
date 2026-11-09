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

Benutzer benötigt Systemrechte (vom Datenbank-Admin) und Objektrechte (Rechte oft vom Ersteller, abhängig von Sicherheitsmodell)

#### Sicherheitsmodelle
- Discretionary Access Control – DAC 
	- Eigentümer (oder Admin) vergibt Zugriffsrechte auf Objekte
	- Standard
	- Explizite Autorisierung durch Regeln: Der Zugriff auf ein Objekt o kann nur erfolgen, wenn für das Subjekt s ein Zugriffsrecht r vorliegt
	- wird gespeichert in einer großen Tabelle
- Mandatory Access Control – MAC
	- Zentrales System verwaltet Zugriffsrechte - Militärbereich z.B. 
- Role Based Access Control – RBAC
	- Benutzer erhalten Zugriffsrechte über Rollenmitgliedschaften
siehe [[ObsiGit/Datenbanken/Vorlesung/VL_M5/M5 Datensicherheit.pdf#page=10&selection=10,0,10,17&color=yellow|M5 Datensicherheit, p.10]]

Der DBA (DatenbankAdmin) kann Rechte granten, mit:
```
GRANT <Systemrecht> (, <Systemrecht>)* TO (<Benutzer> (, <Benutzer>)*) | PUBLIC;

z.B.

GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW TO altmann;
```


### Objektrechte
Objektrechte werden vom Ersteller oder Admin vergeben, z.B. ALTER, DELETE, INDEX, INSERT, usw.

WITH GRAND OPTION ermöglicht die Weitergabe von Rechten
siehe: [[ObsiGit/Datenbanken/Vorlesung/VL_M5/M5 Datensicherheit.pdf#page=18&selection=12,0,16,7&color=yellow|M5 Datensicherheit, p.18]]

Benutzer können Sichten freigeben und brauchen dabei keinen Zugriff auf die Basistabellen


Objektrechte können entzogen werden.
Was aber mit weitergegebenen Rechten?
entweder der Entzugsantrag wird abgelehnt (RESTRICT) oder allen Benutzern denen Rechte weitergegeben wurden, werden ebenfalls eingeschränkt (CASCADE)
siehe: [[ObsiGit/Datenbanken/Vorlesung/VL_M5/M5 Datensicherheit.pdf#page=23&selection=12,0,16,6&color=yellow|M5 Datensicherheit, p.23]]


### Rollenbasierte Authorisierung (RBAC)


## Auditing
Datenbankereignisse können gelogged werden mit `AUDIT`

z.B.:
```sql
AUDIT INSERT, UPDATE, DELETE ON Professor WHENEVER [NOT] SUCCESSFUL;

NOAUDIT INSERT, UPDATE, DELETE ON Professor;
```

nicht zu viel mitloggen - Operationen können verlangsamt werden und große Protokolldateien sind schwerer analysierbar



lofi prototype
aktualisierte doku