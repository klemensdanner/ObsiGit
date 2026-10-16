
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





/* 1.4. Geben Sie für alle Mitarbeiter*innen folgende Informationen aus: den Nachnamen als
„StaffName“, die ID (store_id) der zugeordneten Filiale sowie den Nachnamen des Managers
der jeweiligen Filiale als „ManagerName“. (1,5 Punkte) */



/* 
1.5. Geben Sie die Anzahl der Verleihvorgänge im Jahr 2015 aus (Start des Verleihvorgangs,
rental_date). (1 Punkt) */





/* 1.6. Geben Sie für alle Verleihvorgänge die ID sowie das Rückgabedatum (in absteigender
Reihenfolge, nicht abgeschlossene Verleihvorgänge zuerst) in folgendem Format aus:
‚Wed, 14th October 2026‘. Wenn noch kein Rückgabedatum vorhanden ist, soll stattdessen der
Text „not returned yet“ ausgegeben werden. Verwenden Sie zur Formatierung des Datums die
Funktion TO_CHAR. Achten Sie darauf, die Wochentags- und Monatsnamen in englischer
Sprache auszugeben, indem Sie den passenden NLS-Parameter setzen. Recherchieren Sie bei
Bedarf in der Oracle-Dokumentation. (1,5 Punkte) */