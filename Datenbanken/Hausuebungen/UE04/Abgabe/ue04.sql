
-- Aufgabe 1

/* 
1. Erstellen Sie eine Abfrage, die pro Sprache (L) und 
Original-Sprache (OL) die Anzahl an
verfügbaren Filmen aus dem Jahr 2000 auflistet. 
Die Anzahl an Exemplaren im Inventar kann
unbeachtet bleiben. Achten Sie darauf, 
dass es auch Filme ohne Original-Sprache geben kann.
(12 Zeilen)
 */

WITH tmp_table2 AS (
    SELECT film_id,
        language_id,
        original_language_id
    FROM film
    WHERE release_year = 2000
), unpiv_tab AS (
    SELECT *
    FROM tmp_table2
    UNPIVOT (
        lang_id
        FOR ar IN (
            language_id AS 'L',
            original_language_id AS 'OL'
        )
    )   
)

SELECT
    COUNT(*) AS numfilme,
    name AS sprache,
    ar
FROM unpiv_tab
JOIN language ON lang_id = language.language_id
GROUP BY name, ar
ORDER BY name, ar;



-- 1.2
WITH tmp_table AS (
    SELECT name AS category_name,
            rental_id,
            TO_CHAR(rental_date, 'FMDAY', 
            'NLS_DATE_LANGUAGE=GERMAN') AS weekday
    FROM rental
        JOIN inventory USING (inventory_id)
        JOIN film_category USING (film_id)
        JOIN category USING (category_id)
)


SELECT *
FROM tmp_table
PIVOT (
    COUNT(rental_id)
    FOR weekday IN (
        'MONTAG' AS Montag,
        'DIENSTAG' AS Dienstag,
        'MITTWOCH' AS Mittwoch,
        'DONNERSTAG' AS Donnerstag,
        'FREITAG' AS Freitag,
        'SAMSTAG' AS Samstag,
        'SONNTAG' AS Sonntag
    )
);






-- 1.3

WITH tmp_table1 AS (
    SELECT COUNT(*) AS anzahl,
    CASE WHEN GROUPING(name) = 1 THEN 'Gesamt' ELSE name END AS Kategorie,
    CASE WHEN GROUPING(store_id) = 1 THEN 'Gesamt' ELSE to_char(store_id) END AS Filiale
    FROM inventory
    INNER JOIN film_category USING (film_id)
    INNER JOIN category USING (category_id)
    GROUP BY CUBE(store_id, name)
)

SELECT *
FROM tmp_table1
PIVOT (
    SUM(anzahl)
    FOR Filiale IN (
        '1' AS "1",
        '2' AS "2",
        '3' AS "3",
        '4' AS "4",
        '5' AS "5",
        '6' AS "6",
        'Gesamt' AS Gesamt
    )
);




-- AUFGABE 2


-- 2.1
SELECT film_id, title, length, name,
        COUNT(*) OVER (PARTITION BY category_id ORDER BY length
                        RANGE BETWEEN 5 PRECEDING AND 5 FOLLOWING) - 1
                        AS suggestions
FROM film
    JOIN film_category USING (film_id)
    JOIN category USING (category_id)
ORDER BY category_id, length;


--2.2 Welche KundInnen haben min 1 Mal mehr als 180 Tage
-- zwischen zwei Verleihvorgängen

-- a
WITH cmp_rental_dates AS (SELECT customer_id,
        rental_date,
        LEAD(rental_date) OVER 
            (PARTITION BY customer_id ORDER BY rental_date)
                AS next_rental_date
FROM customer
    JOIN rental USING (customer_id)
)

-- b
, diff_rental_dates AS (SELECT customer_id,
        next_rental_date - rental_date AS diff_rental_date
FROM cmp_rental_dates
)

SELECT customer_id, first_name, last_name,
    MAX(diff_rental_date) AS max_diff_rental_date
FROM diff_rental_dates
    JOIN customer USING (customer_id)
GROUP BY customer_id, first_name, last_name
HAVING MAX(diff_rental_date) > 180;





-- 3. Aufgabe - LISTAGG
--a)


WITH films_lastest_release AS 
(SELECT name, category_id, title, length, release_year,
        MAX(release_year) OVER (PARTITION BY category_id)
            AS latest_release_year
FROM film
    JOIN film_category USING (film_id)
    JOIN category USING (category_id)
)

SELECT name,
        LISTAGG(title ||
            ' (' || length ||
            ')', ', ')
        WITHIN GROUP (ORDER BY length DESC) AS filme
FROM films_lastest_release
WHERE release_year = latest_release_year
GROUP BY category_id, name;


--b)

SELECT length, title AS film,
        CASE WHEN COUNT(actor_id) = 0 THEN 'no actors'
        ELSE LISTAGG(SUBSTR(first_name, 1, 1)
            || '. '
            || last_name, ', ') -- sortierung der namen fertigstellen
            WITHIN GROUP (ORDER BY last_name, first_name)
            END AS actors
FROM film
    LEFT JOIN film_actor USING (film_id)
    LEFT JOIN actor USING (actor_id)
WHERE release_year = 1991
GROUP BY film_id, title, length
ORDER BY length DESC;

--c)

-- 3c)

WITH tmp_table AS (
    SELECT customer_id, first_name, last_name,
        inventory_id, rental_date,
        DENSE_RANK() OVER (
            PARTITION BY customer_id
            ORDER BY rental_date DESC
        ) AS visit_nr
    FROM customer
        JOIN rental USING (customer_id)
    WHERE customer.store_id = 3
), recent_categories AS (
    SELECT DISTINCT customer_id, first_name, last_name,
        name AS category_name
    FROM tmp_table
        JOIN inventory USING (inventory_id)
        JOIN film_category USING (film_id)
        JOIN category USING (category_id)
    WHERE visit_nr <= 3
)

SELECT last_name || ' ' || first_name AS customer,
        LISTAGG(category_name, ', ')
            WITHIN GROUP (ORDER BY category_name)
            AS recent_interests
FROM recent_categories
GROUP BY customer_id, first_name, last_name
ORDER BY last_name, first_name;