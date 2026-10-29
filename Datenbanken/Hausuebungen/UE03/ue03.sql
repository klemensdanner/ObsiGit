
-- Aufgabe 2

/* 
1. Welcher Store (Filiale) hat keinen oder mehr als eine*n Angestellte*n
 direkt zugeordnet? Geben Sie den Store (id) und zur Kontrolle die
  Anzahl der Angestellten aus. Achten Sie darauf, dass es auch 
  Stores geben kann, denen noch keine Angestellten zugeordnet sind! 
  (1 Punkt) */


SELECT store_id, COUNT(staff_id)
FROM store
     LEFT JOIN staff USING (store_id) -- alle stores bleiben erhalten
GROUP BY store_id
HAVING COUNT(staff_id) <> 1;



/* 2. Ermitteln Sie alle Kund*innen (Vor- und Nachname, ID), die bereits 
Ausleihen getätigt haben (rental.customer_id), allerdings noch nie
 einen Film aus der Filiale ausgeliehen haben (inventory.store_id), 
 der sie fest zugeordnet sind (customer.store_id).
  (7 Zeilen, 1,5 Punkt) */


/* 
alle, die bereits irgendwas ausgeliehen haben
MINUS
alle, die einen film aus der filiale ausgeliehen haben, 
der sie fest zugeordnet sind
 */

SELECT first_name, last_name, customer_id
FROM customer
      JOIN rental USING (customer_id)

MINUS

SELECT c.first_name, c.last_name, c.customer_id
FROM customer c
      JOIN rental rent ON c.customer_id = rent.customer_id
      JOIN inventory invent ON rent.inventory_id = invent.inventory_id
WHERE c.store_id = invent.store_id;




 /*  3. Geben Sie die Vor- und Nachnamen aller Kund*innen aus, 
  die sowohl Horror, als auch Familien-Filme ausgeliehen haben. 
  Es sollen nur Kund*innen enthalten sein, die mehr als doppelte 
  so viele Horror-Filme als Familien-Filme ausgeliehen haben.
   (27 Zeilen, 2 Punkte)  */
   



SELECT first_name, last_name
FROM customer
      JOIN rental USING (customer_id)
      JOIN inventory USING (inventory_id)
      JOIN film_category USING (film_id)
      JOIN category USING (category_id)
GROUP BY customer_id, first_name, last_name
HAVING COUNT(CASE WHEN name = 'Family' THEN 1 END) > 0
      AND COUNT(CASE WHEN name = 'Horror' THEN 1 END) > 2 * COUNT(CASE WHEN name = 'Family' THEN 1 END);





/*    4. Geben Sie für eine neue Promo-Kampagne alle Schauspieler*innen
    (mindestens Vor- /Nachname) aus, die in mehr als zehn 
    verschiedenen Film-Kategorien spielen. Achten Sie dabei darauf,
     dass manche Schauspieler*innen unter Umständen den gleichen Namen 
     tragen. (188 Zeilen, 1,5 Punkte) */



SELECT first_name, last_name
FROM actor
      JOIN film_actor USING (actor_id)
      JOIN film_category USING (film_id)
GROUP BY first_name, last_name, actor_id
HAVING COUNT(DISTINCT category_id) > 10;




-----------------------------------------------------------

-- Aufgabe 3


/* 1. Listen Sie pro Verkäufer*in und Filiale die Anzahl an 
Verleihvorgängen und damit erzieltem
Umsatz auf. Die Filiale wird über das Inventar zugeordnet 
(inventory.store_id). (36 Zeilen, 2 Punkte)
Achtung: Der Umsatz zählt für den*die Verkäufer*in, 
der den Film verliehen hat, d.h. der die Verleihung eines Films 
durchgeführt hat. Dieser kann sich von der Person unterscheiden, 
die den Bezahlvorgang (payment) durchgeführt hat. 
Beachten Sie, auch Verleihvorgänge zu berücksichtigen, 
für die noch keine Bezahlung vorliegt. */


