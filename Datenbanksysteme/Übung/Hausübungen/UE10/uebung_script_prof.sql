SELECT last_name, hire_date
  FROM employees;
  
SELECT *
  FROM NLS_SESSION_PARAMETERS
  WHERE PARAMETER = 'NLS_DATE_FORMAT';
  
ALTER SESSION
  SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
ALTER SESSION
  SET NLS_TIMESTAMP_FORMAT = 'YYYY-MM-DD HH24:MI:SSXFF';
  
SELECT last_name, hire_date
  FROM employees;
  
SELECT SYSDATE AS ServerDate,
       SYSTIMESTAMP as ServerTimestamp,
       CURRENT_TIMESTAMP as ClientTimestamp
  FROM DUAL;
  
SELECT TO_DATE('2026/01/01', 'yyyy/mm/dd'),
       TO_DATE('20260101', 'yyyymmdd'),
       TO_DATE('02-Feb-99', 'dd-mon-rr'),
       TO_DATE('01-Jan-99', 'dd-mon-yy')
  FROM DUAL;
  
SELECT SYSDATE - TO_DATE('2026/01/01', 'yyyy/mm/dd')
  FROM DUAL;
  
SELECT EXTRACT(YEAR FROM SYSDATE)+10,
       EXTRACT(MONTH FROM SYSDATE)-1
  FROM DUAL;
  
SELECT TO_CHAR(SYSDATE, 'yyyy/mm/dd'),
       TO_CHAR(SYSDATE, 'dd. Mon yyyy', 'NLS_DATE_LANGUAGE=German')
  FROM DUAL;
  
SELECT SYSDATE as now,
       TRUNC(SYSDATE) AS today,
       TRUNC(SYSDATE, 'DD') AS today,
       TRUNC(SYSDATE, 'DAY') AS week,
       TRUNC(SYSDATE, 'Q') AS quarter,
       TRUNC(SYSDATE) - 1 AS yesterday,
       LAST_DAY(SYSDATE) AS lastDayOfMonth
  FROM DUAL;
  
SELECT last_name, hire_date,
       TRUNC(SYSDATE) - TRUNC(hire_date) AS hired_x_days_ago,
       ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) AS hired_x_months_ago
  FROM employees;
  
  
  
SELECT first_name || ' ' || last_name
  FROM employees;
  
  
SELECT first_name
  FROM employees
 WHERE first_name = 'Michael';
 
SELECT first_name
  FROM employees
 WHERE first_name LIKE 'E%';
 
-- Angestellte mit einem 'r' an 3. Stelle im Nachname
SELECT last_name
  FROM employees
 WHERE last_name LIKE '__r%'; --> gesamtes Muster
 
SELECT last_name
  FROM employees
 WHERE REGEXP_LIKE(last_name, '^..r.*'); --> Teilstring
 
SELECT first_name, last_name, phone_number,
       REGEXP_REPLACE(phone_number, '.[^.]+$', '-0') AS vermittlung,
       REGEXP_SUBSTR(phone_number, '[^.]+$') AS extension
  FROM employees;
  
SELECT 'Ellena', first_name,
       UTL_MATCH.EDIT_DISTANCE('Ellena', first_name) as edit_distance,
       UTL_MATCH.JARO_WINKLER_SIMILARITY('Ellena', first_name) as similarity,
  FROM employees
-- ORDER BY edit_distance;
ORDER BY similarity DESC;

SELECT last_name, SOUNDEX(last_name) as soundex,
       'Reis', SOUNDEX('Reis')
  FROM employees
ORDER BY soundex;

-- Umgang mit NULL
SELECT last_name, manager_id
  FROM employees
 WHERE manager_id = NULL; --> empty
 
SELECT last_name, manager_id
  FROM employees
 WHERE manager_id != NULL; --> empty
 
SELECT last_name, manager_id
  FROM employees
 WHERE manager_id IS NULL;
 
 SELECT last_name, manager_id
  FROM employees
 WHERE manager_id IS NOT NULL;
 
SELECT last_name, salary, COALESCE(salary * (1 + commission_pct), salary, 0)
  FROM employees;
  
-- alle Mitarbeiter die genau das Mindestgehalt in ihrer Abteilung verdienen
SELECT last_name, salary, department_id
  FROM employees e1
 WHERE salary = (SELECT MIN(salary)
                   FROM employees e2
                  WHERE e1.department_id = e2.department_id);
                  
SELECT department_id, MIN(salary)
  FROM employees e2
GROUP BY department_id;
                  
SELECT last_name, salary, department_id
  FROM employees e1
 WHERE (department_id, salary) IN
                (SELECT department_id, MIN(salary)
                   FROM employees e2
                 GROUP BY department_id);
                 
SELECT last_name, salary, department_id
  FROM employees e1
 WHERE salary <= ALL
                (SELECT salary
                   FROM employees e2
                  WHERE e1.department_id = e2.department_id);
                  
SELECT last_name, salary, department_id
  FROM employees e1
  JOIN (SELECT department_id, MIN(salary) min_salary
          FROM employees e2
        GROUP BY department_id) USING (department_id)
 WHERE e1.salary = min_salary;
 
-- Anzahl der Abteilungen mit einer bestimmten Mitarbeiteranzahl
SELECT emp_count, COUNT(*) AS dept_count
FROM (SELECT department_id, COUNT(*) AS emp_count
        FROM employees
      GROUP BY department_id)
GROUP BY emp_count;