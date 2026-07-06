
INSERT INTO Funktion (FID, Funktionsbezeichnung)
    VALUES (1, 'Hilfskraft');
INSERT INTO Funktion (FID, Funktionsbezeichnung)
    VALUES (3, 'Kassa');

INSERT INTO Mitarbeiter (MANR, Vorname, Nachname, FID, Gehalt)
    VALUES (1, Markus, Mayer, 1, NULL); -- 1 ist Hilfskraft
INSERT INTO Mitarbeiter (MANR, Vorname, Nachname, FID, Gehalt)
    VALUES (2, Guenther, Herman, NULL, NULL);
INSERT INTO Mitarbeiter (MANR, Vorname, Nachname, FID, Gehalt)
    VALUES (3, Herbert, Bauer, NULL, 660);
INSERT INTO Mitarbeiter (MANR, Vorname, Nachname, FID, Gehalt)
    VALUES (4, Melanie, Mauer, NULL, NULL);


INSERT INTO Veranstaltungsort (VOName, MANr)
    VALUES ('Metro Kino', 2); -- das von Guenther Herman geleitet wird
INSERT INTO Veranstaltungsort (VOName, MANr)
    VALUES ('Stadttheater', NULL);


INSERT INTO eingesetzt (VOName, MANr)
    VALUES ('Metro Kino', 1); -- Markus Mayer arbeitet bei Metro Kino
INSERT INTO eingesetzt (VOName, MANr)
    VALUES ('Stadttheater', 3);
INSERT INTO eingesetzt (VOName, MANr)
    VALUES ('Metro Kino', 3);





