


-- 1
SELECT employee_id, last_name
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
)
ORDER BY salary;


--2

-- empID und last_name aller Angestellten, die *in ihrer Abteilung*
-- mehr als das AVG Gehalt verdienen

-- a) Durchschnittsgehalt von Abteilung 10 --- 4400
SELECT AVG(salary)
FROM employees
WHERE department_id = 10;

-- b) Angestellte, die mehr als 4400 verdienen
SELECT employee_id, last_name
FROM employees
WHERE salary > 4400;


-- c) Gemeinsam
SELECT employee_id, last_name
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees eSal
    WHERE e.department_id = eSal.department_id
)
ORDER BY salary; -- (Aufgabe 1 erweitern)


-- 3
SELECT employee_id, last_name
FROM employees e
WHERE 2 < ( 
    -- Unterabfrage: Anzahl der Angestellten in der Abteilung
    SELECT COUNT(employee_id)
    FROM employees depEmp
    WHERE e.department_id = depEmp.department_id
);


-- 4
SELECT department_name
FROM departments
WHERE department_id IN (
    -- Liste aller department_ids mit genau 2 mitarbeitern
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING COUNT(*) = 2
);

-- 5
SELECT last_name, job_id, salary
FROM employees
WHERE salary > ALL (
    SELECT salary
    FROM employees
    WHERE job_id = 'IT_PROG'
)
ORDER BY salary DESC;

-- 6
-- Abfrage mit allen angestellten, die keine Vorgesetzten sind
-- d.h. Angestellte, die nie in der Tabelle aller ManagerIDs auftauchen

SELECT last_name
FROM employees e
WHERE NOT EXISTS (
    SELECT manager_id
    FROM employees m
    WHERE e.employee_id = m.manager_id
);

-- 7) Jobkennung mit dem höchsten Durchschnittsgehalt
SELECT job_id, job_title, AVG(salary)
FROM employees JOIN jobs USING(job_id)
GROUP BY job_id, job_title
HAVING AVG(salary) >= ALL (
    -- Liste aller Durchschnittsgehälter
    SELECT AVG(salary)
    FROM employees
    GROUP BY job_id
);


-- 8
-- ID, Nachname, Job-Kennung von Angestellten, die genau 2 Mal
-- den Job gewechselt haben
SELECT employee_id, last_name, job_id
FROM employees e
    -- where job_history hat genau 2 einträge zu dem employee
WHERE 2 <= (
    SELECT COUNT(*)
    FROM job_history jh
    WHERE e.employee_id = jh.employee_id
);


-- 9
-- Nachname, Gehalt, Abteilungsnummer von denen
-- die das geringste Gehalt in ihrer Abteilung verdienen
SELECT last_name, salary, department_id
FROM employees e
WHERE salary = (
    SELECT MIN(salary)
    FROM employees empDep
    WHERE empDep.department_id = e.department_id
);

-- 10
SELECT last_name, job_id, salary
FROM employees e
WHERE salary = (
    SELECT MIN(salary)
    FROM employees empDep
    WHERE empDep.department_id = e.department_id
    ) AND 1 <= (
    SELECT COUNT(*)
    FROM job_history jh
    WHERE e.employee_id = jh.employee_id
    );


-- 11
-- Vor- und Nachname, Gehalt, Manager-ID
SELECT first_name, last_name, e.salary, manager_id
FROM employees e
ORDER BY (
    SELECT  m.salary - e.salary
    FROM employees m
    WHERE m.employee_id = e.manager_id
) DESC;


-- Zusatzversion mit Ausgabe der Gehaltsdifferenz
SELECT first_name, last_name, e.salary, manager_id,
        (    
            SELECT  m.salary - e.salary
            FROM employees m
            WHERE m.employee_id = e.manager_id ) AS gehaltsdifferenz
FROM employees e
ORDER BY gehaltsdifferenz DESC;
