
--1
SELECT MAX(salary) AS Maximum,
        MIN(salary) AS Minimum,
        SUM(salary) AS Summe,
        AVG(salary) AS Durchschnitt
FROM employees
WHERE job_id = 'SA_REP';

--2 
SELECT  job_id,
        ROUND(MAX(salary), -3) AS Maximum,
        ROUND(MIN(salary), -3) AS Minimum,
        ROUND(SUM(salary), -3) AS Summe,
        ROUND(AVG(salary), -3) AS Durchschnitt
FROM employees
GROUP BY job_id;


--3 Wirklich so gemeint?
SELECT COUNT(DISTINCT job_id) AS Jobanzahl
FROM employees;


--4
SELECT country_id
FROM locations
GROUP BY country_id
HAVING COUNT(location_id) > 1;

--5
SELECT department_id, 
        department_name,
        AVG(salary)
FROM employees JOIN departments USING(department_id)
GROUP BY department_id, department_name
ORDER BY AVG(salary) ASC;


-- 6
SELECT job_id, MAX(salary)
FROM employees
GROUP BY job_id
HAVING MAX(salary) > 10000;


-- 7: Angestellte, die manager von mehr als 1 Person sind
-- davon ManagerID, Anzahl an Unterstellten,
-- Durchschnittsgehalt
 
SELECT manager_id AS Manager,
        COUNT(*) AS Mitarbeiteranzahl,
        ROUND(AVG(salary), 2) AS Durchschnittsgehalt
FROM employees
GROUP BY manager_id
HAVING COUNT(*) > 0;

