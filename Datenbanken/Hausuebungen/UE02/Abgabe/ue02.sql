
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




--------------------------------------------------------------------------------------------



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


SELECT c.first_name, c.last_name
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





/* 3. Geben Sie Vor- und Nachnamen sowie den Gesamtumsatz 
(Summe aller Zahlungen) jener Kund*innen aus, 
deren Gesamtumsatz über dem durchschnittlichen Gesamtumsatz 
pro Kund*in liegt. Sortieren Sie absteigend nach dem Umsatz.
(285 Zeilen, 2 Punkte)

amount in payment

Gruppieren nach customer_id
im having Aggregatsfunktionen vergleichen, SUM() > durschnittl. Gesamtumsatz
*/

SELECT first_name, last_name, SUM(amount)
FROM customer
     JOIN payment USING (customer_id)
GROUP BY customer_id, first_name, last_name
HAVING SUM(amount) > (
        -- durchschnittlicher Gesamtumsatz pro Kunde
        SELECT AVG(SUM(amount))
        FROM customer
             JOIN payment USING (customer_id)
        GROUP BY customer_id);



/* 4. Ermitteln Sie alle Filmtitel, die kürzer oder gleich lange dauern als der Film mit der ID 50.
Geben Sie von diesen Titeln allerdings nur jene mit den größten Ersetzungskosten aus.
Sortieren Sie nach Filmtitel.
(53 Zeilen, 2 Punkte) */



/* 

Plan: 


*/

SELECT title
FROM film
WHERE length <= (SELECT length FROM film WHERE film_id = 50)
        AND replacement_cost = (
                SELECT MAX(replacement_cost)
                FROM film
                WHERE length <= (SELECT length FROM film WHERE film_id = 50)
        )
ORDER BY title;






/* 5. Ermitteln Sie für jede Sprache den längsten Film mit einer Dauer von höchstens 120 Minuten.
Verwenden Sie dafür die Spalte language_id. Berücksichtigen Sie nur Filme, bei denen eine
Originalsprache (original_language_id) hinterlegt ist. Haben mehrere Filme dieselbe
maximale Dauer, sollen alle ausgegeben werden. Geben Sie den Namen der Sprache sowie die
Titel und Länge der Filme aus, sortieren Sie nach Sprache.
(11 Zeilen, 2,5 Punkte) 

Plan:

Alle Filme nehmen, im Where filtern:
- nur die, die genau die Maxmallänge ihrer eigenen Sprache haben (korrelierte Unterabfrage)
oder weniger als 120 min
*/

SELECT l.name, f.title, f.length
FROM film f
     JOIN language l ON f.language_id = l.language_id
WHERE f.original_language_id IS NOT NULL
     AND f.length <= 120
     AND f.length = (
        SELECT MAX(f1.length)
        FROM film f1
        WHERE f1.language_id = f.language_id
              AND f1.length <= 120
              AND f1.original_language_id IS NOT NULL
     );





/* 6. Geben Sie die neun zuletzt verliehenen Filme und das Verleihdatum im Format ‘YYYY-MM-
DD‘ aus. Welche Möglichkeiten haben Sie, um die „neun letzten“ Filme zu ermitteln?
(1,5 Punkte) */

SELECT title, TO_CHAR(rental_date, 'YYYY-MM-DD')
FROM film
        JOIN inventory USING (film_id)
        JOIN rental USING (inventory_id)
ORDER BY rental_date DESC
FETCH FIRST 9 ROWS ONLY;

/*
Welche Möglichkeiten haben Sie, um die „neun letzten“ Filme zu ermitteln?
- eine ROW_NUMBER() abfragen und nur ausgeben wenn diese <= 9 ist, 
dabei bei gleichen Werten wird zufällig weitergezählt
- RANK() oder DENSE_RANK(), würde gleiche Werte auch gleiche Reihung geben
*/



--------------------------------------------------------------------------------------------




