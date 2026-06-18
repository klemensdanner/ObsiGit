
INSERT INTO Funktion (FID, Funktionsbezeichnung)
    VALUES (1, 'Hilfskraft');
INSERT INTO Funktion (FID, Funktionsbezeichnung)
    VALUES (2, 'Kassa');

INSERT INTO Mitarbeiter (MANR, Vorname, Nachname, Gehalt)
    VALUES (1, 'Markus', 'Mayer', 1400); -- 1 ist Hilfskraft
INSERT INTO Mitarbeiter (MANR, Vorname, Nachname, Gehalt)
    VALUES (2, 'Guenther', 'Herman', 1800);
INSERT INTO Mitarbeiter (MANR, Vorname, Nachname, Gehalt)
    VALUES (3, 'Herbert', 'Bauer', 660);
INSERT INTO Mitarbeiter (MANR, Vorname, Nachname, Gehalt)
    VALUES (4, 'Melanie', 'Mauer', 2400);


INSERT INTO Veranstaltungsort (VOName, LeiterNr)
    VALUES ('Metro Kino', 2); -- das von Guenther Herman geleitet wird
INSERT INTO Veranstaltungsort (VOName, LeiterNr)
    VALUES ('Stadttheater', 4);



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

INSERT INTO Premiumkunde (KNR, VORNAME, GEBURTSDATUM)
VALUES (1, 'Melanie', TO_DATE('12.03.1989', 'DD.MM.YYYY'));

INSERT INTO Account (EMAIL, Passwort)
VALUES ('melanie.mayer@gmx.at', 'meliPass123'); --nicht in der angabe

INSERT INTO Bestellung (BNR, EMAIL, ZEITPUNKT)
VALUES(1, 'melanie.mayer@gmx.at', SYSDATE);

INSERT INTO MerchandiseArtikel
VALUES ('tb-tee_mymark','MyMark', 25, 'the bird is the word shirt', 1);

INSERT INTO enthaelt
VALUES (1, 'tb-tee_mymark', 'MyMark', 1);




-- Erweiterungen:



-- Anrede
INSERT INTO Anrede (AnredeID, Anrede)
    VALUES (1, 'Sehr geehrter Herr Dr. ');
INSERT INTO Anrede (AnredeID, Anrede)
    VALUES (2, 'Sehr geehrte Frau Dr. ');
INSERT INTO Anrede (AnredeID, Anrede)
    VALUES (3, 'Guten Tag ');
INSERT INTO Anrede (AnredeID, Anrede)
    VALUES (4, 'Hallo ');
INSERT INTO Anrede (AnredeID, Anrede)
    VALUES (5, 'Servus ');

-- Mitarbeiter
INSERT INTO Mitarbeiter (MANr, Vorname, Nachname, Gehalt)
    VALUES (5, 'Martin', 'Müller', 3500);
INSERT INTO Mitarbeiter (MANr, Vorname, Nachname, Gehalt)
    VALUES (6, 'Maria', 'Maier', 7500);
INSERT INTO Mitarbeiter (MANr, Vorname, Nachname, Gehalt)
    VALUES (7, 'Stefan', 'Gruber', 9000);

-- Veranstaltungsort
INSERT INTO Veranstaltungsort (VOName, LeiterNr)
    VALUES ('Opera House', 5);
INSERT INTO Veranstaltungsort (VOName, LeiterNr)
    VALUES ('Concert Hall', 6);
INSERT INTO Veranstaltungsort (VOName, LeiterNr)
    VALUES ('Open Air Arena', 7);

-- Funktion
INSERT INTO Funktion (FID, Funktionsbezeichnung)
    VALUES (3, 'Techniker');
INSERT INTO Funktion (FID, Funktionsbezeichnung)
    VALUES (4, 'Security');
INSERT INTO Funktion (FID, Funktionsbezeichnung)
    VALUES (5, 'Manager');

-- Anstellung
INSERT INTO Anstellung (VOName, MANr, FID)
    VALUES ('Metro Kino', 6, 5);
INSERT INTO Anstellung (VOName, MANr, FID)
    VALUES ('Stadttheater', 6, 5);
