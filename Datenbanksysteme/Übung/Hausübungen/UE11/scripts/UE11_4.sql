
-- 1

SELECT e.*
FROM employees e
    JOIN employees m ON (e.manager_id = m.employee_id)
WHERE e.hire_date < m.hire_date;




SELECT last_name, first_name, job_id, (SELECT department_name
                                        FROM departments
                                        WHERE department_id =
                                        e1.department_id) AS department_name
FROM employees e1
WHERE salary > (SELECT AVG(salary)
                FROM employees
                WHERE job_id = e1.job_id);


-- 2
SELECT e.last_name, e.first_name, e.job_id, d.department_name
FROM employees e
    LEFT JOIN departments d ON (e.department_id = d.department_id) 
    -- employee bleibt erhalten, wenn department_id Null ist
    JOIN (
        SELECT job_id, AVG(salary) AS average_salary
        FROM employees
        GROUP BY job_id
    ) avg_sal ON (e.job_id = avg_sal.job_id)
WHERE e.salary > avg_sal.average_salary;