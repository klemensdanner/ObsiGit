-- =====================================================================
-- KÜNSTLICHE SCHLÜSSEL in Oracle - Skript zum Selbststudium (UE04, Aufgabe 4)
--
-- Inhalt:
--   Teil 0: Was ist ein künstlicher Schlüssel?
--   Teil 1: SEQUENCE anlegen, NEXTVAL und CURRVAL
--   Teil 2: Sequences sind NICHT lückenlos
--   Teil 3: Optionen einer Sequence
--   Teil 4: Sequence als DEFAULT-Wert einer Spalte
--   Teil 5: IDENTITY-Spalten
-- =====================================================================

-- =====================================================================
-- Teil 0: Was ist ein künstlicher Schlüssel?
-- =====================================================================
-- Ein künstlicher Schlüssel (Surrogatschlüssel) ist ein Primärschlüssel
-- OHNE fachliche Bedeutung, meist eine fortlaufende Zahl, die vom DBMS
-- vergeben wird (z.B. customer_id, film_id in Sakila).
--
-- Gegenstück: natürlicher Schlüssel = fachliches Attribut, das schon
-- eindeutig ist (z.B. Matrikelnummer, ISBN, KFZ-Kennzeichen).
--
-- Warum künstliche Schlüssel?
--   - natürliche Schlüssel können sich ändern (Kennzeichen, E-Mail, Name)
--   - natürliche Schlüssel sind oft lang oder zusammengesetzt (langsame Joins)
--   - manchmal gibt es gar keinen eindeutigen natürlichen Schlüssel
--
-- In Oracle werden künstliche Schlüssel mit einer SEQUENCE erzeugt:
-- einem eigenen Datenbankobjekt, das bei jedem Aufruf eine neue Zahl liefert.


-- =====================================================================
-- Teil 1: SEQUENCE anlegen, NEXTVAL und CURRVAL
-- =====================================================================
CREATE SEQUENCE demo_seq
  START WITH 1      -- erste vergebene Zahl
  INCREMENT BY 1;   -- Schrittweite

-- Fehler ORA-08002: CURRVAL ist erst verfügbar, nachdem in DIESER Session
-- mindestens einmal NEXTVAL aufgerufen wurde.
SELECT demo_seq.CURRVAL FROM dual;

-- NEXTVAL: erhöht die Sequence und liefert den neuen Wert (1, 2, 3, ...)
-- Mehrmals ausführen!
SELECT demo_seq.NEXTVAL FROM dual;

-- CURRVAL: liefert den zuletzt in DIESER Session mit NEXTVAL geholten Wert.
-- Andere Sessions (andere Benutzer*innen) haben ihren eigenen CURRVAL.
SELECT demo_seq.CURRVAL FROM dual;

-- Typische Verwendung: im INSERT
CREATE TABLE demo_kunde (
  kunde_id INT PRIMARY KEY,
  name     VARCHAR2(50)
);

INSERT INTO demo_kunde VALUES (demo_seq.NEXTVAL, 'Huber');
INSERT INTO demo_kunde VALUES (demo_seq.NEXTVAL, 'Mayr');
SELECT * FROM demo_kunde;
COMMIT;

-- Wo darf NEXTVAL/CURRVAL stehen? (Auszug aus der Oracle-Doku)
--   erlaubt:  VALUES-Teil eines INSERT, SELECT-Liste eines INSERT ... SELECT,
--             SET-Teil eines UPDATE, SELECT-Liste eines einfachen SELECT
--   verboten: in Views, in WHERE, mit DISTINCT/GROUP BY/ORDER BY,
--             bei UNION/INTERSECT/MINUS, in CHECK-Constraints
--   https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/Sequence-Pseudocolumns.html


-- =====================================================================
-- Teil 2: Sequences sind NICHT lückenlos
-- =====================================================================
-- Ein mit NEXTVAL geholter Wert ist "verbraucht" - auch wenn die
-- Transaktion danach mit ROLLBACK zurückgenommen wird.
INSERT INTO demo_kunde VALUES (demo_seq.NEXTVAL, 'Wird zurückgerollt');
ROLLBACK;

