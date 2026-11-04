SELECT *
FROM dictionary
WHERE table_name LIKE '%user%';
-- USER_TABLES	Description of the user's own relational tables
-- USER_CATALOG	Tables, Views, Synonyms and Sequences owned by the user
-- ALL_USERS	Information about all users of the database



-- eigener Benutzer
SELECT *
FROM user_users;

SELECT *
FROM all_users;

-- eigene Tabellen
SELECT *
FROM user_tables;


-- Attribute zu den Tabellen
SELECT *
FROM user_tab_columns;


-- Version herausfinden
SELECT *
FROM v$version;


select *
from employees
where employee_id = &eingabe;