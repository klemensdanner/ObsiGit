
-- 2.6 OHNE NOT IN
-- Abfrage mit allen angestellten, die keine Vorgesetzten sind
-- d.h. Angestellte, die nie in der Tabelle aller ManagerIDs auftauchen

SELECT last_name
FROM employees e
WHERE NOT EXISTS (
    SELECT manager_id
    FROM employees m
    WHERE e.employee_id = m.manager_id
);

-- 2.6 mit NOT IN
-- Erstellen Sie eine Abfrage, die alle Angestellten (last_name) 
-- auflistet, die keine Vorgesetzten sind.


-- Angestellte durchlaufen, prüfen ob sie NOT IN Liste der Vorgesetzten
-- ist

-- Liste der Vorgesetzen
-- Vorgesetzter: wenn man bei wem anderer der Manager ist


-- 3.1
SELECT last_name
FROM employees
WHERE employee_id NOT IN (
    SELECT DISTINCT manager_id
    FROM employees
    WHERE manager_id IS NOT NULL
);


-------------------



-- 2.10 - MIT Unterabfragen
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
    )
ORDER BY e.last_name;


-- 3.2 OHNE Unterabfragen
-- Plan:
-- Tabelle 1:
---- Tabelle mit dem geringsten Gehalt je Abteilung
---- Tabelle mit Leuten die min. 1x Job gewechselt haben

---- JOIN: ON department_id gleich
----       ON salary gleich


-- Tabelle mit dem geringsten Gehalt je Abteilung
SELECT department_id, MIN(salary) AS min_sal
FROM employees
GROUP BY department_id;


-- Job wechsler
SELECT employee_id
FROM job_history
GROUP BY employee_id;

-------- Gesamt 3.2

SELECT e.last_name,
       e.job_id,
       e.salary
FROM employees e JOIN 
    (
        SELECT department_id, MIN(salary) AS min_sal
        FROM employees
        GROUP BY department_id
    ) dep_min ON e.department_id = dep_min.department_id AND 
                 e.salary = dep_min.min_sal
    
    JOIN (
        SELECT employee_id
        FROM job_history
        GROUP BY employee_id
    ) jChange ON jChange.employee_id = e.employee_id;










