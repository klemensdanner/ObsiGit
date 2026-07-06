-- *********************************************************************
-- BEISPIEL zur MERGE-Anweisung
-- *********************************************************************

-- Die MERGE-Anweisung (INSERT, UPDATE und DELETE in einem Befehl) ist
-- erst in den Standard SQL2003 aufgenommen worden und fügt Daten in Tabellen
-- ein oder ändert oder löscht sie, je nachdem, ob die Daten schon als
-- Datensatz vorhanden sind oder nicht.
-- Die MERGE-Anweisung ist eine sehr mächtige und performante Anweisung
-- um Ladeprozesse im Data Warehouse-Bereich zu unterstützen.
-- Effizienter als PL/SQL-Schleifenkonstrukte und auch einfacher wartbar.

-- SYNTAX: Mit der MERGE-Anweisung kann man Zeilen bedingungsabhängig
-- hinzufügen, löschen oder aktualisieren. Für die Syntax gilt:
-- INTO-Klausel gibt die Zieltabelle an, deren Daten aktualisiert oder
-- ergänzt werden.
-- USING-Klausel gibt die Quelle der zu aktualisierenden oder einzufügenden
-- Daten an. Dies kann eine Tabelle, View oder Unterabfrage sein.
-- ON-Klausel gibt die Bedingung an, gemäß welcher der MERGE-Vorgang eine
-- Aktualisierung oder Einfügung durchführt.
-- WHEN [NOT] MATCHED weist den Server an, wie auf die Ergebnisse der
-- Join-Bedingung reagiert werden soll.

-- HINWEIS: Man kann keine Spalte aktualisieren, die in der ON-Klausel
-- referenziert wird!
-- HINWEIS: eine Zeile kann nur einmal im Statement betroffen/bearbeitet werden
-- sie kann also nicht in MATCHED und NOT MATCHED vorkommen
-- HINWEIS: DELETE kann nur im MATCHED-Block vorkommen

-- BEISPIEL: Für weiterführende Data Warehouse-Auswertungen soll eine
-- Tabelle Pruefungsstatistik erstellt werden. Diese Tabelle soll
-- zu jedem Professor die Anzahl der abgenommenen Prüfungen verwalten.
-- Die Tabelle Pruefungsstatistik soll monatlich aktualisiert werden.
-- Es soll die Bedingung erfüllt werden, dass Professor 2126 nicht in die
-- Statistik aufgenommen werden soll bzw. wenn in Pruefungsstatistik schon
-- enthalten, dann soll er gelöscht werden.

SELECT PersNr, Name, COUNT(*) AS PrfAnzahl
  FROM pruefen
       INNER JOIN Professoren USING (PersNr)
GROUP BY PersNr, Name;

CREATE TABLE pruefungsstatistik (
  PersNr INTEGER PRIMARY KEY,
  Anzahl INTEGER);

INSERT INTO pruefungsstatistik VALUES(2126, 20);
-- 2126 darf im MERGE-Ergebnis nicht aufscheinen
INSERT INTO pruefungsstatistik VALUES(2125, 0);
-- 2125 muss im MERGE-Ergebnis aktualisiert werden

SELECT persnr, name, Anzahl
 FROM pruefungsstatistik
       INNER JOIN professoren USING (PersNr);

-- change comment of WHERE NOT (PersNr = 2126) to show that 2126 has to be
-- affected in "MATCHED" to be deleted
MERGE	INTO pruefungsstatistik ziel
USING (
  SELECT PersNr, COUNT(*) AS PrfAnzahl
  FROM pruefen
  WHERE PersNr != 2126
  GROUP BY PersNr) quelle
ON (ziel.PersNr = quelle.PersNr)
WHEN MATCHED THEN
  UPDATE SET ziel.Anzahl = quelle.PrfAnzahl
  DELETE WHERE ziel.PersNr = 2126
WHEN NOT MATCHED THEN
  INSERT (PersNr, Anzahl)
  VALUES (quelle.PersNr, quelle.PrfAnzahl)
  WHERE NOT (quelle.PersNr = 2126)
  ;

SELECT persnr, name, Anzahl
  FROM pruefungsstatistik
       INNER JOIN professoren USING (PersNr);

DROP TABLE pruefungsstatistik;

-- siehe auch unter:
-- https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/MERGE.html
-- http://www.oracle.com/ocom/groups/public/@otn/documents/webcontent/1359936.html