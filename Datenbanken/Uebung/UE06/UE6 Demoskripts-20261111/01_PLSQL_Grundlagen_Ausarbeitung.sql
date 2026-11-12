-- Grundlagen von PL/SQL: Variablen, Kontrollstrukturen, Datentypen etc.

-- Explizites Aktivieren der Ausgabe des Oracle-Servers:
SET SERVEROUTPUT ON 
-- Kann implizit auch �ber das Werkzeug 'sqldeveloper' durchgef�hrt werden:
-- View -> DBMS Output -> Enable/Disable (bzw. DB-Verbindung ausw�hlen).
-- Ausgaben werden dann vom Oracle Server in das DBMS Output Pane geschrieben.

-- SELECT INTO-Anweisung: schreibt den selektierten Wert in eine deklarierte Variable
DECLARE
  fname VARCHAR2(25);
BEGIN
  SELECT first_name
    INTO fname -- Zuweisung -- Brücke zwischen plsql und sql
   FROM employees
   WHERE employee_id = 200;
  DBMS_OUTPUT.PUT_LINE(' First Name is: ' || fname);  -- Ausgabe einer Zeile
END;
-- SELECT * FROM employees; 
-- w�rde an dieser Stelle zu einem Fehler f�hren, da der PL/SQL-Block als nicht abgeschlossen erkannt wird (fehlender Slash).
/
-- Hinweise:
-- PL/SQL-Bl�cke k�nnen mehrere Zeilen (und Leerzeilen) enthalten.
-- Diese m�ssen durch einen Slash abgeschlossen werden, die auf
-- einer eigenen Zeile stehen. Siehe obiges Beispiel!
-- Wenn ein Slash angegeben wird, so wird der Block sofort zum Server
-- gesandt und ausgef�hrt.


-- Attribut: %TYPE zur Typdeklaration
DECLARE
  emp_hiredate employees.hire_date % TYPE;  -- die Variable erh�lt den Typ der DB-Spalte hiredate
  emp_salary employees.salary % TYPE;
  emp_last_name employees.last_name % TYPE;
BEGIN
  SELECT last_name, hire_date, salary
    INTO emp_last_name, emp_hiredate, emp_salary
   FROM employees
   WHERE employee_id = &empId; -- Verwendung einer Austauschvariablen
  DBMS_OUTPUT.PUT_LINE('Last Name: ' || emp_last_name);  
  DBMS_OUTPUT.PUT_LINE('Hire Date: ' || emp_hiredate);  
  DBMS_OUTPUT.PUT_LINE('Salary: '    || emp_salary);  
END;
/


-- Einf�gen und �ndern
DECLARE
-- Initialisierung von Variablen
  sal_start CONSTANT NUMBER NOT NULL DEFAULT 1000; -- statt DEFAULT kann auch := geschrieben werden
  sal_increase employees.salary % TYPE := 800;
  deptno employees.department_id % TYPE := 20;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Konstante sal_start : ' || sal_start);
  -- Neuen Employee einf�gen
  INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, salary)
    VALUES (employees_seq.NEXTVAL, 'Ruth', 'Cores', 'R-CORES', SYSDATE, 'AD_ASST', sal_start);

  -- Gehaltserh�hung (+800) in Department 20 durchf�hren
  UPDATE employees
     SET salary = salary + sal_increase
   WHERE department_id = deptno;
END;
/
SELECT * FROM employees WHERE first_name = 'Ruth';
SELECT * FROM employees WHERE department_id = 20;


-- CASE-Ausdr�cke
DECLARE
  grade CHAR(1) := UPPER('&grade');
  appraisal VARCHAR2(20);
BEGIN
  appraisal := CASE grade
    WHEN 'A' THEN 'Excellent'
    WHEN 'B' THEN 'Very Good'
    WHEN 'C' THEN 'Good'
    ELSE 'No such grade'
  END;
  DBMS_OUTPUT.PUT_LINE ('Grade: '|| grade || ', Appraisal: ' || appraisal);
END;
/

-- oder als Searched CASE-Ausdruck:
DECLARE
  grade CHAR(1) := UPPER('&grade');
  appraisal VARCHAR2(20);
