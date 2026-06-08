-- *************************************************
-- BEISPIELE zur VERANSCHAULICHUNG des VIEW-KONZEPTES
-- **************************************************

-- Einfache Views: leiten Daten aus nur einer Tabelle ab,
-- DML-Operationen können über die View ausgeführt werden.
CREATE VIEW emp_department80 AS
SELECT employee_id, last_name, salary
  FROM employees
 WHERE department_id = 80;
 
SELECT * FROM emp_department80;

-- View-Attribute mit Hilfe der Spalten-Aliasnamen in der
-- Unterabfrage:
CREATE VIEW sal_department50 AS
SELECT employee_id ID_NUMBER, last_name AS name, salary*12 AS ann_salary
  FROM employees
 WHERE department_id = 50;

-- bzw. über die View-Schemadeklaration (hier durch REPLACE)
CREATE OR REPLACE VIEW sal_department50 (id_number, name, ann_salary) AS
SELECT employee_id, last_name, salary*12
  FROM employees
 WHERE department_id = 50;

-- Daten aus der View abrufen
SELECT name, ann_salary
  FROM sal_department50;

-- Ändern der View emp_department80 mit Hilfe der Klausel CREATE OR REPLACE VIEW.
-- Aliasnamen für die Spalten sind direkt nach der Viewbezeichnung angegeben
-- und sind bestimmt durch ihre Reihenfolge
CREATE OR REPLACE VIEW emp_department80 (id_number, name, sal, department_id) AS
SELECT employee_id, first_name || ' ' || last_name, salary, department_id
  FROM employees
 WHERE department_id = 80;

-- komplexe Views: leiten Daten aus mehreren Tabellen ab, DML-Operationen
-- sind nicht (immer) erlaubt.
-- Erzeugen einer View, die Gruppenfunktionen zur Anzeige von Werten aus
-- zwei Tabellen enthält:
CREATE VIEW dept_sum_view (name, minsal, maxsal, avgsal) AS
SELECT department_name, MIN(salary), MAX(salary), AVG(salary)
  FROM employees INNER JOIN departments USING(department_id)
GROUP BY department_name;

-- Versuch einer DML-Operation scheitert, da View nicht aktualisierbar ist
UPDATE dept_sum_view
   SET minsal = 2000
 WHERE name = 'Matos';
-- SQL-Fehler: ORA-01732: Datenmanipulationsoperation auf dieser View nicht zulässig
-- Hinweis auf Data Dictionary - Spalten Insertable/Updatable/Deletable

-- Klausel WITH CHECK OPTION verwenden: Mit der Klausel WITH CHECK OPTION
-- kann sichergestellt werden, dass an einer View ausgeführte
-- DML-Operationen innerhalb der Domäne der View bleiben.
CREATE OR REPLACE VIEW emp_department20 AS
SELECT *
  FROM employees
 WHERE department_id = 20
WITH CHECK OPTION CONSTRAINT emp_department20_check;

-- Der Versuch, die Abteilungsnummer für eine Zeile in der View zu ändern,
-- scheitert, da er gegen das WITH CHECK OPTION-Constraint verstößt.
-- (Die View kann die aktualisierte Zeile nicht mehr anzeigen!)
UPDATE emp_department20
   SET department_id = 10
 WHERE employee_id = 201;

-- erlaubt: Zeile kann weiterhin in der View angezeigt werden.
UPDATE emp_department20
   SET last_name = 'Dagobert'
 WHERE employee_id = 201;

-- Änderungen zurückrollen um Demo-Daten nicht zu verändern
ROLLBACK;

-- DML-Operationen verweigern
CREATE OR REPLACE VIEW emp_department10 (employee_number, employee_name, job_title) AS
SELECT employee_id, last_name, job_id
  FROM employees
 WHERE department_id = 10
WITH READ ONLY;
-- Klausel WITH READ ONLY verwenden

-- nicht erlaubt:
DELETE
  FROM emp_department10
 WHERE employee_number = 200;

-- *************************************************
-- VIEWS vs. WITH-Clause
-- **************************************************
-- SELECT directly from VIEW
-- query for view is stored in database and executed for every query that uses the view
SELECT name
  FROM dept_sum_view
 WHERE maxsal > 10000;


-- SELECT from query in WITH-clause
-- query is not stored in database, just executed for this particular query
WITH dept_sum_with AS (
SELECT department_name AS name, MIN(salary) AS minsal, MAX(salary) AS maxsal, AVG(salary) AS avgsal
  FROM employees INNER JOIN departments USING(department_id)
GROUP BY department_name
)
SELECT name
  FROM dept_sum_with
 WHERE maxsal > 10000;


-- *************************************************
-- EXKURS: DATA DICTIONARY: ABBILDUNG der METADATEN zu VIEWS
-- **************************************************

-- ABFRAGE DATA DICTIONARY
DESC user_views;

SELECT view_name, text
  FROM user_views;

-- ABFRAGE mittels SQLDeveloper
-- 1. View-Objekt-Metadaten in Registerkarten anzeigen lassen
-- 2. Registerkarte "Spalten" zeigt, ob View aktualisierbar ist (Insertable,
-- Updatable, Deletable) - wird von Oracle festgelegt und hängt von
-- View-Art sowie von gewissen Heuristiken ("schlüsselgeschützte" Tabellen) ab
-- 3. Registerkarte "Details" zeigt die Berechnungsvorschrift. D.h.
-- es werden keine physischen Datensätze gespeichert, sondern nur die
-- Berechnungsvorschrift.

-- *************************************************
-- VIEWS entfernen
-- **************************************************

DROP VIEW emp_department80;
DROP VIEW emp_department10;
DROP VIEW emp_department20;
DROP VIEW dept_sum_view;
DROP VIEW SAL_DEPARTMENT50;
