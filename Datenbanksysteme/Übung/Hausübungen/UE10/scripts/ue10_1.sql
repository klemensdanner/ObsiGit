

-- 1
-- Nachnamen und Einstellungsdatum für alle im Jahr 1999 eingestellten Mitarbeiter

SELECT last_name, hire_date
FROM employees
WHERE hire_date >= TO_DATE('01.01.1999', 'DD.MM.YYYY')
    AND hire_date < TO_DATE('01.01.2000','DD.MM.YYYY');


--2

SELECT last_name, salary, commission_pct,
        ADD_MONTHS(TRUNC(hire_date, 'MM'), 24)
FROM employees
WHERE commission_pct IS NOT NULL;


--3
-- Wann wurde KING eingestellt?

SELECT last_name, hire_date,
        TRUNC(MONTHS_BETWEEN(hire_date, (
            SELECT hire_date
            FROM employees
            WHERE last_name = 'King')) / 12)
        AS Jahresunterschied
FROM employees
WHERE department_id = 20 OR department_id = 50
ORDER BY Jahresunterschied DESC;


--4
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date > (SELECT hire_date
                    FROM employees
                    WHERE last_name = 'Davies');


--5
SELECT e.first_name, e.last_name, e.salary
FROM employees e
    JOIN employees m ON e.manager_id = m.employee_id
WHERE e.salary > m.salary AND e.hire_date < m.hire_date;