BEGIN
  appraisal := CASE
      WHEN grade = 'A'        THEN 'Excellent'
      WHEN grade IN ('B','C') THEN 'Good'
      ELSE 'No such grade'
    END;
  DBMS_OUTPUT.PUT_LINE ('Grade: '|| grade || ', Appraisal: ' || appraisal);
END;
/

-- CASE-Anweisung:
DECLARE
  deptid NUMBER;
  deptname VARCHAR2(20);
  emps NUMBER;
  mngid NUMBER := &mgrId;
BEGIN
  CASE mngid
    WHEN 200 THEN
      SELECT department_id, department_name 
      INTO deptid, deptname
        FROM departments
       WHERE manager_id = mngid;
      SELECT count(*) INTO emps
        FROM employees
       WHERE department_id = deptid;
      DBMS_OUTPUT.PUT_LINE(
        'You are working in the ' || deptname|| ' department. There are ' ||
         emps || ' employees in this department');
    WHEN 201 THEN
      DBMS_OUTPUT.PUT_LINE('I don''t care where you work...');
    --WHEN xxx THEN
    --...
    ELSE
      DBMS_OUTPUT.PUT_LINE ('no valid mngid!');
  END CASE;
END;
/
-- Kontrollierte Iteration: Schleifenanweisungen

-- Basisschleife:
-- Einf�gen von 3 neuen Standortkennungen f�r den L�ndercode CA und die Stadt Montreal
DECLARE
  loc_id locations.location_id % TYPE;
  countryid locations.country_id % TYPE := 'CA';
  new_city locations.city % TYPE := 'Montreal';
  counter NUMBER(2) := 1;
BEGIN
  --Bestimmen der h�chsten location_id f�r country_id = CA
  SELECT MAX(location_id) INTO loc_id
    FROM locations
  WHERE country_id = countryid;

  LOOP
    INSERT INTO locations(location_id, city, country_id)
      VALUES((loc_id + counter), new_city, countryid);
    counter := counter + 1;
    EXIT WHEN counter > 3;  -- Abbruch-Bedingung beendet die Schleife
  END LOOP;
END;
/
SELECT * FROM locations;

-- Beispiel f�r eine WHILE-Schleife
DECLARE
  loc_id locations.location_id % TYPE;
  countryid locations.country_id % TYPE := 'CA';
  new_city locations.city % TYPE := 'Montreal';
  counter NUMBER(2) := 1;
BEGIN
  SELECT MAX(location_id) INTO loc_id
    FROM locations
   WHERE country_id = countryid;
   
  WHILE counter <= 3 LOOP
    INSERT INTO locations(location_id, city, country_id)
      VALUES((loc_id + counter), new_city, countryid);
    counter := counter + 1;
  END LOOP;
END;
/
SELECT * FROM locations;

-- Beispiel f�r eine FOR-Schleife:
DECLARE
  loc_id locations.location_id % TYPE;
  countryid locations.country_id % TYPE := 'CA';
  new_city locations.city % TYPE := 'Montreal';
  -- counter NUMBER(2) := 1; nicht notwendig, macht FOR automatisch
BEGIN
  SELECT MAX(location_id) INTO loc_id
    FROM locations
   WHERE country_id = countryid;
  -- Task 1: Erstellen Sie eine FOR-Schleife, die drei Locations einf�gt 
  --         (analog zur vorigen WHILE-Schleife)


  FOR counter IN 1..3 LOOP
    INSERT INTO locations(location_id, city, country_id)
      VALUES((loc_id + counter), new_city, countryid);
  END LOOP;

END;
/
SELECT * FROM locations;

ROLLBACK;


-- Zusammengesetzte Datentypen
-- PL/SQL-Records

-- Erzeugen der Hilfstabelle emps
CREATE TABLE emps (
  last_name VARCHAR2(25),
  job_id VARCHAR2(10),
  salary NUMBER(8,2)
);

-- Datensatz aus employee in emps einf�gen
DECLARE
  -- Task 2a: Erstellen Sie einen Record-Typen mit den Feldern last_name, job_id und salary
  TYPE t_emp_inf IS RECORD (
    last_name emps.last_name % TYPE,
    job_id emps.job_id % TYPE,
    salary emps.salary % TYPE
  );
  -- Task 2b: Erstellen Sie eine Variable emp_rec mit Ihrem Record-Typ.

  emp_rec t_emp_inf;
