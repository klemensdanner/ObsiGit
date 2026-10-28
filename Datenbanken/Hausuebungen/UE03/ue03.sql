
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


















/* 2. Geben Sie an, welche Kunde*innen (Vorname, Nachname, ID) 
bereits vier oder mehr Horror-Filme ausgeliehen hat. 
Sortieren Sie absteigend nach der Anzahl der Filme. 
(34 Zeilen, 1,5 Punkte) */


/* 3. Geben Sie pro Kund*in (Vorname, Nachname) der Filiale
 mit der store_id 6 die Summe
geliehener Filme an. Geben Sie auch die Gesamtanzahl 
dieser Filme aus. Sortieren Sie nach
Anzahl aufsteigend. (1 Statement, 32 Zeilen, 1,5 Punkte) */