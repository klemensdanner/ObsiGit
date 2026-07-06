CREATE TABLE test (
    svnr NUMBER(9) PRIMARY KEY,
    name VARCHAR(20) NOT NULL);
    
SELECT * FROM test;


INSERT INTO test (svnr, name)
  VALUES (1, 'Altmann');
  
SELECT * FROM test;

COMMIT;

UPDATE test
SET name = 'Josef Altmann'
WHERE svnr = 1;


SELECT * FROM test;


ROLLBACK;


DELETE FROM test
WHERE svnr = 1;

SELECT * FROM test;

COMMIT;



------- DDL statements werden implizit commited


CREATE TABLE copy_emp AS
SELECT employee_id, last_name, job_id, salary, department_id
FROM employees
WHERE job_id = 'SA_REP';

SELECT * FROM copy_emp;



-- DML statements werden nicht inplizit erstellt
INSERT INTO copy_emp (employee_id, last_name, job_id, salary) -- beginn of transaction
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE job_id = 'IT_PROG';


SELECT * FROM copy_emp;

SAVEPOINT after_insert; -- Stand zwischenspeichern


UPDATE copy_emp
SET department_id = (SELECT DISTINCT department_id
                    FROM employees
                    WHERE job_id = 'IT_PROG'), -- hier darf nur ein Wert rauskommmen
    salary = (SELECT MAX(salary) + 1000
                FROM employees
                WHERE job_id = 'IT_PROG')
WHERE job_id = 'IT_PROG';

SELECT * FROM copy_emp;

ROLLBACK TO after_insert;

SELECT * FROM copy_emp;


COMMIT;

DELETE FROM copy_emp;
SELECT * FROM copy_emp;
ROLLBACK;


-- in der session gibt es ein log-file, damit man danach rollbacken kann.












