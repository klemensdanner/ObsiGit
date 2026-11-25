deklarativ: statisch, bei DDL
Beispiel:
- foreign keys
- einfaches zurückweisen
- minimale repair möglichketien (on delete cascade, set null usw.)


#### Trigger
Trigger reagiert auf DML-Ereignisse, vorher oder nachher
oder System und benutzerereignesse
- startup, logon, shutdown, servererror
- create, alter, drop, grant etc


auf alles außer SELECT definierbar

erlaubt sind in einem Trigger (per compiler) nur SQL, PL/SQL Befehler, Aufruf gespeicherter Prozeduren/Funktionen
- keine Transaktionskontrolle (commit, rollback)
- somit keine DDL-STatements, weil diese implizit commiten

EXCEPTION:
- wenn in einem Trigger eine exception ausgelöst wird:
	- falls unbehandelt: auslösende Aktion wird zurückgesetzt
	- falls behandelt: auslösende Aktion wird durchgeführt

zusammenfassung:
CREATE TRIGGER
datenbankobjetke
Trigger wird implizit von DML aufgerufen, Trigger kann nicht explizit aufgerufen werden
in Trigger keine commits, safepoint, rollback

in einen Trigger soll nichts reingegeben werden, was unwiederruflich ist, es kann ja sein, dass es ein rollback gibt. (wenn im Trigger eine mail verschickt wird, ist die weg, kann man nicht rückgängig machen)


Trigger gehört immer zum statement
