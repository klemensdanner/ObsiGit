
-- Erstellen Sie eine Liste aller Schauspieler*innen. Verketten Sie Vor- und Nachname (getrennt
-- durch ein Leerzeichen) und nennen Sie die neue Spalte „Name“. Sortieren Sie das Ergebnis
-- nach dem Nachnamen. (1 Punkt)

--1.1

SELECT first_name || ' ' || last_name AS Name
FROM actor
ORDER BY last_name;


--1.2
/* Geben Sie eine Liste mit Titel und Länge all jener Filme aus, die mindestens 120 Minuten
dauern und deren Titel an zweiter Stelle ein 'A' enthält. Geben Sie die Titel so aus, dass jeweils
der erste Buchstabe eines Wortes mit einem Großbuchstaben beginnt (zB Calendar Gunfight).
(1 Punkt) */


SELECT INITCAP(title), length
FROM film
WHERE length >= 120 AND title LIKE '_A%';






/* 1.3. Geben Sie alle Inventar-Ids aus, die noch nie verliehen wurden. Verwenden Sie einen
Mengenoperator. (1 Punkt) */

SELECT inventory_id
FROM inventory
MINUS
SELECT inventory_id
FROM rental;



/* 1.4. Geben Sie für alle Mitarbeiter*innen folgende Informationen aus: den Nachnamen als
„StaffName“, die ID (store_id) der zugeordneten Filiale sowie den Nachnamen des Managers
der jeweiligen Filiale als „ManagerName“. (1,5 Punkte) */

SELECT employee.last_name AS StaffName,
        employee.store_id AS ID,
        manager.last_name AS ManagerName
FROM staff employee
    JOIN store ON store.store_id = employee.store_id
    JOIN staff manager ON store.manager_staff_id = manager.staff_id;





/* 
1.5. Geben Sie die Anzahl der Verleihvorgänge im Jahr 2015 aus (Start des Verleihvorgangs,
rental_date). (1 Punkt) */

SELECT COUNT(*) AS CtRentals
FROM rental
WHERE EXTRACT(YEAR FROM rental_date) = 2015;


SELECT COUNT(*) AS CtRentals
FROM (SELECT rental_id
        FROM rental
        WHERE EXTRACT(YEAR FROM rental_date) = 2015)

;


/* 1.6. Geben Sie für alle Verleihvorgänge die ID sowie das Rückgabedatum (in absteigender
Reihenfolge, nicht abgeschlossene Verleihvorgänge zuerst) in folgendem Format aus:
‚Wed, 14th October 2026‘. Wenn noch kein Rückgabedatum vorhanden ist, soll stattdessen der
Text „not returned yet“ ausgegeben werden. Verwenden Sie zur Formatierung des Datums die
Funktion TO_CHAR. Achten Sie darauf, die Wochentags- und Monatsnamen in englischer
Sprache auszugeben, indem Sie den passenden NLS-Parameter setzen. Recherchieren Sie bei
Bedarf in der Oracle-Dokumentation. (1,5 Punkte) */

SELECT rental_id, COALESCE(TO_CHAR(return_date, 'FMDy, ddth Month YYYY', 'NLS_DATE_LANGUAGE = english'), 'not returned yet') AS return_date
FROM rental
ORDER BY return_date DESC;





-----------------------------------------------------------------

-- 2. Gruppierungen und Unterabfragen


/* 1. Geben Sie Vor- und Nachnamen aller 
Schauspieler*innen aus, die in keinem Film der 
Kategorie „Horror“ mitgespielt haben. 
Verwenden Sie KEINEN Mengenoperator.
(44 Zeilen, 1,5 Punkte) */

/*
- actor --> film_actor --> film_category

m1 -- alle Schauspieler min in 1 Horrorfilm
m2 -- alle Schauspieler, deren actor_id
nicht in m1 ist
*/

-- m1: 


SELECT first_name, last_name
FROM actor
WHERE actor_id NOT IN
        (SELECT actor_id
        FROM actor
        JOIN film_actor USING (actor_id)
        JOIN film_category USING (film_id)
        JOIN category USING (category_id)
        WHERE category.name = 'Horror');



/* 2. Geben Sie die Vor- und Nachnamen aller 
Kund*innen aus, die eine Adresse in den
„United States“ aufweisen, deren zugewiesene 
Hauptfiliale (customer.store_id) sich aber in
„Canada“ befindet.
(17 Zeilen, 1,5 Punkte) */


SELECT *
FROM customer c
     -- Kundenpfad
     JOIN address ca ON c.address_id = ca.address_id
     JOIN city cci ON ca.city_id = cci.city_id
     JOIN country cco ON cci.country_id = cco.country_id
     -- store Pfad
     JOIN store cs ON c.store_id = cs.store_id
     JOIN address st_addr ON cs.address_id = st_addr.address_id
     JOIN city st_city ON st_addr.city_id = st_city.city_id
     JOIN country st_country ON st_city.country_id = st_country.country_id
WHERE cco.country = 'United States' AND st_country.country = 'Canada';
































/* 3. Geben Sie Vor- und Nachnamen sowie den Gesamtumsatz (Summe aller Zahlungen) jener
Kund*innen aus, deren Gesamtumsatz über dem durchschnittlichen Gesamtumsatz pro Kund*in
liegt. Sortieren Sie absteigend nach dem Umsatz.
(285 Zeilen, 2 Punkte) */





/* 4. Ermitteln Sie alle Filmtitel, die kürzer oder gleich lange dauern als der Film mit der ID 50.
Geben Sie von diesen Titeln allerdings nur jene mit den größten Ersetzungskosten aus.
Sortieren Sie nach Filmtitel.
(53 Zeilen, 2 Punkte) */









/* 5. Ermitteln Sie für jede Sprache den längsten Film mit einer Dauer von höchstens 120 Minuten.
Verwenden Sie dafür die Spalte language_id. Berücksichtigen Sie nur Filme, bei denen eine
Originalsprache (original_language_id) hinterlegt ist. Haben mehrere Filme dieselbe
maximale Dauer, sollen alle ausgegeben werden. Geben Sie den Namen der Sprache sowie die
Titel und Länge der Filme aus, sortieren Sie nach Sprache.
(11 Zeilen, 2,5 Punkte) */











/* 6. Geben Sie die neun zuletzt verliehenen Filme und das Verleihdatum im Format ‘YYYY-MM-
DD‘ aus. Welche Möglichkeiten haben Sie, um die „neun letzten“ Filme zu ermitteln?
(1,5 Punkte) */