INSERT INTO Anstellung (VOName, MANr, FID)
    VALUES ('Opera House', 6, 5);
INSERT INTO Anstellung (VOName, MANr, FID)
    VALUES ('Concert Hall', 6, 5);
INSERT INTO Anstellung (VOName, MANr, FID)
    VALUES ('Open Air Arena', 6, 5);
INSERT INTO Anstellung (VOName, MANr, FID)
    VALUES ('Concert Hall', 3, 2);
INSERT INTO Anstellung (VOName, MANr, FID)
    VALUES ('Metro Kino', 5, 3);
INSERT INTO Anstellung (VOName, MANr, FID)
    VALUES ('Stadttheater', 5, 3);

-- Saal
INSERT INTO Saal (VOName, SNr, SName)
    VALUES ('Stadttheater', 1, 'Bühne A');
INSERT INTO Saal (VOName, SNr, SName)
    VALUES ('Stadttheater', 2, 'Bühne B');
INSERT INTO Saal (VOName, SNr, SName)
    VALUES ('Opera House', 1, 'Großer Saal');
INSERT INTO Saal (VOName, SNr, SName)
    VALUES ('Concert Hall', 1, 'Symphonie Saal');
INSERT INTO Saal (VOName, SNr, SName)
    VALUES ('Open Air Arena', 1, 'Haupttribüne');

-- Sitzplatz
INSERT INTO Sitzplatz (PNr, SNr, VOName)
    VALUES (1, 1, 'Metro Kino');
INSERT INTO Sitzplatz (PNr, SNr, VOName)
    VALUES (2, 2, 'Metro Kino');
INSERT INTO Sitzplatz (PNr, SNr, VOName)
    VALUES (3, 1, 'Stadttheater');
INSERT INTO Sitzplatz (PNr, SNr, VOName)
    VALUES (4, 1, 'Opera House');
INSERT INTO Sitzplatz (PNr, SNr, VOName)
    VALUES (5, 1, 'Concert Hall');
INSERT INTO Sitzplatz (PNr, SNr, VOName)
    VALUES (6, 1, 'Open Air Arena');

-- Veranstaltung
INSERT INTO Veranstaltung (VID, VName, Beschreibung, Dauer)
    VALUES (5, 'Psycho', 'A thriller by Alfred Hitchcock', 109);
INSERT INTO Veranstaltung (VID, VName, Beschreibung, Dauer)
    VALUES (6, 'Rear Window', 'A photographer spy thriller', 112);
INSERT INTO Veranstaltung (VID, VName, Beschreibung, Dauer)
    VALUES (7, 'North by Northwest', 'Action adventure thriller', 136);

-- Kunde
INSERT INTO Kunde (KNr, Nachname)
    VALUES (2, 'Mustermann');
INSERT INTO Kunde (KNr, Nachname)
    VALUES (3, 'Müller');
INSERT INTO Kunde (KNr, Nachname)
    VALUES (4, 'Schmidt');
INSERT INTO Kunde (KNr, Nachname)
    VALUES (5, 'Gruber');
INSERT INTO Kunde (KNr, Nachname)
    VALUES (6, 'Hofer');

-- Premiumkunde
UPDATE Premiumkunde SET AnredeID = 3 WHERE KNr = 1;

INSERT INTO Premiumkunde (KNr, Vorname, Geburtsdatum, Telefon, Adresse, AnredeID)
    VALUES (2, 'Max', TO_DATE('15.05.1995', 'DD.MM.YYYY'), '12345', 'Mustergasse 1', 1);
INSERT INTO Premiumkunde (KNr, Vorname, Geburtsdatum, Telefon, Adresse, AnredeID)
    VALUES (3, 'Martin', TO_DATE('10.10.1982', 'DD.MM.YYYY'), '23456', 'Müllerweg 2', 1);
INSERT INTO Premiumkunde (KNr, Vorname, Geburtsdatum, Telefon, Adresse, AnredeID)
    VALUES (4, 'Anna', TO_DATE('20.02.1999', 'DD.MM.YYYY'), '34567', 'Schmidtplatz 3', 2);
