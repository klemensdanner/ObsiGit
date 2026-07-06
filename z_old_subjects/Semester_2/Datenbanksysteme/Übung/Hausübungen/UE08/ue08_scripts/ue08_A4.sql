-- 1

SELECT VorlNr, Titel
FROM Studenten JOIN hoeren USING (MatrNr)
     JOIN Vorlesungen USING (VorlNr)
WHERE Name = 'Carnap';


--2 

SELECT v2.Titel
FROM Vorlesungen v1 -- v1 ist der Nachfolger
     JOIN voraussetzen vr ON v1.VorlNr = vr.Nachfolger
     JOIN Vorlesungen v2 ON vr.Vorgaenger = v2.VorlNr -- v2 ist der Vorgänger
WHERE v1.Titel = 'Ethik';


--3

SELECT PersNr
FROM Professoren
MINUS
SELECT Boss
FROM Assistenten;