-- 3. Insert, Update und Delete


/* 1. Erstellen Sie eine neue Tabelle „new_film“, diese soll den gleichen Aufbau wie die Tabelle
„film“ haben, jedoch nur die neueren Filme enthalten. Als neuere Filme gelten jene, die nicht
älter als 25 Jahre sind (setzen Sie dazu das aktuelle Datum in Bezug mit dem Erscheinungsjahr).
(1 Punkt) */



CREATE TABLE new_film AS
SELECT *
FROM film
WHERE EXTRACT(YEAR FROM CURRENT_DATE) - release_year <= 25;


/* 2. Fügen Sie den Film „Love Machine 3“ mit ID = 1001 in Englisch (language_id = 1) 
mit 5 Tagen Verleihdauer (zum Preis von 1,79) mit Ersetzungskosten
 von 21,50 in die Tabelle ein.
(1 Punkt) */

INSERT INTO new_film (title, film_id, language_id, rental_duration, 
                        rental_rate, replacement_cost, last_update)
     VALUES ('Love Machine 3', 1001, 1, 5, 1.79, 21.50, SYSDATE);



/* 3. Erhöhen Sie den Leihpreis der Filme in der Tabelle „new_film“ um 15%, wenn der Leihpreis
kleiner als 2 ist. (0,5 Punkte) */

UPDATE new_film
SET rental_rate = rental_rate * 1.15
WHERE rental_rate < 2;



/* 4. Erstellen Sie eine View, die alle Filme der Tabelle „new_film“ enthält, deren Leihpreis
maximal 2 beträgt, vergeben Sie die Check-Option. Die View soll nur den Filmtitel, die
Beschreibung, den Leihpreis und die Länge enthalten. (1 Punkt) */

CREATE VIEW cheap_new_film AS
SELECT title, description, rental_rate, length
FROM new_film
WHERE rental_rate <= 2
WITH CHECK OPTION;


/* 5. Welche Auswirkungen haben COMMIT und ROLLBACK an dieser Stelle (nachdem Sie die
View erstellt haben). (0,5 Punkte) */
/* 
Die CREATE VIEW Anweisung hat implizit einen COMMIT abgesetzt, weil selbst nach einem weiteren ROLLBACK werden jetzt beim Statement aus Aufgabe 3.3 nur mehr "171 rows updated.", anstatt der vorherigen "196 rows updated.". Die Änderung von Aufgabe 3.3 wurde also entgültig in die Datenbank übernommen.
ROLLBACK setzt also nur bis zum letzten "COMMIT" zurück - in diesem Fall also nur bis zum CREATE VIEW statement. */



/* 6. Können Sie die Datensätze Ihrer neuen View verändern? Wenn ja, führen Sie die Erhöhung der
Filme (15%) ein weiteres Mal durch, diesmal auf Ihre View. Wenn nein, warum nicht?
(0,5 Punkte) */

/* UPDATE cheap_new_film
SET rental_rate = rental_rate * 1.15;


Das darf nicht funktionieren, weil durch die Operation Datensätze aus der VIEW herausfallen würden 
- das wird aber durch die CHECK OPTION von der VIEW verhindert.

 */



/* 7. Löschen Sie alle Einträge aus der Tabelle „new_film“, deren Leihpreis über 1.79 liegt.
(0,5 Punkte) */

DELETE FROM new_film
WHERE rental_rate > 1.79;



/* 8. Können Sie den Leihpreis der Filme in der View nun erhöhen? Erklären Sie dieses Verhalten.
(0,5 Punkte) */

UPDATE cheap_new_film
SET rental_rate = rental_rate * 1.15;
-- Erklärung im pdf



/* 9. Löschen Sie die Tabelle „new_film“ und Ihre erstellte View wieder. (2 Statements, 0,5 Punkte) */

DROP VIEW cheap_new_film;
DROP TABLE new_film;