INSERT INTO Premiumkunde (KNr, Vorname, Geburtsdatum, Telefon, Adresse, AnredeID)
    VALUES (5, 'Lisa', TO_DATE('05.07.2001', 'DD.MM.YYYY'), '45678', 'Grubergasse 4', 2);

-- Account
UPDATE Account SET KNr = 1 WHERE EMail = 'melanie.mayer@gmx.at';

INSERT INTO Account (EMail, Passwort, KNr)
    VALUES ('max.mustermann@gmx.at', NULL, 2);
INSERT INTO Account (EMail, Passwort, KNr)
    VALUES ('martin.mueller@gmx.at', 'secure123', 3);
INSERT INTO Account (EMail, Passwort, KNr)
    VALUES ('anna.schmidt@gmx.at', 'annaPass', 4);
INSERT INTO Account (EMail, Passwort, KNr)
    VALUES ('lisa.gruber@gmx.at', 'lisaPass', 5);



-- Bestellung
INSERT INTO Bestellung (BNr, EMail, Zeitpunkt)
    VALUES (2, 'max.mustermann@gmx.at', SYSDATE - 9);
INSERT INTO Bestellung (BNr, EMail, Zeitpunkt)
    VALUES (3, 'martin.mueller@gmx.at', SYSDATE - 8);
INSERT INTO Bestellung (BNr, EMail, Zeitpunkt)
    VALUES (4, 'anna.schmidt@gmx.at', SYSDATE - 7);
INSERT INTO Bestellung (BNr, EMail, Zeitpunkt)
    VALUES (5, 'lisa.gruber@gmx.at', SYSDATE - 6);

-- MerchandiseArtikel
INSERT INTO MerchandiseArtikel (MName, Hersteller, Preis, Beschreibung, VID)
    VALUES ('vertigo-poster', 'MyMark', 15.50, 'Vertigo movie poster', 2);
INSERT INTO MerchandiseArtikel (MName, Hersteller, Preis, Beschreibung, VID)
    VALUES ('vertigo-cup', 'HisMark', 10.00, 'Vertigo branded cup', 2);
INSERT INTO MerchandiseArtikel (MName, Hersteller, Preis, Beschreibung, VID)
    VALUES ('psycho-curtain', 'MyMark', 45.00, 'Psycho shower scene curtain', 5);
INSERT INTO MerchandiseArtikel (MName, Hersteller, Preis, Beschreibung, VID)
    VALUES ('rear-window-binoc', 'HisMark', 80.00, 'Rear Window binocular replica', 6);

INSERT INTO MerchandiseArtikel (MName, Hersteller, Preis, Beschreibung, VID)
    VALUES ('little-game-boy', 'HisMark', 50.00, 'little dog to play around with', 7);


-- verkauft_in
INSERT INTO verkauft_in (MName, Hersteller, VOName, Lagerstand)
    VALUES ('tb-tee_mymark', 'MyMark', 'Metro Kino', 100);
INSERT INTO verkauft_in (MName, Hersteller, VOName, Lagerstand)
    VALUES ('vertigo-poster', 'MyMark', 'Metro Kino', 50);
INSERT INTO verkauft_in (MName, Hersteller, VOName, Lagerstand)
    VALUES ('vertigo-cup', 'HisMark', 'Metro Kino', 30);
INSERT INTO verkauft_in (MName, Hersteller, VOName, Lagerstand)
    VALUES ('psycho-curtain', 'MyMark', 'Stadttheater', 20);
INSERT INTO verkauft_in (MName, Hersteller, VOName, Lagerstand)
    VALUES ('rear-window-binoc', 'HisMark', 'Opera House', 5);

-- enthaelt
INSERT INTO enthaelt (BNr, MName, Hersteller, Stuekzahl)
    VALUES (2, 'vertigo-poster', 'MyMark', 2);
INSERT INTO enthaelt (BNr, MName, Hersteller, Stuekzahl)
    VALUES (3, 'vertigo-cup', 'HisMark', 1);
INSERT INTO enthaelt (BNr, MName, Hersteller, Stuekzahl)
    VALUES (4, 'psycho-curtain', 'MyMark', 1);
INSERT INTO enthaelt (BNr, MName, Hersteller, Stuekzahl)
    VALUES (5, 'rear-window-binoc', 'HisMark', 1);

