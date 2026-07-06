
INSERT INTO Funktion (FID, Funktionsbezeichnung)
    VALUES (1, 'Hilfskraft');
INSERT INTO Funktion (FID, Funktionsbezeichnung)
    VALUES (2, 'Kassa');

INSERT INTO Mitarbeiter (MANR, Vorname, Nachname, Gehalt)
    VALUES (1, 'Markus', 'Mayer', NULL); -- 1 ist Hilfskraft
INSERT INTO Mitarbeiter (MANR, Vorname, Nachname, Gehalt)
    VALUES (2, 'Guenther', 'Herman', NULL);
INSERT INTO Mitarbeiter (MANR, Vorname, Nachname, Gehalt)
    VALUES (3, 'Herbert', 'Bauer', 660);
INSERT INTO Mitarbeiter (MANR, Vorname, Nachname, Gehalt)
    VALUES (4, 'Melanie', 'Mauer', NULL);


INSERT INTO Veranstaltungsort (VOName, MANr)
    VALUES ('Metro Kino', 2); -- das von Guenther Herman geleitet wird
INSERT INTO Veranstaltungsort (VOName, MANr)
    VALUES ('Stadttheater', NULL);



INSERT INTO Anstellung (VOName, MANr, FID)
    VALUES ('Metro Kino', 1, 1); -- Markus Mayer arbeitet bei Metro Kino
INSERT INTO Anstellung (VOName, MANr, FID)
    VALUES ('Metro Kino', 3, 2);
INSERT INTO Anstellung (VOName, MANr, FID)
    VALUES ('Stadttheater', 3, 2);



INSERT INTO Saal (VOName, SNr, SName)
    VALUES ('Metro Kino', 1, 'Hauptsaal');
INSERT INTO Saal (VOName, SNr, SName)
    VALUES ('Metro Kino', 2, 'Nebensaal1');
INSERT INTO Saal (VOName, SNr, SName)
    VALUES ('Metro Kino', 3, 'Nebensaal2');





--------------------------




INSERT INTO Veranstaltung
VALUES (1, 'The Birds', 'The birds is something abt birds', 119);

INSERT INTO Veranstaltung
VALUES (2, 'Vertigo', 'The Vertigo is something abt the vertigo', 103);

INSERT INTO Veranstaltung
VALUES (3, 'The Man Who Knew Too Much', 'wouldnt you like to know', 129);

INSERT INTO Veranstaltung
VALUES (4, 'Klassik-Konzert', 'a classical concert, mozart inclusive', 200);

INSERT INTO Kunde
VALUES (1, 'Mayer');

INSERT INTO Premiumkunde (KNR, VORNAME, NACHNAME, GEBURTSDATUM)
VALUES (1, 'Melanie', 'Mayer', TO_DATE('12.03.1989', 'DD.MM.YYYY'));

INSERT INTO Account (EMAIL)
VALUES ('melanie.mayer@gmx.at'); --nicht in der angabe

INSERT INTO Bestellung (BNR, EMAIL, ZEITPUNKT)
VALUES(1, 'melanie.mayer@gmx.at', SYSDATE);

INSERT INTO MerchandiseArtikel
VALUES ('tb-tee_mymark','MyMark', 25, 'the bird is the word shirt', 1);

INSERT INTO enthaelt
VALUES (1, 'tb-tee_mymark', 'MyMark', 1);




--------------------------------------


-- ============================================================
-- 3. Anrede (bisher 0 Datensätze -> 5 neue)
-- ============================================================
INSERT INTO Anrede (AnredeID, Anrede) VALUES (1, 'Herr');
INSERT INTO Anrede (AnredeID, Anrede) VALUES (2, 'Frau');
INSERT INTO Anrede (AnredeID, Anrede) VALUES (3, 'Divers');
INSERT INTO Anrede (AnredeID, Anrede) VALUES (4, 'Dr.');
INSERT INTO Anrede (AnredeID, Anrede) VALUES (5, 'Prof.');

-- ============================================================
-- 2. Funktion (bisher 2 Datensätze -> 3 neue)
-- ============================================================
INSERT INTO Funktion (FID, Funktionsbezeichnung) VALUES (3, 'Technik');
INSERT INTO Funktion (FID, Funktionsbezeichnung) VALUES (4, 'Security');
INSERT INTO Funktion (FID, Funktionsbezeichnung) VALUES (5, 'Reinigung');

