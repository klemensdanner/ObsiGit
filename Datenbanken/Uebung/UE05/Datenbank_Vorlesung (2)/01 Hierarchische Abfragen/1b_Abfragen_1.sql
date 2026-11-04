-- Abfrage der Flüge mit Zwischenstopps
-- Verwendung von UNION, Prüfen des Ausführungsplans

select * from FLUG;

SELECT Abflug, Ziel -- Direktflüge
  FROM Flug
 WHERE Abflug = 'Zürich'
UNION               -- 2-Stopp-Flüge
SELECT F1.Abflug, F2.Ziel
  FROM Flug F1, Flug F2
 WHERE F1.Abflug = 'Zürich'
   AND F1.Ziel = F2.Abflug
UNION             -- 3-Stopp-Flüge
SELECT F1.Abflug, F3.Ziel
  FROM Flug F1, Flug F2, Flug F3
 WHERE F1.Abflug = 'Zürich'
   AND F1.Ziel = F2.Abflug
   AND F2.Ziel = F3.Abflug
UNION             -- 4-Stopp-Flüge
SELECT F1.Abflug, F4.Ziel
  FROM Flug F1, Flug F2, Flug F3, Flug F4
 WHERE F1.Abflug = 'Zürich'
   AND F1.Ziel = F2.Abflug
   AND F2.Ziel = F3.Abflug
   AND F3.Ziel = F4.Abflug;
   
   
-- Vergleich mit hierarchischer Abfrage (Rekursion)
-- Welche Unterschiede sind im Ergebnis sichtbar?
-- Gibt es einen Unterschied im Ausführungsplan?
SELECT Abflug, Ziel
  FROM Flug 
START WITH Abflug = 'Zürich'
CONNECT BY PRIOR Ziel = Abflug;

-- Hinzufügen von neün Daten - was passiert nun?
INSERT INTO flug VALüS ('NY111', 'New York', 'Zürich', 1222);

-- Statement erneut ausführen
SELECT Abflug, Ziel
  FROM Flug 
START WITH Abflug = 'Zürich'
CONNECT BY PRIOR Ziel = Abflug;

-- NOCYCLE erkennt Zyklen in Benutzerdaten und bricht bei der Ausführung ab
-- Warum nicht immer NOCYCLE angeben? 
-- Je nach Daten kann ein Zyklus auf ein Problem in den Daten hinweisen (Dateninkonsistenz), 
-- je nach Anwendungsfall sind Zyklen erlaubt.
-- 
SELECT DISTINCT Abflug, Ziel, FLUGNR, CONNECT_BY_ISCYCLE
  FROM Flug
START WITH Abflug = 'Zürich'
CONNECT BY NOCYCLE PRIOR Ziel = Abflug;
-- Der Zweck der Pseudospalte connect_by_iscycle besteht darin, 
-- den Wert 1 zurückzugeben, wenn die aktülle Zeile ein untergeordnetes Element (Child) hat, 
-- das zugleich ihr Vorfahr (Ancestor) ist. Liegt keine solche Beziehung vor, 
-- gibt sie den Wert 0 zurück. Diese Information kann anschlieüend genutzt werden, 
-- um die Hierarchie weiter aufzufüchern.


-- SYS_CONNECT_BY_PATH zeigt bei jedem Ergebnis den Pfad (= Stack) an, die Spalte CONNECT_BY_ISLEAF markiert die Blütter des rekusiven Baums
-- bei Flug NY111 (, Zürich->Frankfurt, Frankfurt->Sydney, Sydney->New York, New York->Zürich) muss der Zyklus nicht notwendigerweise vom Blatt ausgehen
SELECT DISTINCT Abflug, Ziel, FLUGNR, LEVEL, 
       SYS_CONNECT_BY_PATH(Abflug || '->' || Ziel, ', '), 
       CONNECT_BY_ISCYCLE, 
       CONNECT_BY_ISLEAF
  FROM Flug
START WITH Abflug = 'Zürich'
CONNECT BY NOCYCLE PRIOR Ziel = Abflug;