SELECT verk_fil.store_id,
       verk.first_name,
       verk.last_name,
       COUNT(DISTINCT rent.rental_id), -- distinct, falls es mehrere Zahlungseinträge für die selbe Mietung gibt
       COALESCE(SUM(pay.amount), 0)
FROM staff verk
      JOIN rental rent ON verk.staff_id = rent.staff_id
      JOIN inventory inv ON rent.inventory_id = inv.inventory_id
      JOIN store verk_fil ON inv.store_id = verk_fil.store_id
      LEFT JOIN payment pay ON rent.rental_id = pay.rental_id
GROUP BY verk.first_name, verk.last_name,
      verk.staff_id, verk_fil.store_id;




/* 2. Geben Sie an, welche Kunde*innen (Vorname, Nachname, ID) 
bereits vier oder mehr Horror-Filme ausgeliehen hat. 
Sortieren Sie absteigend nach der Anzahl der Filme. 
(34 Zeilen, 1,5 Punkte) */

SELECT first_name, last_name, customer_id,
      COUNT(CASE WHEN name = 'Horror' THEN 1 END) AS ct_horror
FROM customer
      JOIN rental USING (customer_id)
      JOIN inventory USING (inventory_id)
      JOIN film_category USING (film_id)
      JOIN category USING (category_id)
GROUP BY customer_id, first_name, last_name
HAVING COUNT(CASE WHEN name = 'Horror' THEN 1 END) >= 4
ORDER BY COUNT(CASE WHEN name = 'Horror' THEN 1 END) DESC;




/* 3. Geben Sie pro Kund*in (Vorname, Nachname) der Filiale
 mit der store_id 6 die Summe
geliehener Filme an. Geben Sie auch die Gesamtanzahl 
dieser Filme aus. Sortieren Sie nach
Anzahl aufsteigend. (1 Statement, 32 Zeilen, 1,5 Punkte) */


SELECT first_name, last_name, COUNT(rental_id) AS total_number
FROM customer
      JOIN rental USING (customer_id)
WHERE store_id = 6
GROUP BY GROUPING SETS((first_name, last_name, customer_id), ())
ORDER BY COUNT(rental_id);



---------------------------------------------

-- Aufgabe 4
/* 
Erstellen Sie eine Filmabfrage und ermitteln Sie 
die Anzahl der Filme und die Summe der Längen
in den Kategorien ‚Comedy‘ und ‚Music‘
• je Rating
• je Kategorie und Rating
• über alle gesamt
Entwickeln Sie drei Varianten:
1. einmal mit der Verwendung des GROUP BY ROLLUP Operators (1 Punkt),
2. zum Vergleich dazu mit GROUPING SETS (1 Punkt)
3. und komplett ohne ROLLUP und SETS (Hinweis: 3 Selects mit UNION) (1 Punkt).
Vergleichen Sie die Zugriffspläne und kommentieren Sie diese. */


-- mit ROLLUP
SELECT name AS category_name,
       rating,
       COUNT(film_id) AS film_count,
       SUM(length) AS total_length
FROM film
      JOIN film_category USING (film_id)
      JOIN category USING (category_id)
WHERE name IN ('Comedy', 'Music')
GROUP BY ROLLUP(rating, (category_id, name));



-- mit grouping sets
SELECT name AS category_name,
       rating,
       COUNT(film_id) AS film_count,
       SUM(length) AS total_length
FROM film
      JOIN film_category USING (film_id)
      JOIN category USING (category_id)
WHERE name IN ('Comedy', 'Music')
GROUP BY GROUPING SETS((rating), (category_id, name, rating), ());


-- mit UNION (ALL, damit nicht extra ein distinct geprüft wird (Laufzeit))

-- rating
SELECT NULL AS category_name,
       rating,
       COUNT(film_id) AS film_count,
       SUM(length) AS total_length
