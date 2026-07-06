-- 1
SELECT VID, VName, Beschreibung
FROM Veranstaltung
WHERE Dauer BETWEEN 60 AND 120;

-- 2
SELECT Vorname, Nachname, EMail
FROM Premiumkunde
    JOIN Kunde USING (KNr)
    JOIN Account USING (KNr)
WHERE Vorname LIKE 'M%' AND Nachname LIKE 'M%';


-- 3
SELECT VName AS VeranstaltungsName,
        NVL2(MName, MName || ' (' || Preis || '€ )', '0€') AS MerchandiseInfo
FROM Veranstaltung
    LEFT JOIN MerchandiseArtikel USING (VID)
ORDER BY VName ASC, Preis DESC;

-- 4

SELECT KNr, Geburtsdatum, EMail, Passwort
FROM Kunde
    JOIN Premiumkunde USING (KNr)
    JOIN Account USING (KNr)
WHERE Geburtsdatum > TO_DATE('01.01.1985', 'DD.MM.YYYY')
    AND Passwort IS NULL;


--5
SELECT DISTINCT SName AS Saalname
FROM Saal
    JOIN Sitzplatz USING (SNr, VOName)
    JOIN Ticket USING (PNr, SNr, VOName);


-- 6
SELECT MANr, Vorname, Nachname, COUNT(*) AS Anzahl_Veranstaltungsorte
FROM Mitarbeiter
    JOIN Anstellung USING (MANr)
GROUP BY MANr, Vorname, Nachname
HAVING COUNT(*) > 1
ORDER BY Nachname;


-- 7
SELECT VOName
FROM Veranstaltungsort
    JOIN Anstellung USING (VOName)
GROUP BY VOName
HAVING COUNT(*) > 2;