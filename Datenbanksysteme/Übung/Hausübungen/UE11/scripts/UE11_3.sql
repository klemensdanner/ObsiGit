

CREATE OR REPLACE VIEW emp_department80 (id_number, name, sal, department_id) AS
SELECT employee_id, first_name || ' ' || last_name, salary, department_id
  FROM employees
 WHERE department_id = 80;



-- 1
CREATE OR REPLACE VIEW schulung (Personalnummer, Vorname, Nachname, Abteilung, Bundesland) AS
SELECT employee_id, first_name, last_name, department_name, state_province
FROM employees
        JOIN departments USING (department_id)
        JOIN locations USING (location_id);

SELECT * FROM schulung;


-- 2

CREATE OR REPLACE VIEW DEPT90 (EMPNO, EMPLOYEE, DEPTNO) AS
SELECT employee_id, last_name, department_id
FROM employees
WHERE department_id = 90
WITH CHECK OPTION CONSTRAINT dept90_department_id_check;

SELECT * FROM DEPT90;

-- 3 DEPT90 testen
-- a)

UPDATE dept90
SET deptNo = 60
WHERE employee = 'Kochhar';

-- b)
UPDATE dept90
SET employee = 'The King'
WHERE empNo = 100;

ROLLBACK;

-- 3.4
CREATE OR REPLACE VIEW annual_salary (employee, employee_id, annual_salary) AS
SELECT first_name || ' ' || last_name, employee_id, salary * 14
FROM employees;

SELECT * FROM annual_salary;

-- DMLs Testen

-- update

UPDATE annual_salary
SET employee = 'Stephan König'
WHERE employee_id = 100;

UPDATE annual_salary
SET annual_salary = 0
WHERE employee_id = 100;


UPDATE annual_salary
SET employee_id = 50
WHERE employee_id = 178;

-- delete
DELETE FROM annual_salary
WHERE employee_id = 100;

DELETE FROM annual_salary
WHERE employee_id = 50;

ROLLBACK;