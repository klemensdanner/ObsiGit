
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


