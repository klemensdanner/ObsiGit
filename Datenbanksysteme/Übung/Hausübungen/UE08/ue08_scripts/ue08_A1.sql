SELECT employee_id AS EmpID,
       e.last_name AS Employee,
       e.job_id AS job, 
       jh.start_date AS HireDate
  FROM employees e JOIN job_history jh USING (EMPLOYEE_ID);



SELECT DISTINCT manager_id 
FROM employees
WHERE manager_id IS NOT NULL;


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
WHERE commission_pct = 20 OR job_id = 'SA_REP';


--9
SELECT first_name AS name, last_name AS surname, employee_id, salary -- restliche Namen sind passend
FROM employees
WHERE department_id = 60 AND manager_id = 103;
