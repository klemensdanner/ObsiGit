
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









