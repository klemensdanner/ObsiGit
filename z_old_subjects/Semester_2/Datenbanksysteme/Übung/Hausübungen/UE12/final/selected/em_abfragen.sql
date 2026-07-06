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
        NVL2(MName, MName || ' (' || Preis || ' €)', '0 €') AS MerchandiseInfo
FROM Veranstaltung
    LEFT JOIN MerchandiseArtikel USING (VID)
ORDER BY VName ASC, Preis DESC;

-- 4

SELECT KNr, Geburtsdatum, EMail
FROM Kunde
    JOIN Premiumkunde USING (KNr)
    JOIN Account USING (KNr)
WHERE Geburtsdatum > TO_DATE('01-01-1985', 'DD-MM-YYYY')
    AND Passwort IS NULL;


--5
SELECT DISTINCT SName AS Saalname
FROM Saal
    JOIN Sitzplatz USING (SNr, VOName)
    JOIN Ticket USING (PNr, SNr, VOName)
    JOIN reserviert USING (TNr);


-- 6
SELECT MANr, Vorname, Nachname, COUNT(DISTINCT VOName) AS Anzahl_Veranstaltungsorte
FROM Mitarbeiter
    JOIN Anstellung USING (MANr)
GROUP BY MANr, Vorname, Nachname
HAVING COUNT(DISTINCT VOName) > 1
ORDER BY Nachname;


-- 7
SELECT VOName, COUNT(DISTINCT MANr)
FROM Veranstaltungsort
    JOIN Anstellung USING (VOName)
GROUP BY VOName
HAVING COUNT(DISTINCT MANr) > 2;




--8. 

-- filtert nach der maximalen Anzahl an Funktionen.
-- Annahme: Arbeitsstelle := Funktion
SELECT DISTINCT MANR, VORNAME, NACHNAME 
  FROM MITARBEITER JOIN Anstellung USING (MANR) 
 WHERE MANR IN (SELECT MANR
                 FROM Mitarbeiter JOIN Anstellung USING (MANR)
                 GROUP BY MANR
                 HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                                           FROM Mitarbeiter JOIN Anstellung USING (MANR)
                                           GROUP BY MANR)); 



--9.
SELECT DISTINCT mit.MANR, mit.VORNAME, mit.NACHNAME, COALESCE(ans.VONAME, '0')
  FROM MITARBEITER mit LEFT JOIN ANSTELLUNG ans ON (mit.MANR = ans.MANR)
 ORDER BY MANR ASC;
 


--10. 
SELECT TO_CHAR(GEBURTSDATUM, 'Dy, DD. Mon YYYY', 'NLS_DATE_LANGUAGE=German') AS Geburtsdatum 
FROM Premiumkunde
WHERE GEBURTSDATUM = (SELECT MAX(GEBURTSDATUM)
                        FROM Premiumkunde);
                        

--11. 
SELECT VORNAME, GEBURTSDATUM, ANREDE, (SYSDATE-GEBURTSDATUM) AS tage
  FROM premiumkunde JOIN anrede USING (ANREDEID)
  WHERE SYSDATE - GEBURTSDATUM < (SELECT AVG(SYSDATE - GEBURTSDATUM)
                                    FROM Premiumkunde);




--12.
SELECT VORNAME, NACHNAME, TNR, TO_CHAR(ZEITPUNKT, 'DAY, DD. Month YYYY', 'NLS_DATE_LANGUAGE=German') AS Reservierungen
  FROM Premiumkunde
        JOIN KUNDE USING (KNR)
        JOIN reserviert USING (KNr)
        JOIN Ticket t USING (TNr)
  WHERE geburtsdatum = (
      SELECT MAX(GEBURTSDATUM) AS YOUNGEST
      FROM Premiumkunde
            JOIN reserviert USING (KNR)
            JOIN Ticket tGeb USING (TNR)
      WHERE (tGeb.Beginn = t.Beginn) AND (tGeb.VID = t.VID) AND (tGeb.SNr = t.SNr) AND (tGeb.VOName = t.VOName));




--13.
SELECT VID, VNAME, DAUER, BEGINN
  FROM Veranstaltung JOIN Auffuehrung USING(VID)
  WHERE DAUER < 120 AND VID NOT IN (SELECT DISTINCT VID 
                                      FROM Veranstaltung JOIN Merchandiseartikel USING (VID)
                                      WHERE VID IS NOT NULL);

--14.
SELECT VNAME AS "Bezeichnung", ANZAHL
    FROM Veranstaltung JOIN (SELECT VID, COUNT(MNAME) AS ANZAHL
  FROM Veranstaltung JOIN merchandiseartikel USING(VID)
  GROUP BY VID
  HAVING COUNT(MNAME) = (SELECT  MIN(COUNT(MNAME)) AS "Anzahl"
                               FROM MERCHANDISEARTIKEL
                               GROUP BY VID)) USING (VID);
                               

                                      

--15.
SELECT MANR, VORNAME, NACHNAME 
FROM Mitarbeiter 
WHERE Gehalt <= 8000
    AND MANr IN (SELECT MANr
                FROM Anstellung
                GROUP BY MANR
                HAVING COUNT(DISTINCT VONAME) = (SELECT COUNT(*)
                                        FROM Veranstaltungsort));
                                          



--16.
SELECT DISTINCT VID, VNAME AS NAME 
FROM Veranstaltung JOIN Merchandiseartikel USING (VID)
WHERE Hersteller = 'MyMark' AND VID NOT IN (SELECT VID 
                                              FROM Merchandiseartikel
                                              WHERE Hersteller = 'HisMark'
                                              AND VID IS NOT NULL);