-- ============================================================
-- 5. Mitarbeiter (bisher 4 Datensätze -> 1 neuer)
-- ============================================================
INSERT INTO Mitarbeiter (MANr, Vorname, Nachname, Gehalt) VALUES (5, 'Anna', 'Schuster', 3200);

-- ============================================================
-- 7. Veranstaltungsort (bisher 2 Datensätze -> 3 neue)
-- ============================================================
INSERT INTO Veranstaltungsort (VOName, MANr) VALUES ('Open Air Arena', 4);
INSERT INTO Veranstaltungsort (VOName, MANr) VALUES ('Kulturhaus', 1);
INSERT INTO Veranstaltungsort (VOName, MANr) VALUES ('Kabarett Keller', 3);

-- ============================================================
-- 18. Anstellung (bisher 3 Datensätze -> 2 neue)
-- ============================================================
INSERT INTO Anstellung (VOName, MANr, FID) VALUES ('Open Air Arena', 4, 3);
INSERT INTO Anstellung (VOName, MANr, FID) VALUES ('Kulturhaus', 1, 1);

-- ============================================================
-- 8. Saal (bisher 3 Datensätze -> 2 neue)
-- ============================================================
INSERT INTO Saal (VOName, SNr, SName) VALUES ('Stadttheater', 1, 'Theatersaal');
INSERT INTO Saal (VOName, SNr, SName) VALUES ('Open Air Arena', 1, 'Festwiese');

-- ============================================================
-- 9. Sitzplatz (bisher 0 Datensätze -> 5 neue)
-- ============================================================
INSERT INTO Sitzplatz (PNr, SNr, VOName) VALUES (101, 1, 'Metro Kino');
INSERT INTO Sitzplatz (PNr, SNr, VOName) VALUES (102, 2, 'Metro Kino');
INSERT INTO Sitzplatz (PNr, SNr, VOName) VALUES (103, 3, 'Metro Kino');
INSERT INTO Sitzplatz (PNr, SNr, VOName) VALUES (104, 1, 'Stadttheater');
INSERT INTO Sitzplatz (PNr, SNr, VOName) VALUES (105, 1, 'Open Air Arena');

-- ============================================================
-- 1. Veranstaltung (bisher 4 Datensätze -> 1 neuer)
-- ============================================================
INSERT INTO Veranstaltung (VID, VName, Beschreibung, Dauer) VALUES 
(5, 'Die Zauberflöte', 'Eine weltbekannte Oper von Wolfgang Amadeus Mozart', 150);

-- ============================================================
-- 4. Kunde (bisher 1 Datensatz -> 4 neue)
-- ============================================================
INSERT INTO Kunde (KNr, Nachname) VALUES (2, 'Schmidt');
INSERT INTO Kunde (KNr, Nachname) VALUES (3, 'Fischer');
INSERT INTO Kunde (KNr, Nachname) VALUES (4, 'Weber');
INSERT INTO Kunde (KNr, Nachname) VALUES (5, 'Mueller');

-- ============================================================
-- 6. Premiumkunde (bisher 1 Datensatz -> 4 neue)
-- ============================================================
INSERT INTO Premiumkunde (KNr, Vorname, Nachname, Geburtsdatum, Telefon, Adresse, AnredeID) VALUES 
(2, 'Johannes', 'Schmidt', TO_DATE('15.05.1990', 'DD.MM.YYYY'), '+43664111111', 'Hauptstraße 5, 1010 Wien', 1);
INSERT INTO Premiumkunde (KNr, Vorname, Nachname, Geburtsdatum, Telefon, Adresse, AnredeID) VALUES 
(3, 'Sabine', 'Fischer', TO_DATE('22.11.1982', 'DD.MM.YYYY'), '+43664222222', 'Bahngasse 12, 8010 Graz', 2);
INSERT INTO Premiumkunde (KNr, Vorname, Nachname, Geburtsdatum, Telefon, Adresse, AnredeID) VALUES 
(4, 'Gerald', 'Weber', TO_DATE('03.04.1975', 'DD.MM.YYYY'), '+43664333333', 'Steingasse 1, 4020 Linz', 1);
INSERT INTO Premiumkunde (KNr, Vorname, Nachname, Geburtsdatum, Telefon, Adresse, AnredeID) VALUES 
(5, 'Lisa', 'Mueller', TO_DATE('30.08.1995', 'DD.MM.YYYY'), '+43664444444', 'Waldweg 8, 5020 Salzburg', 2);

