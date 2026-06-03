
-- 1
SELECT country_id, COUNT(*)
FROM employees
    JOIN departments USING(department_id)
    JOIN locations USING(location_id)
WHERE salary NOT BETWEEN 5000 AND 12000
GROUP BY country_id;




--2

SELECT last_name, job_id, salary
FROM employees
WHERE job_id IN ('SA_REP', 'ST_CLERK')
        AND salary NOT IN (2500, 3500, 7000);



--3

SELECT jg.grade_level AS Gehaltsstufe,
        department_name AS Departmentname,
        COUNT(employee_id) AS Mitarbeiteranzahl
FROM employees
    JOIN departments USING(department_id)
    JOIN job_grades jg
    ON salary BETWEEN jg.lowest_sal AND jg.highest_sal
GROUP BY jg.grade_level, department_id, department_name;



--4
SELECT department_name, COUNT(employee_id)
FROM employees
    RIGHT JOIN departments USING(department_id)
    -- durch den right-join bleibt die rechte
    -- Tabelle vollständig erhalten
    -- NULL-Werte in employee_id
    -- werden von COUNT nicht berücksichtigt
    -- daher ist COUNT dann 0
GROUP BY department_id, department_name
HAVING COUNT(employee_id) < 3;



--5

SELECT department_name
FROM employees
    RIGHT JOIN departments USING(department_id)
GROUP BY department_id, department_name
HAVING COUNT(employee_id) = (
    SELECT MAX(COUNT(employee_id))
    FROM employees
    GROUP BY department_id
);




-- 6
SELECT dep.department_name,
    COALESCE(m.last_name, 'position vacant')
FROM departments dep
    LEFT JOIN employees m -- manager_id kann null sein
    ON dep.manager_id = m.employee_id;



-- 7

SELECT emp.last_name, emp.salary, emp.job_id
FROM employees emp
WHERE salary < 5000
      OR salary < (
        SELECT AVG(salary)
        FROM employees emp_sal
        WHERE emp.job_id = emp_sal.job_id
);


-- 8
-- Unterabfrage: in welchen Abteilungen arbeiten SA_REP
-- Mitarbeiter?

-- Dann: Abteilungen auswählen, die da nicht vorkommen

SELECT department_id
FROM employees
WHERE job_id = 'SA_REP'
    AND department_id IS NOT NULL;

-- Gesamt:
SELECT department_id, department_name, location_id
FROM departments
WHERE department_id NOT IN (
    SELECT department_id
    FROM employees
    WHERE job_id = 'SA_REP'
    AND department_id IS NOT NULL
    -- wichtig weil sonst könnte der Ausdruck unknown sein
);




-- 9

SELECT department_id
FROM employees
    JOIN departments USING(department_id)
WHERE department_id IS NOT NULL
GROUP BY department_id
HAVING COUNT(DISTINCT job_id) = 1;



--10

-- Hilfstabelle:
-- job_id und dep_id der beiden Mitarbeiter
SELECT job_id, department_id
FROM employees
WHERE employee_id IN (103, 142);

-- alle Mitarbeiter, außer die beiden, die
-- diese job_id und dep_id haben

SELECT last_name, job_id, department_id
FROM employees
WHERE (job_id, department_id) IN (
    SELECT job_id, department_id
    FROM employees
    WHERE employee_id IN (103, 142)
) AND employee_id NOT IN (103, 142);





-- 11

-- alle Angestellten und Job-Kennungen verketten
-- --> EmployeeAndJob

SELECT last_name || ', ' || job_id AS EmployeeAndJob
FROM employees e1
ORDER BY (
    -- Durchschnittsgehalt der Abeilung
    SELECT AVG(salary)
    FROM employees e2
    WHERE e2.department_id = e1.department_id
) DESC NULLS LAST;









