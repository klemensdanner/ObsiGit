
--1
SELECT employee_id
FROM employees
MINUS
SELECT manager_id
FROM employees;

--2

SELECT country_id, country_name
FROM countries
MINUS
SELECT country_id, country_name
FROM departments JOIN locations USING (location_id)
     JOIN countries USING (country_id);


--3
SELECT employee_id
FROM job_history
UNION
SELECT manager_id
FROM employees
WHERE manager_id IS NOT NULL;


--4
SELECT employee_id, job_id
FROM job_history
INTERSECT
SELECT employee_id, job_id
FROM employees;


--5
SELECT employee_id
FROM employees
MINUS
SELECT employee_id
FROM employees JOIN departments USING (department_id)
     JOIN locations USING (location_id)
WHERE city IN ('Seattle', 'Southlake');




