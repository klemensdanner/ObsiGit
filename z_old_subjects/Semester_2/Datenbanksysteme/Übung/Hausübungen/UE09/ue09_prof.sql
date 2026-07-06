-- Durchschnittliches Gehalt ermitteln
SELECT MIN(salary), AVG(salary), MAX(salary)
  FROM employees;
  
-- Durchschnittsgehalt pro Abteilung
SELECT department_id, AVG(salary)
  FROM employees
GROUP BY department_id;

-- Durchschnittsgehalt pro Abteilung (Abteilungsname)
SELECT department_name, AVG(salary)
  FROM employees
  FULL JOIN departments USING(department_id)
GROUP BY department_id, department_name;
-- überlegen ob nach Schlüssel/Entität oder nur
-- nach Attribut gruppiert werden soll

-- gerundet
SELECT department_name, ROUND(AVG(salary))
  FROM employees
  FULL JOIN departments USING(department_id)
GROUP BY department_id, department_name;

SELECT department_name, ROUND(AVG(salary), 2)
  FROM employees
  FULL JOIN departments USING(department_id)
GROUP BY department_id, department_name;

-- auf ganze Hunderter runden
SELECT department_name, ROUND(AVG(salary), -2)
  FROM employees
  FULL JOIN departments USING(department_id)
GROUP BY department_id, department_name;

-- immer abrunden
SELECT department_name,
       ROUND(AVG(salary)),
       FLOOR(AVG(salary)),
       CEIL(AVG(salary))
  FROM employees
  FULL JOIN departments USING(department_id)
GROUP BY department_id, department_name;

-- Durchschnittlichte Mitarbeiteranzahl pro Abteilung
SELECT AVG(COUNT(*)), MIN(COUNT(*)), MAX(COUNT(*))
  FROM employees
GROUP BY department_id;

SELECT COUNT(*),
       COUNT(department_id),
       COUNT(DISTINCT department_id)
  FROM employees;
  
-- Summe der Gehälter pro Abteilung & Job
SELECT department_id, job_id, SUM(salary) AS total
  FROM employees
GROUP BY department_id, job_id
-- ORDER BY SUM(salary)
ORDER BY total;

-- Anzahl der Mitarbeiter pro Manager und Job
SELECT manager_id, job_id, COUNT(*)
  FROM employees
GROUP BY manager_id, job_id;

-- Welche Abteilungen haben Gehaltssumme > 10000
SELECT department_id, SUM(salary)
  FROM employees
GROUP BY department_id
-- WHERE einzelne WHERTE
HAVING SUM(salary) > 10000 AND COUNT(*) > 2;

-- nicht-korrelierte Unterabfrage:
--- Welche Mitarbeiter verdienen mehr als 'Abel'
SELECT salary
  FROM employees
 WHERE last_name = 'Abel';
 
SELECT last_name, salary
  FROM employees
 WHERE salary > 11000;

SELECT last_name, salary
  FROM employees
 WHERE salary > (SELECT salary
                   FROM employees
                  WHERE last_name = 'Abel');
                  
                  
-- Alle Mitarbeiter die das minimale Gehalt verdienen
SELECT MIN(salary)
  FROM employees;
  
SELECT last_name, salary
  FROM employees
 WHERE salary = (SELECT MIN(salary)
                   FROM employees);
                   
                   
-- korrelierte Unterabfrage
-- Welche Mitarbeiter verdienen mindestens halb
-- so viel wie ihre Vorgesetzen
SELECT employee_id, last_name
  FROM employees;
 
-- Hilfsschritt: Managergehalt für Mitarbeiter 101
SELECT emp.employee_id, emp.manager_id, mgr.employee_id,
       emp.salary, mgr.salary
  FROM employees emp
  JOIN employees mgr ON (emp.manager_id = mgr.employee_id)
 WHERE emp.salary > mgr.salary / 2;
 
SELECT mgr.employee_id, mgr.salary
  FROM employees mgr
 WHERE EXISTS (SELECT *
                 FROM employees emp
                WHERE emp.manager_id = mgr.employee_id
                  AND emp.salary > mgr.salary / 2);