FROM film
     JOIN film_category USING (film_id)
     JOIN category USING (category_id)
WHERE name IN ('Comedy', 'Music')
GROUP BY rating

UNION ALL

-- category und rating
SELECT name AS category_name,
       rating,
       COUNT(film_id) AS film_count,
       SUM(length) AS total_length
FROM film
     JOIN film_category USING (film_id)
     JOIN category USING (category_id)
WHERE name IN ('Comedy', 'Music')
GROUP BY category_id, name, rating

UNION ALL

-- total_length
SELECT NULL AS category_name,
       NULL AS rating,
       COUNT(film_id) AS film_count,
       SUM(length) AS total_length
FROM film
     JOIN film_category USING (film_id)
     JOIN category USING (category_id)
WHERE name IN ('Comedy', 'Music');






-----------------------------------------
-- Aufgabe 5

-- 5.1
SELECT manager_staff_id,
       store_id,
       staff_id,
       SUM(amount) AS erloes
FROM store
     JOIN staff USING (store_id)
     JOIN payment USING (staff_id)
GROUP BY GROUPING SETS (
    (manager_staff_id, store_id, staff_id),
    (manager_staff_id, store_id),
    (store_id, staff_id)
);





-- 5.2

/* Erstellen Sie einen Bericht über verliehene Filme. Die Summe des Umsatzes und die Anzahl
der Bezahlvorgänge (payment) soll für jedes Land zusammengefasst werden. Untergliedern
Sie die Zusammenfassung pro Land jeweils nach Jahr, nach Kategorie und gesamt.
Berücksichtigen Sie nur die Kategorien 'Family', 'Children' und 'Travel'. Erstellen Sie ein
SQL-Statement und verwenden Sie GROUPING SETS. Sortieren Sie die Ausgabe nach
Ländern. (2 Punkte) */


SELECT country AS land,
       EXTRACT(YEAR FROM payment_date) AS jahr,
       name AS kategorie,
       COUNT(payment_id) AS anzahl,
       SUM(amount) AS summe
FROM payment
     JOIN rental USING (rental_id, customer_id)
     JOIN customer USING (customer_id)
     JOIN address USING (address_id)
     JOIN city USING (city_id)
     JOIN country USING (country_id)
     JOIN inventory USING (inventory_id)
     JOIN film_category USING (film_id)
     JOIN category USING (category_id)
WHERE name IN ('Family', 'Children', 'Travel')
GROUP BY GROUPING SETS (
    (country, EXTRACT(YEAR FROM payment_date)),
    (country, name),
    (country)
)
ORDER BY land;


-- 5.3 
/* Erstellen Sie eine Abfrage, um für alle Manager*innen, die in den Stores angestellt sind,
folgendes anzuzeigen (1 Punkt):
• Manager-Id
• Store und Gesamterlös für jede*n Manager*in
• Kreuztabellenwerte für die Anzeige des Gesamterlöses für jeden Standort
• Gesamterlös, unabhängig vom Standort und Manager*in */


SELECT manager_staff_id AS manager_id,
       store_id,
       SUM(amount) AS gesamterloes
FROM store
     JOIN staff USING (store_id)
     JOIN payment USING (staff_id)
GROUP BY CUBE (manager_staff_id, store_id)
ORDER BY manager_staff_id NULLS FIRST,
         store_id NULLS FIRST;


-- 5.4

SELECT manager_staff_id AS manager_id,
       store_id,
       SUM(amount) AS gesamterloes,
       GROUPING(manager_staff_id) AS manager_gr,
       GROUPING(store_id) AS store_gr
FROM store
     JOIN staff USING (store_id)
     JOIN payment USING (staff_id)
GROUP BY CUBE (manager_staff_id, store_id)
ORDER BY manager_staff_id NULLS FIRST,
         store_id NULLS FIRST;