INSERT INTO demo_kunde VALUES (demo_seq.NEXTVAL, 'Gruber');
SELECT * FROM demo_kunde ORDER BY kunde_id;   -- Lücke in kunde_id!

-- Weitere Ursachen für Lücken: CACHE (vorgeholte Werte gehen z.B. bei
-- einem Neustart der Datenbank verloren), gelöschte Datensätze, ...
--
-- FOLGERUNG: Aus einem künstlichen Schlüssel darf man NICHTS ableiten,
-- z.B. NICHT "höchste ID = Anzahl der Kund*innen".
-- Wer lückenlose Nummern braucht (z.B. Rechnungsnummern laut Gesetz),
-- darf dafür keine Sequence verwenden.


-- =====================================================================
-- Teil 3: Optionen einer Sequence (mit Default-Werten)
-- =====================================================================
-- Alle Optionen sind optional. Wird eine Option weggelassen, gilt der Default.
--
--   Option             Bedeutung                                  Default
--   -----------------  -----------------------------------------  ---------------------------
--   START WITH n       erste vergebene Zahl                       MINVALUE (meist 1)
--   INCREMENT BY n     Schrittweite (auch negativ möglich)        1
--   MINVALUE n         kleinster erlaubter Wert                   1
--   MAXVALUE n         größter erlaubter Wert                     NOMAXVALUE, praktisch unbegrenzt
--   CYCLE | NOCYCLE    was passiert, wenn MAXVALUE erreicht ist?  NOCYCLE
--   CACHE n | NOCACHE  wie viele Werte im Speicher vorhalten?     CACHE 20
--
-- Was bewirken die Optionen?
--   NOCYCLE   bei Erreichen von MAXVALUE -> Fehler ORA-08004, keine weitere Zahl
--   CYCLE     bei Erreichen von MAXVALUE wieder bei MINVALUE beginnen
--             (ACHTUNG: dann entstehen DOPPELTE Werte -> für Primärschlüssel praktisch nie sinnvoll!)
--   CACHE n   n Werte werden im Voraus im Arbeitsspeicher reserviert:
--             schneller bei vielen gleichzeitigen Zugriffen, aber bei einem
--             Neustart der Datenbank gehen nicht verwendete Werte verloren (Lücken)
--   NOCACHE   jeder Wert wird einzeln geholt: langsamer, dafür weniger Lücken
--
--
-- Die Optionen einer Sequence im Data Dictionary ansehen (Ausblick UE05).
-- demo_seq aus Teil 1 wurde ohne MINVALUE/MAXVALUE/CYCLE/CACHE angelegt -> Defaults:
SELECT sequence_name, min_value, max_value, increment_by, cycle_flag, cache_size
FROM user_sequences
WHERE sequence_name = 'DEMO_SEQ';

-- Mini-Sequence mit nur 3 Werten, um das Verhalten von NOCYCLE/CYCLE zu sehen:
CREATE SEQUENCE demo_mini_seq
  START WITH 500
  MINVALUE 500
  MAXVALUE 502
  NOCACHE
  NOCYCLE;

SELECT demo_mini_seq.NEXTVAL FROM dual;  -- 500
SELECT demo_mini_seq.NEXTVAL FROM dual;  -- 501
SELECT demo_mini_seq.NEXTVAL FROM dual;  -- 502
SELECT demo_mini_seq.NEXTVAL FROM dual;  -- Fehler ORA-08004: MAXVALUE erreicht

-- Dasselbe mit CYCLE: nach 502 kommt wieder 500 (MINVALUE, nicht START WITH!)
CREATE SEQUENCE demo_cycle_seq
  START WITH 500
  MINVALUE 500
  MAXVALUE 502
  NOCACHE
  CYCLE;

SELECT demo_cycle_seq.NEXTVAL FROM dual;  -- 500, 501, 502, 500, ... (mehrmals ausführen)


-- =====================================================================
-- Teil 4: Sequence als DEFAULT-Wert einer Spalte (ab Oracle 12c)
-- =====================================================================
-- Statt NEXTVAL in jedem INSERT anzugeben, kann die Sequence als
-- Default-Wert der Spalte hinterlegt werden.
CREATE SEQUENCE demo_auftrag_seq START WITH 500000 MAXVALUE 599999;

