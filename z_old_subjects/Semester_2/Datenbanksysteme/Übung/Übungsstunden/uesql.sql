-- Welche Abteilungen gibt es (Nummer und Name)
SELECT department_id, department_name
  FROM departments;
  
SELECT *
  FROM DUAL;
  
-- Liste aller aktiven Jobs (JOB_ID)
SELECT DISTINCT job_id
  FROM employees;
  
-- Alle Infos zu Department Nr 60
SELECT *
  FROM departments
  WHERE department_id = 60;
  
-- Wer ist Programmierer (IT_PROG) und verdient
--   mehr als 8000
SELECT employee_id, first_name, last_name
  FROM employees
  WHERE job_id = 'IT_PROG'
    AND salary > 8000;
    
-- Wer ist Programmierer (IT_PROG) ODER verdient
--   mehr als 8000
SELECT employee_id, last_name, job_id, salary
  FROM employees
  WHERE job_id = 'IT_PROG'
     OR salary > 8000;
     
-- Infos zu Abteilungen 20, 60 und 80 (IN)
SELECT *
  FROM departments
  WHERE department_id IN (20, 60, 80);
  
-- Wer verdient zwischen 2000 und 6000 (BETWEEN X AND Y)
SELECT last_name, salary
  FROM employees
  WHERE salary BETWEEN 2000 AND 6000;
  
-- Nettogehalt (salary*(1+commision_pct)) von den
--    Verkäufern (SA_REP)
SELECT last_name, salary,
       salary*(1+commission_pct) AS net_salary
  FROM employees
 WHERE job_id = 'SA_REP';

SELECT last_name, salary,
       salary*(1+NVL(commission_pct, 0)) AS net_salary
  FROM employees;
  
-- ORDER BY x, y, z ASC, a DESC
-- Angestellten sortiert nach :
--   Beruf aufsteigend, Gehalt absteigend
SELECT last_name, job_id, salary
  FROM employees
ORDER BY job_id ASC, salary DESC;

-- In welcher Stadt arbeitet die Mitarbeiterin 'Lorentz'?
-- FROM x JOIN y USING (a1, a2, ...)
SELECT last_name, department_name, city
  FROM employees
    LEFT JOIN departments USING (department_id)
    LEFT JOIN locations USING (location_id)
  WHERE last_name = 'Lorentz';
  
-- Welche Job-Ids komment nicht vor
SELECT job_id
  FROM jobs
MINUS
SELECT job_id
  FROM employees;
