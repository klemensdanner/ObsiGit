-- 1 Data Dictionary

/* 

Spaltennamen, Datentypen, Länge der Datentypen, Null erlaubt?
Benutzer soll Tabellenname eingeben (& Operator)

 */


-- Suchen nach Usertabellen

--a)
SELECT *
FROM dictionary
WHERE table_name LIKE 'USER_T%';

-- USER_TAB_COLUMNS sieht gut aus: Columns of user's tables, views and clusters
-- mal reinschauen

SELECT * FROM USER_TAB_COLUMNS;
-- sieht gut aus! alle gewollten Infos stehen darin.


SELECT column_name,
        data_type,
        data_type,
        data_length,
        nullable,
        data_precision AS ct_digits,
        data_scale AS ct_decimal_digits
FROM USER_TAB_COLUMNS
WHERE table_name = UPPER('&entered_table_name');




-- b)

SELECT * FROM USER_TAB_COLUMNS WHERE table_name = 'EMPLOYEES';
SELECT * FROM USER_IND_columns WHERE table_name = 'FILM_ACTOR';
SELECT * FROM USER_IND_columns WHERE index_name = 'FILM_ACTOR_PK';


SELECT index_name,
        LISTAGG(column_name, ', ')
        WITHIN GROUP (ORDER BY column_position) AS columns
FROM USER_IND_COLUMNS
WHERE index_name LIKE '%FILM%'
GROUP BY index_name;


-- c)
WITH tmp_table AS (
    SELECT segment_name AS name,
            bytes AS size_bytes,
            DENSE_RANK() OVER (
                ORDER BY bytes DESC
                ) AS dense_rank
    FROM user_segments
    WHERE segment_type = 'TABLE'
)

SELECT name, size_bytes
FROM tmp_table
WHERE dense_rank <= 3;




-- d)

SELECT * FROM USER_OBJECTS;

SELECT DISTINCT object_type
FROM user_objects
ORDER BY object_type;


SELECT CASE WHEN object_type = 'TABLE' THEN
            'DROP TABLE' || ' ' || object_name || ' CASCADE CONSTRAINTS' || ';'
        ELSE
            'DROP ' || object_type || ' ' || object_name || ';'
        END AS drop_statement
FROM user_objects
WHERE object_type IN (
    'SEQUENCE',
    'TABLE',
    'VIEW',
    'MATERIALIZED VIEW'
);



-- 2

--a alter der Schauspieler zum aktuellen Tag,
-- virtuelle Sicht dazu erstellen und abfragen

CREATE OR REPLACE VIEW actor_age AS
SELECT actor_id, first_name, last_name,
        TRUNC(MONTHS_BETWEEN(SYSDATE, birth_date) / 12) AS age
FROM actor
ORDER BY actor_id;

SELECT *
FROM actor_age;

--b daraus materialisierte sicht erstellen

CREATE MATERIALIZED VIEW actor_age_daily
        REFRESH COMPLETE
        START WITH TRUNC(SYSDATE + 1) + 1/24
        NEXT TRUNC(SYSDATE + 1) + 1/24
AS
SELECT *
FROM actor_age;

-- abfragen, für die doku
SELECT * FROM actor_age_daily;


--c nur in der Nacht von Sonntag auf montag 3.00 uhr
CREATE MATERIALIZED VIEW actor_age_weekly
        REFRESH COMPLETE
        START WITH TRUNC((SYSDATE + 7), 'IW') + 3/24
        NEXT TRUNC((SYSDATE + 7), 'IW') + 3/24
AS
SELECT *
FROM actor_age;

SELECT * FROM actor_age_weekly; 


-- d
-- kann ich nicht abwarten - mach das grad am Dienstag Abend :)
-- ich kanns aber im data dictionary prüfen

-- also: suchen im dictionary:
SELECT * FROM dictionary;

-- nach dem Stichwort refresh
SELECT *
FROM dictionary
WHERE table_name LIKE '%refresh%'
        OR comments LIKE '%refresh%';


SELECT *
FROM USER_MVIEW_REFRESH_TIMES;

SELECT rname, next_date
FROM USER_REFRESH;

--e)

DROP MATERIALIZED VIEW actor_age_weekly;
DROP MATERIALIZED VIEW actor_age_daily;
DROP VIEW actor_age;



--------------------------
-- Aufgabe 3


-- a)
-- alle employees die genau 2 levels unter 102 sind
-- level 1 ist 102
-- zwei darunter ist level 3
SELECT employee_id, last_name, manager_id, LEVEL
FROM employees
WHERE LEVEL = 3
START WITH employee_id = 102
CONNECT BY PRIOR employee_id = manager_id
               AND LEVEL <= 3; -- Rekursion begrenzen
-- heißt: geh weiter wo die manager_id 102 ist (beim ersten Schritt)



-- b)

SELECT employee_id, last_name
FROM employees
WHERE last_name = 'King';
-- King -- 100

SELECT employee_id, last_name, manager_id, department_id
FROM employees
WHERE department_id != PRIOR department_id
START WITH employee_id = 100
CONNECT BY NOCYCLE PRIOR employee_id = manager_id;


-- c)
-- manager_id mit jeweils seinem untergebenen
--     dessen einstellungsdatum vorm manager ist

WITH tmp_table AS (
        SELECT  CONNECT_BY_ROOT employee_id AS root_manager_id,
                        -- jede id wird rek. durchlaufen
                        -- erste id ist also manager aller anderen
                CONNECT_BY_ROOT last_name AS root_manager_name,
                employee_id, last_name,
                manager_id, hire_date
        FROM employees
        WHERE hire_date < CONNECT_BY_ROOT hire_date
        -- hire_date von Untergebenem war vorher
        CONNECT BY NOCYCLE PRIOR employee_id = manager_id
)

SELECT root_manager_id, root_manager_name,
        COUNT(*) AS untergebene
FROM tmp_table
GROUP BY root_manager_id, root_manager_name;





---------------------------------------------
-- Aufgabe 4

-- a) Alle actor_id, welche im selben film waren
-- und nur Jahr 1990
-- view erstellen

SELECT film.film_id, id1.actor_id, id2.actor_id
FROM film_actor id1
        JOIN film_actor id2
          ON id1.film_id = id2.film_id
        JOIN film
          ON id1.film_id = film.film_id 
WHERE release_year = 1990
        AND id1.actor_id <> id2.actor_id;