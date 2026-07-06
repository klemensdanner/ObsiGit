
-- 1
SELECT employee_id AS EmpID,
       last_name AS Employee,
       job_id AS Job, 
       hire_date AS HireDate
FROM employees;


-- 2

SELECT DISTINCT manager_id 
FROM employees
WHERE manager_id IS NOT NULL;

-- 3
SELECT *
FROM departments
WHERE manager_id = 201;

-- 4
SELECT last_name, salary
FROM employees 
WHERE salary > 6000;


-- 5
SELECT last_name, salary, department_id
FROM employees
WHERE employee_id = 124;

--6
SELECT last_name, job_id, hire_date
FROM employees
ORDER BY hire_date ASC;

--7
SELECT last_name, department_id
FROM employees
WHERE department_id = 20
ORDER BY last_name ASC;


--8
SELECT last_name AS Employee, salary AS MonthlySalary, commission_pct AS Commission
FROM employees
WHERE commission_pct = 0.2 OR job_id = 'SA_REP';


--9
SELECT first_name AS name, last_name AS surname, employee_id, salary -- restliche Namen sind passend
FROM employees
WHERE department_id = 60 AND manager_id = 103;
