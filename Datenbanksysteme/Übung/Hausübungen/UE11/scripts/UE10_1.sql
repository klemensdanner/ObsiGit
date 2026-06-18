
-- Hilfstabelle erstellen

CREATE TABLE MY_EMPLOYEE (
    id NUMBER(6) CONSTRAINT my_employee_id_pk PRIMARY KEY,
    last_name VARCHAR2(25) NOT NULL,
    first_name VARCHAR2(20) NOT NULL,
    email VARCHAR2(8),
    salary NUMBER(8,2) NOT NULL,
    hire_date DATE DEFAULT SYSDATE);


-- 1.1

INSERT INTO my_employee VALUES (1, 'Fawcett', 'Mattheuw', 'mface', 2895, SYSDATE - 1);
INSERT INTO my_employee VALUES (2, 'Paltrow', 'Vivien', NULL, 3860, TO_DATE('01.05.2024', 'DD.MM.YYYY'));


--1.2
INSERT INTO my_employee (id, last_name, first_name, email, salary, hire_date)
    VALUES (3, 'Peck', 'Fred', 'fpeck', 1100, TO_DATE('01.01.2025', 'DD.MM.YYYY'));

INSERT INTO my_employee (id, last_name, first_name, email, salary, hire_date)
    VALUES (4, 'Olivier', 'Kevin', 'kolivi', 2750, TO_DATE('15.02.2025', 'DD.MM.YYYY'));

INSERT INTO my_employee (id, last_name, first_name, email, salary, hire_date)
    VALUES (5, 'Dean', 'John', 'jdean', 1550, NULL);


SELECT *
FROM my_employee;

COMMIT;


SAVEPOINT first_point;

-- 2 -- last_name von id 5 ändern, email ändern

UPDATE my_employee
SET last_name = 'Voight', email = 'jvoigh'
WHERE id = 5;


-- 3

UPDATE my_employee
SET salary = GREATEST(salary * 1.1, 1250)
WHERE salary < 2000;


-- 4
UPDATE my_employee
SET email = LOWER(
    SUBSTR(first_name, 1, 1) || SUBSTR(last_name, 1, 5)
)
WHERE email IS NULL;


-- 5

DELETE FROM my_employee
WHERE first_name = 'Fred' AND last_name = 'Peck';

COMMIT;


SELECT *
FROM my_employee;


-- 6a

INSERT INTO my_employee (id, last_name, first_name, email, salary, hire_date)
    SELECT employee_id, last_name, first_name, email, salary, hire_date
    FROM employees;

SELECT *
FROM my_employee;

COMMIT;

-- 6b

-- 6b.1 Mitarbeiter, die min. 2 Einträge in job_history haben und einen job ausüben,
-- den sie in der Vergangenheit noch nicht gemacht haben


SELECT e.id
FROM my_employee e JOIN employees e_orig ON (e.id = e_orig.employee_id)
WHERE e.id IN (
        SELECT employee_id
        FROM job_history
        GROUP BY employee_id
        HAVING COUNT(*) >= 2
    )
    AND e_orig.job_id NOT IN ( -- Alle jobs die e.job_id in der vergangenheit gemacht hat
        SELECT job_id
        FROM job_history jh
        WHERE e.id = jh.employee_id
        GROUP BY job_id
    );


-- 6b.2 diese Mitarbeiter sollen um 500 mehr salary bekommen, also:

UPDATE my_employee
SET salary = salary + 500
WHERE id IN (
    SELECT e.id
    FROM my_employee e JOIN employees e_orig ON (e.id = e_orig.employee_id)
    WHERE e.id IN (
        SELECT employee_id
        FROM job_history
        GROUP BY employee_id
        HAVING COUNT(*) >= 2
    )
    AND e_orig.job_id NOT IN ( -- Alle jobs die e_orig.employee_id = e.id in der vergangenheit gemacht hat
        SELECT job_id
        FROM job_history jh
        WHERE e.id = jh.employee_id
        GROUP BY job_id
    )
);


SELECT *
FROM my_employee;
    


SAVEPOINT save_point2;
-- 7 -- Datensätze löschen, welche ein hiredate vor dem Maximum von De Haan oder Hunold sind
-- Annahme: gelöscht wird was vor dem jüngeren ist. Sonst würde der jüngere nicht gelöscht werden.


DELETE FROM my_employee
WHERE hire_date <= (
    SELECT MAX(hire_date)
    FROM my_employee
    WHERE last_name = 'Hunold' OR last_name = 'De Haan'
);


