-- ============================================================
-- 10. Account (bisher 1 Datensatz -> 4 neue)
-- ============================================================
INSERT INTO Account (EMail, Passwort, KNr) VALUES ('johannes.schmidt@gmx.at', 'pw_schmidt', 2);
INSERT INTO Account (EMail, Passwort, KNr) VALUES ('sabine.fischer@gmx.at', 'pw_fischer', 3);
INSERT INTO Account (EMail, Passwort, KNr) VALUES ('gerald.weber@gmx.at', 'pw_weber', 4);
INSERT INTO Account (EMail, Passwort, KNr) VALUES ('lisa.mueller@gmx.at', 'pw_mueller', 5);

-- ============================================================
-- 11. Bestellung (bisher 1 Datensatz -> 4 neue)
-- ============================================================
INSERT INTO Bestellung (BNr, EMail, Zeitpunkt, Anmerkungen) VALUES 
(2, 'johannes.schmidt@gmx.at', TO_TIMESTAMP('2023-10-02 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO Bestellung (BNr, EMail, Zeitpunkt, Anmerkungen) VALUES 
(3, 'sabine.fischer@gmx.at', TO_TIMESTAMP('2023-10-03 14:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Lieferung dringend erwünscht.');
INSERT INTO Bestellung (BNr, EMail, Zeitpunkt, Anmerkungen) VALUES 
(4, 'gerald.weber@gmx.at', TO_TIMESTAMP('2023-10-04 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO Bestellung (BNr, EMail, Zeitpunkt, Anmerkungen) VALUES 
(5, 'lisa.mueller@gmx.at', TO_TIMESTAMP('2023-10-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), NULL);

-- ============================================================
-- 12. MerchandiseArtikel (bisher 1 Datensatz -> 4 neue)
-- ============================================================
INSERT INTO MerchandiseArtikel (MName, Hersteller, Preis, Beschreibung, VID) VALUES 
('vertigo-poster', 'MyMark', 15.00, 'Klassisches Filmposter zum Film Vertigo', 2);
INSERT INTO MerchandiseArtikel (MName, Hersteller, Preis, Beschreibung, VID) VALUES 
('man-who-knew-mug', 'ClassicGifts', 10.50, 'Kaffeetasse mit berühmtem Filmzitat', 3);
INSERT INTO MerchandiseArtikel (MName, Hersteller, Preis, Beschreibung, VID) VALUES 
('mozart-cd', 'SonyClassic', 18.00, 'CD mit den bekanntesten Werken von Mozart', 4);
INSERT INTO MerchandiseArtikel (MName, Hersteller, Preis, Beschreibung, VID) VALUES 
('opera-glasses', 'OpticsCorp', 45.00, 'Hochwertiges Opernglas für Theateraufführungen', 5);

-- ============================================================
-- 13. Auffuehrung (bisher 0 Datensätze -> 5 neue)
-- ============================================================
INSERT INTO Auffuehrung (Beginn, VID, SNr, VOName, Plakat) VALUES 
(TO_TIMESTAMP('2023-12-01 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1, 'Metro Kino', 'http://example.com/birds.jpg');
INSERT INTO Auffuehrung (Beginn, VID, SNr, VOName, Plakat) VALUES 
(TO_TIMESTAMP('2023-12-02 18:30:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 2, 'Metro Kino', 'http://example.com/vertigo.jpg');
INSERT INTO Auffuehrung (Beginn, VID, SNr, VOName, Plakat) VALUES 
(TO_TIMESTAMP('2023-12-03 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 3, 'Metro Kino', 'http://example.com/manwhoknew.jpg');
INSERT INTO Auffuehrung (Beginn, VID, SNr, VOName, Plakat) VALUES 
(TO_TIMESTAMP('2023-12-04 19:30:00', 'YYYY-MM-DD HH24:MI:SS'), 4, 1, 'Stadttheater', 'http://example.com/klassik.jpg');
INSERT INTO Auffuehrung (Beginn, VID, SNr, VOName, Plakat) VALUES 
(TO_TIMESTAMP('2023-12-05 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 5, 1, 'Open Air Arena', 'http://example.com/magicflute.jpg');

-- ============================================================
-- 14. verkauft_in (bisher 0 Datensätze -> 5 neue)
-- ============================================================
INSERT INTO verkauft_in (MName, Hersteller, VOName, Lagerstand) VALUES 
('tb-tee_mymark', 'MyMark', 'Metro Kino', 100);
INSERT INTO verkauft_in (MName, Hersteller, VOName, Lagerstand) VALUES 
('vertigo-poster', 'MyMark', 'Metro Kino', 50);
INSERT INTO verkauft_in (MName, Hersteller, VOName, Lagerstand) VALUES 
('man-who-knew-mug', 'ClassicGifts', 'Metro Kino', 30);
INSERT INTO verkauft_in (MName, Hersteller, VOName, Lagerstand) VALUES 
('mozart-cd', 'SonyClassic', 'Stadttheater', 80);
INSERT INTO verkauft_in (MName, Hersteller, VOName, Lagerstand) VALUES 
('opera-glasses', 'OpticsCorp', 'Open Air Arena', 15);

-- ============================================================
-- 17. enthaelt (bisher 1 Datensatz -> 4 neue)
-- ============================================================
INSERT INTO enthaelt (BNr, MName, Hersteller, Stuekzahl) VALUES (2, 'vertigo-poster', 'MyMark', 1);
INSERT INTO enthaelt (BNr, MName, Hersteller, Stuekzahl) VALUES (3, 'man-who-knew-mug', 'ClassicGifts', 2);
INSERT INTO enthaelt (BNr, MName, Hersteller, Stuekzahl) VALUES (4, 'mozart-cd', 'SonyClassic', 1);
INSERT INTO enthaelt (BNr, MName, Hersteller, Stuekzahl) VALUES (5, 'opera-glasses', 'OpticsCorp', 1);

-- ============================================================
-- 15. Ticket (bisher 0 Datensätze -> 5 neue)
-- ============================================================
INSERT INTO Ticket (TNr, Beginn, VID, SNr, VOName, BNr, PNr) VALUES 
(80001, TO_TIMESTAMP('2023-12-01 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 1, 'Metro Kino', 1, 101);
INSERT INTO Ticket (TNr, Beginn, VID, SNr, VOName, BNr, PNr) VALUES 
(80002, TO_TIMESTAMP('2023-12-02 18:30:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 2, 'Metro Kino', 2, 102);
INSERT INTO Ticket (TNr, Beginn, VID, SNr, VOName, BNr, PNr) VALUES 
(80003, TO_TIMESTAMP('2023-12-03 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 3, 'Metro Kino', 3, 103);
INSERT INTO Ticket (TNr, Beginn, VID, SNr, VOName, BNr, PNr) VALUES 
(80004, TO_TIMESTAMP('2023-12-04 19:30:00', 'YYYY-MM-DD HH24:MI:SS'), 4, 1, 'Stadttheater', 4, 104);
INSERT INTO Ticket (TNr, Beginn, VID, SNr, VOName, BNr, PNr) VALUES 
(80005, TO_TIMESTAMP('2023-12-05 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 5, 1, 'Open Air Arena', 5, 105);

-- ============================================================
-- 16. reserviert (bisher 0 Datensätze -> 5 neue)
-- ============================================================
INSERT INTO reserviert (TNr, KNr, Zeitpunkt) VALUES 
(80001, 1, TO_TIMESTAMP('2023-10-01 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO reserviert (TNr, KNr, Zeitpunkt) VALUES 
(80002, 2, TO_TIMESTAMP('2023-10-02 09:30:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO reserviert (TNr, KNr, Zeitpunkt) VALUES 
(80003, 3, TO_TIMESTAMP('2023-10-03 13:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO reserviert (TNr, KNr, Zeitpunkt) VALUES 
(80004, 4, TO_TIMESTAMP('2023-10-04 15:45:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO reserviert (TNr, KNr, Zeitpunkt) VALUES 
(80005, 5, TO_TIMESTAMP('2023-10-05 08:30:00', 'YYYY-MM-DD HH24:MI:SS'));



SELECT * FROM Account;
SELECT * FROM Account;

SELECT Vorname, Nachname, MANr
FROM Mitarbeiter
    JOIN Anstellung USING (MANr)
WHERE FID = 1;