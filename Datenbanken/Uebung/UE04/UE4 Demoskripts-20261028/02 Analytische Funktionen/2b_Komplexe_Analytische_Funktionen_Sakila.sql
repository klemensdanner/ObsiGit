-- =====================================================================
-- TEIL 2: Komplexere Beispiele (Sakila)
-- =====================================================================

-- a) Wie viele Filme (gleiche Filme zählen doppelt) hat ein Kunde maximal innerhalb eines Kalenderjahres ausgeliehen?
SELECT customer_id, MAX(r_count) AS within1calYear
FROM (
  SELECT customer_id, EXTRACT(year FROM rental_date) AS r_year, COUNT(*) AS r_count
  FROM rental
  GROUP BY customer_id, EXTRACT(year FROM rental_date)
)
GROUP BY customer_id;


-- b) Wie viele Filme (gleiche Filme zählen doppelt) hat ein Kunde maximal innerhalb eines Jahres (= 365 Tage <> Kalenderjahr) ausgeliehen?
SELECT customer_id, MAX(r_count) AS within1year
FROM (
  SELECT customer_id, rental_id, rental_date, 
		 COUNT(*) OVER (PARTITION BY customer_id ORDER BY rental_date RANGE NUMTODSINTERVAL(365, 'day') PRECEDING) AS r_count
  FROM rental
)
GROUP BY customer_id;


-- c) Premium-Kunden
-- Ein Kunde erhält den Premium-Status, wenn sein bisheriger Umsatz größer als 300 ist. 
-- Aufgabe: Ermittlung von Premiumkunden, das Datum an dem der Premium-Status erreicht wurde 
-- und wie oft der Kunde nach diesem Tag noch Umsatz erzeugt hat 
-- (= wie viele Datensätze für diesen Kunden sind nach diesem Datum noch in der Tabelle payment enthalten).
SELECT first_name, last_name, payment_date, rentals
FROM (
  SELECT first_name, last_name, payment_date, spent, rentals, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY payment_date) AS num     -- Sub-Select um erste Zeile zu ermitteln, wann der Premium-Status erreicht wurde
  FROM (
    SELECT customer_id, first_name, last_name, payment_date,        -- Sub-Select ermittelt Summe pro Kunde und Anzahl der Verleihvorgänge danach (sh. Window)
           SUM(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) AS spent,
           COUNT(rental_id) OVER (PARTITION BY customer_id ORDER BY payment_date ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING) AS rentals
    FROM payment
      INNER JOIN customer USING (customer_id)
  )
  WHERE spent > 300
)
WHERE num = 1;


-- d) Zahlungshistorie aller Kunden (optional)
-- Aufgabe: Für jede Zahlung soll ausgegeben werden, welcher Kunde wann bezahlt hat 
-- und wie viel der Kunde bis dahin insgesamt ausgegeben hat.
-- Zum Vergleich soll auch der Gesamtumsatz bei der vorherigen und bei der nächsten Zahlung angezeigt werden.

-- Außerdem soll ausgegeben werden, wie viele Zahlungen/Ausleihungen danach noch folgten, 
-- und auch hier der Wert davor und danach.
SELECT first_name, last_name, payment_date, spent,  
    LAG(spent) OVER (PARTITION BY customer_id ORDER BY payment_date) AS lag_spent, 
    LEAD(spent) OVER (PARTITION BY customer_id ORDER BY payment_date) AS lead_spent,
    rentals,        
    LAG(rentals) OVER (PARTITION BY customer_id ORDER BY payment_date) AS lag_rentals,
    LEAD(rentals) OVER (PARTITION BY customer_id ORDER BY payment_date) AS lead_rentals
FROM (
    SELECT customer_id, first_name, last_name, payment_date,        -- Sub-Select ermittelt Summe pro Kunde und Anzahl der Verleihvorgänge danach (sh. Window)
           SUM(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) AS spent,
           COUNT(rental_id) OVER (PARTITION BY customer_id ORDER BY payment_date ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING) AS rentals
    FROM payment
      INNER JOIN customer USING (customer_id)
);