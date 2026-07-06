
--1
SELECT last_name
FROM employees
WHERE last_name LIKE '%e_';

--2
SELECT last_name
FROM employees
WHERE REGEXP_LIKE(last_name, '^.e.*');

--3
SELECT last_name
FROM employees
WHERE REGEXP_LIKE(last_name, 'a.*a');

--4
SELECT employee_id, first_name, last_name,
    UTL_MATCH.JARO_WINKLER_SIMILARITY(UPPER('Margos'), UPPER(last_name)) AS similarity
FROM employees
ORDER BY similarity DESC;


--5 ganzer Name

SELECT employee_id, first_name, last_name,
    UTL_MATCH.JARO_WINKLER_SIMILARITY(UPPER('Irena Mays'), 
    UPPER(first_name || ' ' || last_name)) AS similarity
FROM employees
ORDER BY similarity DESC;