



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
            'DROP ' || object_type || ' ' || object_name || ';' END AS drop_statement
FROM user_objects
WHERE object_type IN (
    'SEQUENCE',
    'TABLE',
    'VIEW'
);


