-- 1. Welche Filme sind vor 1985 entstanden und behandeln das Thema Datenbank (Beschreibung enthält 'Database')?

SELECT *
FROM film
WHERE (release_year < 1985) AND description LIKE '%Database%';



-- 2. Ermitteln Sie, wie viele Verleihvorgänge ein Mitarbeiter durchschnittlich ausführt.
SELECT staff_id, last_name, COUNT(rental_id) AS anzahl_verleih
FROM staff
    INNNER JOIN rental USING (staff_id)
GROUP BY staff_id, last_name;


SELECT AVG(cnt)
FROM (
    SELECT staff_id, COUNT(*) AS cnt
    FROM rental
    GROUP BY staff_id
);

SELECT AVG(COUNT(*))
FROM rental
GROUP BY staff_id;



-- 3. Wie lautet der Titel des kürzesten Films/der kürzesten Filme?

-- 3.a) 10 beliebige Filme ausgeben

SELECT *
FROM film
WHERE ROWNUM < 11;


-- 3.b) Titel des kürzesten Films/der kürzesten Filme

SELECT title, length
FROM film
WHERE length = (SELECT MIN(length) FROM film);






-- 4. Welcher Kunde borgt die meisten Filme aus Kategorie 'Animation' aus?


-- alle Filme der Kategorie Animation
-- GROUP BY Kunde, im SELECT COUNT()
-- Diejenigen Kunden auswählen, die diesen count haben


SELECT customer_id, last_name, COUNT(*)
FROM category
    INNER JOIN film_category USING (category_id)
--    INNER JOIN film USING (film_id)
    INNER JOIN inventory USING (film_id)
    INNER JOIN rental USING (inventory_id)
    INNER JOIN customer USING (customer_id)
WHERE category.name = 'Animation'
GROUP BY customer_id, last_name

HAVING COUNT(*) = (
    SELECT MAX(COUNT(*))
    FROM category
    INNER JOIN film_category USING (category_id)
    --    INNER JOIN film USING (film_id)
    INNER JOIN inventory USING (film_id)
    INNER JOIN rental USING (inventory_id)
    INNER JOIN customer USING (customer_id)
    WHERE category.name = 'Animation'
    GROUP BY customer_id, last_name


);











-- 5. Geben Sie das Geburtsdatum von Schauspieler im Format 14. Oktober 2026 aus.