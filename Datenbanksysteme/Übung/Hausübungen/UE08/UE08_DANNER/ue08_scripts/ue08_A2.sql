-- AUFGABE 2

-- 1
SELECT l.location_id AS location,
       l.street_address AS street,
       l.city AS city,
       l.state_province AS province,
       c.country_name AS country
FROM locations l NATURAL JOIN countries c;


-- 2
SELECT last_name, department_id, department_name
FROM employees JOIN departments USING (department_id)
ORDER BY last_name DESC;


-- 3

SELECT last_name, job_id, department_id, department_name
FROM (employees JOIN departments USING (department_id))
      JOIN locations USING (location_id)
WHERE UPPER(city) = 'OXFORD';


-- 4
SELECT e.last_name AS Employee,
       e.employee_id AS EmpId,
       m.last_name AS Manager,
       m.employee_id AS MgrId 
FROM employees e JOIN employees m ON e.manager_id = m.employee_id
WHERE e.manager_id IS NOT NULL;


--5
SELECT e.last_name, e.salary
FROM employees e JOIN job_grades g ON e.salary BETWEEN g.lowest_sal AND g.highest_sal
WHERE grade_level = 'E';


-- 6
SELECT e.last_name, e.job_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d USING (department_id)
WHERE salary > 5000;