CREATE TABLE demo_auftrag (
  auftrag_id INT DEFAULT demo_auftrag_seq.NEXTVAL PRIMARY KEY,
  text       VARCHAR2(50)
);

INSERT INTO demo_auftrag (auftrag_id, text) VALUES (DEFAULT, 'mit DEFAULT');
INSERT INTO demo_auftrag (text)             VALUES ('Spalte weggelassen');
INSERT INTO demo_auftrag (auftrag_id, text) VALUES (42, 'händisch - ist erlaubt!');
SELECT * FROM demo_auftrag;


-- =====================================================================
-- Teil 5: IDENTITY-Spalten (ab Oracle 12c)
-- =====================================================================
-- Oracle legt die Sequence automatisch an und verknüpft sie mit der Spalte.
--   GENERATED ALWAYS AS IDENTITY      -> Wert IMMER von Oracle (händisch verboten)
--   GENERATED BY DEFAULT AS IDENTITY  -> Oracle vergibt, wenn kein Wert angegeben wird
-- Die Sequence-Optionen aus Teil 3 können in Klammern angegeben werden.
CREATE TABLE demo_rechnung (
  rechnung_id INT GENERATED ALWAYS AS IDENTITY
                  (START WITH 700000 MAXVALUE 799999)
                  PRIMARY KEY,
  betrag      NUMBER(10,2)
);

INSERT INTO demo_rechnung (betrag) VALUES (99.90);
INSERT INTO demo_rechnung (betrag) VALUES (15.00);
SELECT * FROM demo_rechnung;

-- Fehler ORA-32795: bei GENERATED ALWAYS ist ein händischer Wert verboten
INSERT INTO demo_rechnung (rechnung_id, betrag) VALUES (1, 10.00);

-- ---------------------------------------------------------------------
-- Die automatisch erzeugte Sequence im Data Dictionary (Ausblick UE05)
-- ---------------------------------------------------------------------
-- Oracle hat für die IDENTITY-Spalte eine eigene Sequence angelegt.
-- Sie ist im Schema sichtbar, ihr Name beginnt mit ISEQ$$_ :
SELECT object_name, object_type
FROM user_objects
WHERE object_type = 'SEQUENCE';

-- Informationen über IDENTITY-Spalten: welche Tabelle, welche Spalte,
-- ALWAYS oder BY DEFAULT, und wie die zugehörige Sequence heißt
SELECT table_name, column_name, generation_type, sequence_name
FROM user_tab_identity_cols;

-- Optionen der Identity-Sequences (nur Sequences, die zu IDENTITY-Spalten gehören)
-- Spalte last_number:
--   a) ohne CACHE: zuletzt vergebene Zahl, die auf die Festplatte geschrieben wurde
--   b) mit CACHE:  höchste Zahl, die bereits in den Cache geholt wurde
--      (kann also größer sein als die tatsächlich zuletzt vergebene Zahl!)
SELECT sequence_name, min_value, max_value, increment_by, cycle_flag, cache_size, last_number
FROM user_sequences
WHERE sequence_name IN (SELECT sequence_name
                        FROM user_tab_identity_cols);

-- Aktueller Wert der Identity-Sequence in dieser Session:
-- Den Namen aus der vorherigen Abfrage einsetzen
SELECT ISEQ$$_116424.CURRVAL FROM dual;

-- Wird die Tabelle mit PURGE gelöscht, verschwindet auch die Identity-Sequence
-- (Kontrolle siehe Ende des Skripts).

-- =====================================================================
-- Aufräumen
-- =====================================================================
DROP TABLE demo_kunde;
DROP TABLE demo_auftrag;
DROP TABLE demo_rechnung PURGE;
DROP SEQUENCE demo_seq;
DROP SEQUENCE demo_mini_seq;
DROP SEQUENCE demo_cycle_seq;
DROP SEQUENCE demo_auftrag_seq;

-- Kontrolle: Alle Sequences sind weg, auch die ISEQ$$_-Sequence der
-- IDENTITY-Spalte (wurde mit DROP TABLE ... PURGE automatisch gelöscht)
SELECT object_name, object_type
FROM user_objects
WHERE object_type = 'SEQUENCE';
