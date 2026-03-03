Integrität der Daten sicherstellen![[M2_Datenbankentwurf_V2.9.pdf#page=3&rect=390,215,700,359|M2_Datenbankentwurf_V2.9, p.3]]

### Datenbankschema
- wird formal beschrieben und stellt die Integrität der Daten sicher
- Regeln stellen sicher, dass Daten in einem gültigen Zustand sind
- Daten die diesen Regeln widersprechen können nicht eingefügt werden
- das Schema ist sozusagen der "Compiler"

#### DB-Schema-Regeln
- definieren gültige Datenobjekte
- definieren Beziehungen zwischen den Daten (z.B. Student - Prüfung)
- müssen für alle möglichen Daten gelten, also vollständige Regeln
- werden in formaler Sprache definiert (Data Definition Language)
- vermeiden Redundanz!

Daten die diesen Regeln nicht entsprechen, können nicht eingefügt werden

#### Erstellung des DB-Schemas

- zu berücksichtigende Aspekte
	- welche Datne sind relevant
	- Eigenschaften
	- Beziehungen

> Diese muss man planen, weil man oft nicht alle Aspekte gleichzeitig direkt in formaler Sprache zu definieren

Nach dem Requirements Engineering muss ein konzeptionelles DB-Schema erstellt werden, dann logisches DB-Schema, dann Physisches DB-Schema (die eigentliche Realisierung).


#### Konzeptionelles Datenmodell
- relativ technikfrei
- Modell: vereinfachte Abbildung der Wirklichkeit
- Datenmodellierung erfordert eine Einarbeitung in die Domäne, um zu entscheiden, welche Eigenschaften zu speichern sind
- gespeichert wird das was nicht anderswo bezogen werden kann oder aus anderen Datenbankeinträgen berechnet werden
- Beschrieben wird ein Modell mit ER-Modellen


#### Entity-Relationship-Modell

- Objekte und deren Beziehungen werden definiert
- Typen fassen Entitäten nach Eigenschaften zusammen
- Primärschlüssel ist identifizierend für jede Entität
	- Schlüssel muss eindeutig sein
	- Schlüssel muss es für jede Entität existieren
	- bei mehreren möglichen Schlüsseln soll der gewählt werden, der im Kontext relevant ist (z.B. bei Studenten Matrikelnummer statt Sozialversicherungsnummer)

#### Kardinalitäten

> [!note]
> mit wievielen Entitäten der anderen Entitätsmenge steht etwas maximal in Beziehung

Kardinalitäten werden definiert und werden ins Schema aufgenommen.
Anzahl der beteiligeten Entitätstypen bezeichnet die Stelligkeit.

Es können auch mehrere binäre Beziehungen zwischen mehreren Typen existieren.


| 1:1 unäre Beziehung | Kurs ist Nachfolgekurs von einem anderen kurs |
| ------------------- | --------------------------------------------- |
| n:1 binär           |                                               |
| 1:n binär           |                                               |

Vorlesung - lesen - Professor (n:1)
d.h. n Vorlesungen - wird gelesen von - 1 Professor
z.B. Abfrage: wieviele Vorlesungen lest 1 Professor
aber auch Abfrage: Welcher Professor lest eine bestimmte Vorlesung




























