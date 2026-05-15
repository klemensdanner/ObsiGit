SELECT employee_id AS EmpID,
       e.last_name AS Employee,
       e.job_id AS job, 
       jh.start_date AS HireDate
  FROM employees e JOIN job_history jh USING (EMPLOYEE_ID);



SELECT DISTINCT manager_id 
FROM employees;
WHERE manager_id IS NOT NULL;