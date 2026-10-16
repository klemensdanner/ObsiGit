
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