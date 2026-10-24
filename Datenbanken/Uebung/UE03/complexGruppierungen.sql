-- Bsp. 1
SELECT employee_id, last_name, first_name, (SELECT first_name || ' ' || last_name
                                            FROM employees m
                                            WHERE m.employee_id = e.manager_id)
FROM employees e;



-- Bsp. 2
SELECT e.employee_id, e.last_name, e.first_name, m.first_name || ' ' || m.last_name
FROM employees e
    LEFT OUTER JOIN employees m ON (e.manager_id = m.employee_id);
    

  
-- Bsp. 3
SELECT department_id, job_id, SUM(salary)
FROM employees
WHERE department_id < 60
GROUP BY department_id, job_id
UNION ALL
SELECT department_id, NULL , SUM(salary)
FROM employees
WHERE department_id < 60
GROUP BY department_id
UNION ALL
SELECT NULL, NULL , SUM(SUM(salary))
FROM employees
WHERE department_id < 60
GROUP BY department_id
ORDER BY department_id;


-- Bsp. 4
SELECT department_id, job_id, SUM(salary)
FROM employees
WHERE department_id < 60
GROUP BY ROLLUP(department_id, job_id);


-- Bsp. 5
SELECT department_id, job_id, SUM(salary)
FROM employees
WHERE department_id < 60
GROUP BY CUBE (department_id, job_id) ;


-- Bsp. 6
SELECT department_id DEPTID, job_id JOB,SUM(salary),
GROUPING(department_id) GRP_DEPT,
GROUPING(job_id) GRP_JOB
FROM employees
WHERE department_id < 50
GROUP BY ROLLUP(department_id, job_id);


-- Bsp. 7
SELECT department_id, job_id, manager_id, avg(salary)
FROM employees
GROUP BY GROUPING SETS
((department_id,job_id), (job_id,manager_id));


-- Bsp. 8
SELECT department_id, job_id, manager_id, avg(salary),
GROUPING(department_id) GRP_DEPT_ID, GROUPING(job_ID) GRP_JOB,
GROUPING(manager_id) GRP_MGR
FROM employees
GROUP BY GROUPING SETS
((department_id,job_id), (job_id,manager_id));


-- Bsp. 9
SELECT department_id, job_id, NULL AS "ManagerID", AVG(salary) AS "Average Salary"
  FROM employees
GROUP BY department_id,job_id
UNION ALL
SELECT NULL, job_id, manager_id, AVG(salary) 
  FROM employees
GROUP BY (job_id,manager_id);


-- Bsp. 10
SELECT department_id, job_id, manager_id, avg(salary),
       GROUPING(department_id) GRP_DEPT_ID,
       GROUPING(job_ID) GRP_JOB,
       GROUPING(manager_id) GRP_MGR
  FROM employees
GROUP BY GROUPING SETS ((job_id,manager_id),
                        ROLLUP(department_id, job_id));