-- Auffuehrung
INSERT INTO Auffuehrung (Beginn, VID, SNr, VOName, Plakat)
    VALUES (TO_TIMESTAMP('15.06.2026 18:00:00', 'DD.MM.YYYY HH24:MI:SS'), 1, 1, 'Metro Kino', 'poster1.jpg');
INSERT INTO Auffuehrung (Beginn, VID, SNr, VOName, Plakat)
    VALUES (TO_TIMESTAMP('16.06.2026 20:00:00', 'DD.MM.YYYY HH24:MI:SS'), 2, 1, 'Metro Kino', 'poster2.jpg');
INSERT INTO Auffuehrung (Beginn, VID, SNr, VOName, Plakat)
    VALUES (TO_TIMESTAMP('17.06.2026 19:30:00', 'DD.MM.YYYY HH24:MI:SS'), 5, 1, 'Stadttheater', 'poster5.jpg');
INSERT INTO Auffuehrung (Beginn, VID, SNr, VOName, Plakat)
    VALUES (TO_TIMESTAMP('18.06.2026 19:30:00', 'DD.MM.YYYY HH24:MI:SS'), 6, 1, 'Opera House', 'poster6.jpg');
INSERT INTO Auffuehrung (Beginn, VID, SNr, VOName, Plakat)
    VALUES (TO_TIMESTAMP('19.06.2026 21:00:00', 'DD.MM.YYYY HH24:MI:SS'), 3, 1, 'Concert Hall', 'poster3.jpg');

-- Ticket
INSERT INTO Ticket (TNr, Beginn, VID, SNr, VOName, BNr, PNr)
    VALUES (101, TO_TIMESTAMP('15.06.2026 18:00:00', 'DD.MM.YYYY HH24:MI:SS'), 1, 1, 'Metro Kino', 1, 1);
INSERT INTO Ticket (TNr, Beginn, VID, SNr, VOName, BNr, PNr)
    VALUES (102, TO_TIMESTAMP('15.06.2026 18:00:00', 'DD.MM.YYYY HH24:MI:SS'), 1, 1, 'Metro Kino', 2, 2);
INSERT INTO Ticket (TNr, Beginn, VID, SNr, VOName, BNr, PNr)
    VALUES (103, TO_TIMESTAMP('16.06.2026 20:00:00', 'DD.MM.YYYY HH24:MI:SS'), 2, 1, 'Metro Kino', 3, 1);
INSERT INTO Ticket (TNr, Beginn, VID, SNr, VOName, BNr, PNr)
    VALUES (104, TO_TIMESTAMP('17.06.2026 19:30:00', 'DD.MM.YYYY HH24:MI:SS'), 5, 1, 'Stadttheater', 4, 3);
INSERT INTO Ticket (TNr, Beginn, VID, SNr, VOName, BNr, PNr)
    VALUES (105, TO_TIMESTAMP('18.06.2026 19:30:00', 'DD.MM.YYYY HH24:MI:SS'), 6, 1, 'Opera House', 5, 4);

-- reserviert
INSERT INTO reserviert (TNr, KNr, Zeitpunkt)
    VALUES (101, 1, TO_TIMESTAMP('14.06.2026 12:00:00', 'DD.MM.YYYY HH24:MI:SS'));
INSERT INTO reserviert (TNr, KNr, Zeitpunkt)
    VALUES (102, 2, TO_TIMESTAMP('14.06.2026 13:00:00', 'DD.MM.YYYY HH24:MI:SS'));
INSERT INTO reserviert (TNr, KNr, Zeitpunkt)
    VALUES (103, 3, TO_TIMESTAMP('15.06.2026 10:00:00', 'DD.MM.YYYY HH24:MI:SS'));
INSERT INTO reserviert (TNr, KNr, Zeitpunkt)
    VALUES (104, 4, TO_TIMESTAMP('16.06.2026 14:00:00', 'DD.MM.YYYY HH24:MI:SS'));
INSERT INTO reserviert (TNr, KNr, Zeitpunkt)
    VALUES (105, 5, TO_TIMESTAMP('17.06.2026 11:00:00', 'DD.MM.YYYY HH24:MI:SS'));


COMMIT;