BEGIN
  -- Bef�llen des records: Spalten gleich Attribute im Record
  SELECT last_name, job_id, salary
    INTO emp_rec
    FROM employees
   WHERE employee_id = &empId;

  --Zugriff auf Record-Attribute �ber Selektion
  INSERT INTO emps VALUES(emp_rec.last_name, emp_rec.job_id, emp_rec.salary * 1.1);
END;
/
SELECT * FROM emps;

DROP TABLE emps;


-- Das Attribut %ROWTYPE: entspricht der Zeile einer Tabelle oder eines Cursor

-- Erzeugen der Hilfstabelle retired_emps
CREATE TABLE retired_emps (
  empno NUMBER(4),
  ename vARCHAR2(10),
  job VARCHAR2(9),
  mgr NUMBER(4),
  hiredate DATE,
  leavedate DATE,
  sal NUMBER(7,2),
  comm NUMBER(7,2),
  deptno NUMBER(2));


DEFINE employee_number = 124; -- Benutzervariable deren Typ automatisch CHAR ist
DECLARE
  emp_rec employees % ROWTYPE;  -- Erzeugt einen Recordtyp der den Spalten der Tabelle employees entspricht
BEGIN
  -- Bestimmen der selektierten Zeile und Zuweisung auf Record-Variable (vom Typ employees)
  SELECT * INTO emp_rec
    FROM employees
   WHERE employee_id = &employee_number;  -- Zugriff auf die Benutzervariable mit 'und-zeichen'

  -- Einf�gen in die Tabelle retired_emps
  INSERT INTO retired_emps(empno, ename, job, mgr, hiredate, leavedate, sal, comm, deptno)
    VALUES (
      emp_rec.employee_id,
      emp_rec.last_name,
      emp_rec.job_id,
      emp_rec.manager_id,
      emp_rec.hire_date,
      SYSDATE,
      emp_rec.salary,
      emp_rec.commission_pct,
      emp_rec.department_id);
END;
/
SELECT * FROM retired_emps;

-- Records mit Hilfe von %ROWTYPE (vom Typ retired_emps) einf�gen
DEFINE employee_number = 100; -- Benutzervariable vom Typ CHAR
DECLARE
  emp_rec retired_emps % ROWTYPE; -- Erzeugt einen Recordtyp der den Spalten der Tabelle retired_emps entspricht
BEGIN
  SELECT employee_id,
         last_name,
         job_id,
         manager_id,
         hire_date,
         hire_date, -- leavedate
         salary,
         commission_pct,
         department_id
    INTO emp_rec
    FROM employees
   WHERE employee_id = &employee_number;

  INSERT INTO retired_emps VALUES emp_rec;
END;
/
SELECT * FROM retired_emps;

-- Tabellenzeilen mit Hilfe von Records aktualisieren
DEFINE employee_number = 100;
DECLARE
  emp_rec retired_emps % ROWTYPE;
BEGIN
  SELECT * INTO emp_rec
    FROM retired_emps
   WHERE empno = &employee_number;
  emp_rec.leavedate := SYSDATE;

  UPDATE retired_emps
     SET ROW = emp_rec
   WHERE empno = &employee_number;
END;
/
SELECT * FROM retired_emps;

-- Task 3: Erstellen Sie aus dem anonymen Block eine gespeicherte Prozedur, die 
-- die Tabellenzeilen aktualisiert


CREATE OR REPLACE PROCEDURE update_leavedate(employee_number IN retired_emps.empno % TYPE)
IS
emp_rec retired_emps % ROWTYPE;
BEGIN
  SELECT * INTO emp_rec
    FROM retired_emps
   WHERE empno = employee_number;
  emp_rec.leavedate := SYSDATE;

  UPDATE retired_emps
     SET ROW = emp_rec
   WHERE empno = employee_number;
END;
/
/


-- Aufruf der gespeicherten Prozedur
CALL update_leavedate(100);
-- Alternative (SQL*Plus)
EXECUTE update_leavedate(100);

SELECT * FROM retired_emps;

DROP TABLE retired_emps;
DROP PROCEDURE update_leavedate;
