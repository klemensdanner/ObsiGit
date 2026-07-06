
--16.
SELECT DISTINCT VID, VNAME AS NAME 
FROM Veranstaltung JOIN Merchandiseartikel USING (VID)
WHERE Hersteller = 'MyMark' AND VID NOT IN (SELECT VID 
                                              FROM Merchandiseartikel
                                              WHERE Hersteller = 'HisMark');
--15.
SELECT MANR, VORNAME, NACHNAME 
FROM Mitarbeiter 
WHERE Gehalt <= 8000
    AND MANr IN (SELECT MANr
                FROM Mitarbeiter JOIN Anstellung USING (MANR) 
                GROUP BY MANR
                HAVING COUNT(DISTINCT VONAME) = (SELECT COUNT(*)
                                        FROM Veranstaltungsort));
                                          
--14.
SELECT VNAME AS "Bezeichnung",
       ANZAHL
    FROM Veranstaltung JOIN (SELECT VID, COUNT(MNAME) AS ANZAHL
  FROM Veranstaltung JOIN merchandiseartikel USING(VID)
  GROUP BY VID
  HAVING COUNT(MNAME) = (SELECT  MIN(COUNT(MNAME)) AS "Anzahl"
                               FROM MERCHANDISEARTIKEL
                               GROUP BY VID)) USING (VID);
                               
--13.
SELECT VID, VNAME, DAUER, BEGINN
  FROM Veranstaltung JOIN Auffuehrung USING(VID)
  WHERE DAUER < 120 AND VID NOT IN (SELECT VID 
                                      FROM Veranstaltung JOIN Merchandiseartikel USING (VID));
                                      
--12. not really error proof but idk how to make it better rn
SELECT VORNAME, NACHNAME, TNR, TO_CHAR(ZEITPUNKT, 'DAY, DD.MM.YYYY')
  FROM (Premiumkunde JOIN KUNDE USING(KNR)) JOIN reserviert USING (KNr)
  WHERE geburtsdatum IN ( 
      SELECT MAX(GEBURTSDATUM) AS YOUNGEST
      FROM Premiumkunde JOIN reserviert USING (KNR) JOIN Ticket USING (TNR)
      GROUP BY VID);



--11. 
SELECT VORNAME, GEBURTSDATUM, ANREDE, (SYSDATE-GEBURTSDATUM) AS tage
  FROM premiumkunde JOIN anrede USING (ANREDEID)
  WHERE SYSDATE - GEBURTSDATUM < (SELECT AVG(SYSDATE - GEBURTSDATUM)
                                    FROM premiumkunde);

--10. 
SELECT TO_CHAR(GEBURTSDATUM, 'DY, DD. MON YYYY') 
FROM Premiumkunde
WHERE GEBURTSDATUM = (SELECT MAX(GEBURTSDATUM)
                        FROM Premiumkunde);
                        
--9.
SELECT mit.MANR, mit.VORNAME, mit.NACHNAME, COALESCE(ans.VONAME, '0')
  FROM MITARBEITER mit LEFT JOIN ANSTELLUNG ans ON (mit.MANR = ans.MANR)
 ORDER BY MANR ASC;
 
--8. 
SELECT DISTINCT MANR, VORNAME, NACHNAME 
  FROM MITARBEITER JOIN Anstellung USING (MANR) 
 WHERE MANR IN (SELECT MANR
                 FROM Mitarbeiter JOIN Anstellung USING (MANR)
                 GROUP BY MANR
                 HAVING COUNT(VONAME) = (SELECT MAX(COUNT(*))
                                           FROM Mitarbeiter JOIN Anstellung USING (MANR)
                                           GROUP BY MANR)); 

