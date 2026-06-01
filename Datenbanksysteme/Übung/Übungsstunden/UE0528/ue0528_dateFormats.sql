SELECT last_name, hire_date
  FROM employees;

SELECT *
  FROM NLS_SESSION_PARAMETERS
  WHERE PARAMETER = 'NLS_DATE_FORMAT';

ALTER SESSION
  SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';


SELECT last_name, hire_date
  FROM employees;




SELECT SYSDATE AS server_date,
       SYSTIMESTAMP AS server_timestamp,
       CURRENT_TIMESTAMP AS client_timestamp
  FROM DUAL; -- in oracle braucht man immer eine Tabelle - also mindestens SELECT xxxx FROM xxxx


SELECT TO_DATE('2026/01/01', 'yyyy/mm/dd'),
       TO_DATE('20260101', 'yyyymmdd'),
       TO_DATE('01-Jan-99', 'dd-mon-YY')
  FROM DUAL;



SELECT SYSDATE as now,
    TRUNC(SYSDATE) AS today -- round geht auch - aber durch die Repräsentation durch einen float sorgt für aufrunden auf den nächsten Tag ab 12.00
FROM DUAL;



SELECT first_name || ' ' || last_name
  FROM employees;




-- Angestellte mit einem R an 3. Stelle im Nachnamen

SELECT last_name
FROM employees
WHERE last_name LIKE '__r%'; -- einfache Mustersuche - wenn man nichts kompizierteres braucht
-- dabei ist: _ ein bel. Zeichen, % sind mehrere bel. Zeichen
--> LIKE muss gesamt matchen, das gesamte Muster


SELECT last_name
FROM employees
WHERE REGEXP_LIKE(last_name, '^..r.*'); -- REGEX yeeyy


SELECT first_name, last_name, phone_number,
       REGEXP_REPLACE(phone_number, '.[^.]+$', '-0') AS vermittlung,
       REGEXP_SUBSTR(phone_number, '[^.]+$') AS extension
FROM employees;

 -- einfügen, löschen oder buchstabe ändern ist 1 edit distance
SELECT 'Ellena', first_name,
        UTL_MATCH.EDIT_DISTANCE('Ellena', first_name) AS edit_distance,
        UTL_MATCH.JARO_WINKLER_SIMILARITY('Ellena', first_name) as similarity
FROM employees
ORDER BY similarity DESC;


SELECT last_name, SOUNDEX(last_name) AS soundex -- hier wird gecashed - d.h. es ist eine Abbildung von ähnlicher Buchstaben auf den selben wert, dadurch entsteht ein ähnlicher Hashwert.
-- dieser wert kann im vorhinein berechnet werden
FROM employees
ORDER BY soundex;


-- Umgang mit NULL

SELECT last_name, salary, COALESCE(salary * (1 + commission_pct), salary, 0) -- probiert parameter nach der reihe durch und nimmt das erste was nicht Null ist
FROM employees;




-- UNTERABFRAGEN

-- alle Mitarbeiter die genau das Mindestgehalt in ihrer Abteilung verdienen

SELECT last_name
FROM employees e1
WHERE salary = (
    SELECT MIN(salary)
    FROM employees e2
    WHERE e1.department_id = e2.department_id
);


SELECT department_id, MIN(salary)
FROM employees e2
GROUP BY department_id;





-- prof lösungen fehlen


-- Anzahl an Abteilungen mit einer Bestimmten Mitarbeiteranzahl

SELECT emp_cnt, COUNT(*) AS dept_cnt
FROM (SELECT department_id, COUNT(*) AS emp_cnt
  FROM employees
  GROUP BY department_id)
GROUP BY emp_cnt;
















