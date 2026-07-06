-- Aggregation - Durchschnittliches, minimales, und maximales Gehalt



SELECT MIN(salary), AVG(salary), MAX(salary)
FROM employees;


-- Durchschnittsgehalt pro Abteilung -- Null Werte kommen in eine gemeinsame Gruppe
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id;
--ORDER BY department_id ASC;

-- Durchschnittsgehalt pro Abteilung (Abteilungsname)
SELECT department_name, AVG(salary)
FROM employees FULL JOIN departments USING (department_id) -- evtl. full join, damit man auch Abteilungen ohne Mitarbeiter hat
GROUP BY department_id, department_name; -- überlegen ob nach Schlüssel/Entität oder nur nach Attribut oder beiden sortiert werden soll



-- Runden -- Durchschnittsgehalt pro Abteilung (Abteilungsname)
SELECT department_name, 
        ROUND(AVG(salary), 2), 
        ROUND(AVG(salary), -2), -- -2 bedeutet: "auf ganze Hunderter runden"
        ROUND(AVG(salary)), -- rundet auf ganze zahlen
        FLOOR(AVG(salary)), -- rundet immer ab
        CEIL(AVG(salary))
FROM employees FULL JOIN departments USING (department_id) -- evtl. full join, damit man auch Abteilungen ohne Mitarbeiter hat
GROUP BY department_id, department_name; -- überlegen ob nach Schlüssel/Entität oder nur nach Attribut oder beiden sortiert werden soll



-- Durchschnittliche Mitarbeiteranzahl pro Abteilung
SELECT COUNT(*) --- Zählt die zeilen in den einzelnen group by nested tables --- WARUMMMM??? Count zählt doch die zeilen der tabelle
-- wenn die man würde ja so nur die anzahl der zeilen der virtuellen haupttabelle zählen - also wieviele unterschiedliche department-ids es gibt 
-- (weil sich die anzahl dieser zeilen mit dem group by so ergibt)
FROM employees
GROUP BY department_id;



-- Summe der Gehälter pro Abteilung und Job

-- MITSCHRIFT PROF

-- Anzahl der Mitarbeiter pro Manager und Job

SELECT job_id, manager_id, COUNT(*) --sobald es ein GROUP BY gibt, zählt es die Zeilenanzahl in den nested tables
FROM employees
GROUP BY job_id, manager_id;


-- Welche Abteilungen haben Gehaltssumme > 10000
SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 10000;



-- nicht-korrelierte Unterabfrage

-- Welche Mitarbeiter verdienen mehr als 'Abel'


-- brute force Methode - nicht elegant und fehleranfällig - was wenn sich werte ändern?
SELECT salary
FROM employees
WHERE last_name = 'Abel';

SELECT last_name, salary
FROM employees
WHERE salary > 11000;

-- besser:
SELECT last_name, salary
FROM employees
WHERE salary > (SELECT salary
FROM employees
WHERE last_name = 'Abel');



-- Alle Mitarbeiter die das minimale Gehalt verdienen
SELECT last_name, salary
FROM employees
WHERE salary = (SELECT MIN(salary)
                FROM employees);


-- Welche Mitarbeiter verdienen mindestens halb so viel wie ihre Vorgesetzen
    -- hier muss man pro mitarbeiter immer das Gehalt des vorgesetzten neu bestimmen ---- schreit nach korrellierter Abfrage

--SELECT employee_id, last_name
--FROM employees
--WHERE salary > ();

-- Hilfsschritt: Managergehalt für mitarbeiter 101
SELECT emp.employee_id, emp.manager_id, mgr.employee_id, emp.salary, mgr.salary
FROM employees emp JOIN employees mgr ON (emp.manager_id = mgr.employee_id)
WHERE emp.salary > mgr.salary / 2;


-- 

SELECT mgr.employee_id, mgr.salary
FROM employees mgr
WHERE EXISTS (SELECT *
                FROM employees emp
                WHERE emp.manager_id = mgr.employee_id
                AND emp.salary > mgr.salary / 2);