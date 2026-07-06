-- Transaktionen können mit COMMIT, ROLLBACK und SAVEPOINT gesteuert werden:
-- COMMIT: Schreibt alle noch nicht gespeicherten Änderungen dauerhaft fest.
-- ROLLBACK: Verwirft alle noch nicht gespeicherten Datenänderungen.
-- SAVEPOINT: Wird für ein Rollback zur Savepoint-Markierung verwendet.

-- *************************************************
-- BEISPIELE zu INSERT, UPDATE, DELETE
-- **************************************************

CREATE TABLE test (svnr NUMBER(9), name VARCHAR2(50));
ALTER TABLE test ADD CONSTRAINT test_pk PRIMARY KEY(svnr);
ALTER TABLE test MODIFY(name VARCHAR2(50) NOT NULL);

-- COMMIT und ROLLBACK anhand eines zweiten Accounts testen
-- SQLDeveloper: Tastenkombination Strg+Shift+N erzeugt neue Session für
-- aktuellen Benutzer

-- ausführen in Session 1 (Session 2 führt nach jedem Statement SELECT * FROM test; aus)
INSERT INTO test (svnr, name) VALUES(1, 'Altmann');
COMMIT;
UPDATE test SET name = 'Altmann Josef' WHERE svnr = 1;
COMMIT;
DELETE FROM test WHERE svnr = 1;
COMMIT;
DROP TABLE test;


-- Tabelle aus bestehender Tabelle erzeugen:
-- Erzeugt eine Tabelle mit allen 'Sales Representatives' aus der
-- Tabelle EMPLOYEES
CREATE TABLE copy_emp AS
SELECT employee_id, last_name, job_id, salary, department_id
  FROM employees
 WHERE job_id = 'SA_REP';

SELECT * FROM copy_emp;

-- Zeilen aus anderen Tabellen kopieren:
-- Einfügen aller Programmierer aus EMPLOYEES, wobei die Abteilung
-- nicht mitkopiert wird
INSERT INTO copy_emp (employee_id, last_name, job_id, salary)
SELECT employee_id, last_name, job_id, salary
  FROM employees
 WHERE job_id = 'IT_PROG';

SELECT * FROM copy_emp;

-- Markieren eines SAVEPOINT
SAVEPOINT after_insert;

-- Spalten basieren auf Daten einer anderen Tabelle aktualisieren:
-- Aktualisieren der Abteilungsnummer und des Gehalts für die IT-Programmierer
-- aus der Tabelle employees
UPDATE copy_emp
   SET department_id = (SELECT DISTINCT department_id           -- Achtung, hier darf nur ein Wert zurückgegeben werden
                          FROM employees
                         WHERE job_id = 'IT_PROG'),
        salary = (SELECT MAX(salary) + 1000
                    FROM employees
                  WHERE job_id = 'IT_PROG')
  WHERE job_id = 'IT_PROG';

SELECT * FROM copy_emp;

-- Zurücknehmen der aktualisierten Daten bis zum Makierungspunkt
ROLLBACK TO after_insert;

SELECT * FROM copy_emp;

-- Festschreiben der Daten
COMMIT;

-- Löschen der IT-Programmierer
DELETE FROM copy_emp
 WHERE job_id = 'IT_PROG';

SELECT * FROM copy_emp;

-- Löscht alle Zeilen aus copy_emp
DELETE FROM copy_emp;

SELECT * FROM copy_emp;

-- Zurücknehmen der Änderung bis zum letzten COMMIT
ROLLBACK;
SELECT * FROM copy_emp;



-- *************************************************
-- EXKURS: DELETE versus TRUNCATE
-- **************************************************

-- Weil Datenbanken in der Regel alle Zeilenlöschungen protokollieren
-- müssen, kann es sehr zeitaufwändig und mit vielen "Kosten"
-- verbunden sein, mit einem DELETE alle Zeilen aus einer Tabelle zu
-- entfernen.
-- Löschen aller Daten in der Tabelle copy_emp mit TRUNCATE ist effizienter
-- als DELETE, kann aber nicht mehr zurückgenommen werden, da es sich um eine DDL-Anweisung handelt
-- und ein implizites COMMIT erfolgt. Ein TRUNCATE erfolgt praktisch unmittelbar
-- und ist endgültig.
TRUNCATE TABLE copy_emp;

SELECT * FROM copy_emp;

ROLLBACK;

SELECT * FROM copy_emp;

DROP TABLE copy_emp;
