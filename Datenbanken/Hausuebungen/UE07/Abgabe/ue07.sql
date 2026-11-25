-- Aufgabe 1

SET SERVEROUTPUT ON

-- 1.1
-- gegebene Prozedur:

CREATE OR REPLACE PROCEDURE customer_export (id_list IN VARCHAR2)
IS
    CURSOR ids IS
        SELECT to_number(REGEXP_SUBSTR(id_list, '[^, ]+',  1, LEVEL)) id
        FROM dual
        CONNECT BY LEVEL <= LENGTH(id_list) - LENGTH(REGEXP_REPLACE(id_list, ',? ?','')) + 1;
    first_name  customer.first_name%TYPE;
    last_name   customer.last_name%TYPE;
    email       customer.email%TYPE;
BEGIN
    FOR id_rec IN ids LOOP
        SELECT first_name, last_name, email
            INTO first_name, last_name, email
        FROM customer
        WHERE customer_id = id_rec.id
          AND active = 1;
        DBMS_OUTPUT.PUT_LINE(first_name || ',' || last_name || ',' || email);
    END LOOP;
END;
/

SELECT * FROM customer ORDER BY customer_id;



-- 1.1. Testen der bereitgestellten Prozedur

-- a) Angabe keiner ID

EXECUTE customer_export('');

-- b) Angabe einer bzw. mehrerer IDs
BEGIN
    customer_export('2');
    DBMS_OUTPUT.PUT_LINE('');
    customer_export('1,2,3,4');
END;
/
-- c) Angabe mehrerer IDs, gemischt mit inaktiven Kund*innen bzw. IDs, die in der
-- Tabelle customer nicht bekannt sind, zB 10,0,20,3000,271,30

EXECUTE customer_export('10,0,20,3000,271,30');


CREATE OR REPLACE PROCEDURE customer_export_enhanced (id_list IN VARCHAR2)
IS
    CURSOR ids IS
        SELECT to_number(REGEXP_SUBSTR(id_list, '[^, ]+',  1, LEVEL)) id
        FROM dual
        CONNECT BY LEVEL <= LENGTH(id_list) - LENGTH(REGEXP_REPLACE(id_list, ',? ?','')) + 1;
    first_name  customer.first_name%TYPE;
    last_name   customer.last_name%TYPE;
    email       customer.email%TYPE;
BEGIN
    FOR id_rec IN ids LOOP
    BEGIN
        SELECT first_name, last_name, email
            INTO first_name, last_name, email
        FROM customer
        WHERE customer_id = id_rec.id
          AND active = 1;
        DBMS_OUTPUT.PUT_LINE(first_name || ',' || last_name || ',' || email);
    EXCEPTION
            WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Kund*in mit id ' || id_rec.id || ' fehlt');
    END;
    END LOOP;
END;
/

EXECUTE customer_export_enhanced('');
EXECUTE customer_export_enhanced('10,0,20,3000,271,30');


-- 1.3

-- rent_film Fehlerbehandlung
-- Anwendung: rent_film(customer_id, film_id)
CREATE OR REPLACE PROCEDURE rent_film (
    p_customer_id IN evaluation_rental.customer_id%TYPE,
    p_film_id
        IN film.film_id%TYPE) AS
-- variablen
    m_stuff_id staff.staff_id % TYPE;
    m_store_id staff.store_id % TYPE;
    m_object_to_rent inventory.inventory_id % TYPE;
    m_new_rental_id evaluation_rental.rental_id % TYPE;
BEGIN
    SELECT staff_id, store_id
        INTO m_stuff_id, m_store_id
    FROM staff
    WHERE username = USER;

    -- erstbesten freien film finden
    SELECT MIN(i.inventory_id)
        INTO m_object_to_rent
    FROM inventory i
        LEFT JOIN evaluation_rental r
            ON i.inventory_id = r.inventory_id
                AND r.return_date IS NULL
    WHERE i.film_id = p_film_id
        AND i.store_id = m_store_id
        AND r.rental_id IS NULL;
    
    IF m_object_to_rent IS NULL
    THEN
       DBMS_OUTPUT.PUT_LINE('Kein freies Exemplar'); 
    ELSE
        INSERT INTO evaluation_rental (
            rental_date, inventory_id, customer_id,
            staff_id
        ) VALUES (SYSDATE, m_object_to_rent,
            p_customer_id, m_stuff_id)
        RETURNING rental_id INTO m_new_rental_id;
        
        DBMS_OUTPUT.PUT_LINE('Neue rental_id: ' || m_new_rental_id);
        DBMS_OUTPUT.PUT_LINE('Verliehenes Exemplar: ' || m_object_to_rent);
    END IF;
END;
/



-- eigenen user löschen
DELETE FROM staff
WHERE username = USER;

-- schauen ob ich noch drin bin
SELECT *
FROM staff
WHERE username = USER;

-- Prozedur aus UE6 testen ohne staff-Eintrag testen
-- Anwendung: rent_film(customer_id, film_id)
SELECT * FROM film;
SELECT * FROM customer;
EXECUTE rent_film(182, 139);



-- rent_film mit Fehlerbehandlung
CREATE OR REPLACE PROCEDURE rent_film_enhanced (
    p_customer_id IN evaluation_rental.customer_id%TYPE,
    p_film_id
        IN film.film_id%TYPE) AS
-- variablen
    m_stuff_id staff.staff_id % TYPE;
    m_store_id staff.store_id % TYPE;
    m_object_to_rent inventory.inventory_id % TYPE;
    m_new_rental_id evaluation_rental.rental_id % TYPE;

    -- add custom exceptions and inizialize numbers
    user_not_staff_member EXCEPTION;
    PRAGMA EXCEPTION_INIT(user_not_staff_member, -20001);
    unknown_error EXCEPTION;
    PRAGMA EXCEPTION_INIT(unknown_error, -20002);
BEGIN
    BEGIN
        SELECT staff_id, store_id
            INTO m_stuff_id, m_store_id
        FROM staff
        WHERE username = USER;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE user_not_staff_member;
    END;

    -- erstbesten freien film finden
    SELECT MIN(i.inventory_id)
        INTO m_object_to_rent
    FROM inventory i
        LEFT JOIN evaluation_rental r
            ON i.inventory_id = r.inventory_id
                AND r.return_date IS NULL
    WHERE i.film_id = p_film_id
        AND i.store_id = m_store_id
        AND r.rental_id IS NULL;
    
    IF m_object_to_rent IS NULL
    THEN
       DBMS_OUTPUT.PUT_LINE('Kein freies Exemplar'); 
    ELSE
        INSERT INTO evaluation_rental (
            rental_date, inventory_id, customer_id,
            staff_id
        ) VALUES (SYSDATE, m_object_to_rent,
            p_customer_id, m_stuff_id)
        RETURNING rental_id INTO m_new_rental_id;
        
        DBMS_OUTPUT.PUT_LINE('Neue rental_id: ' || m_new_rental_id);
        DBMS_OUTPUT.PUT_LINE('Verliehenes Exemplar: ' || m_object_to_rent);
    END IF;
EXCEPTION
    WHEN user_not_staff_member THEN
        RAISE_APPLICATION_ERROR(-20001, 'User ' || USER || ' ist nicht als Mitarbeiter*in erfasst.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20002, 'Verleih konnte aufgrund eines unbekannten Fehlers nicht durchgeführt werden.');
END;
/


EXECUTE rent_film_enhanced(182, 139);

EXECUTE rent_film_enhanced(NULL);
EXECUTE rent_film_enhanced(NULL, NULL); 



INSERT INTO staff (staff_id, first_name, last_name,
                address_id, store_id, username,
                last_update)
VALUES (9, 'Klemens', 'Danner',9, 1, USER, SYSTIMESTAMP);

EXECUTE rent_film_enhanced(NULL, 140);

--------------------------------------------------------------------

--- Aufgabe 2


SELECT * FROM evaluation_rental;

CREATE OR REPLACE PACKAGE sales_penalty AS
    FUNCTION GetPenalty(p_rental_id IN evaluation_rental.rental_id%TYPE)
        RETURN NUMBER;
    
    PROCEDURE GetOverdueCustomers;

END;
/
select * from customer;

CREATE OR REPLACE PACKAGE BODY sales_penalty AS
    PROCEDURE GetOverdueCustomers
    IS
            -- Deklaration eines Cursor
        CURSOR highest_penalty_cursor IS
            SELECT customer_id,
                    first_name,
                    last_name,
                    SUM(getPenalty(rental_id)) AS total_penalty
            FROM evaluation_rental
                JOIN customer USING (customer_id)
            GROUP BY customer_id, first_name, last_name
            HAVING SUM(getPenalty(rental_id)) > 0
            ORDER BY total_penalty DESC
            FETCH FIRST 10 ROWS ONLY;
    BEGIN
        FOR line in highest_penalty_cursor LOOP
            DBMS_OUTPUT.PUT_LINE(
                line.first_name || ' ' ||
                line.last_name || ' ' ||
                line.total_penalty || ' '
                );
        END LOOP;
    END;

    FUNCTION GetPenalty(p_rental_id IN evaluation_rental.rental_id%TYPE)
        RETURN NUMBER 
    IS
        m_rental_date evaluation_rental.rental_date%TYPE;
        m_rental_duration film.rental_duration%TYPE;
        m_rental_rate film.rental_rate%TYPE;
        m_replacement_cost film.replacement_cost%TYPE;
        m_late_days NUMBER(10); 
        m_penalty evaluation_rental.penalty%TYPE;
        m_return_date evaluation_rental.return_date%TYPE;
    BEGIN
        SELECT r.rental_date,
           f.rental_duration,
           f.rental_rate,
           f.replacement_cost,
           r.return_date
        INTO m_rental_date, m_rental_duration, m_rental_rate,
            m_replacement_cost, m_return_date
        FROM evaluation_rental r
            JOIN inventory i USING (inventory_id)
            JOIN film f USING (film_id)
        WHERE r.rental_id = p_rental_id
            AND r.penalty IS NULL
            AND r.return_date IS NOT NULL;
        -- NO_DATA_FOUND wenn kein passender Datensatz gefunden wird (erster Punkt)
        -- NO_DATA_FOUND wenn penalty not null ist (zweiter Punkt)
        -- NO_DATA_FOUND wenn return_date null ist (dritter Punkt)
        -- diese Ausnahme wird einfach behandelt und dann NULL returnt

        -- verspätung
        m_late_days := GREATEST(
            CEIL(m_return_date - m_rental_date) - m_rental_duration, 0);

        -- Strafgebühr berechnen
        m_penalty := LEAST(
            m_late_days * m_rental_rate,
            m_replacement_cost
    );
        
        RETURN m_penalty;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END GetPenalty;

END;
/




-- 2.1


-- Funktion Testen:
-- Werte zum Testen finden:
SELECT rental_id, sales_penalty.GetPenalty(rental_id)
FROM evaluation_rental
WHERE sales_penalty.GetPenalty(rental_id) > 0
ORDER BY rental_id;



-- a) normaler Datensatz
SELECT sales_penalty.GetPenalty(7)
FROM dual;
-- funktioniert

-- b) in penalty bereits ein Wert eingetragen
SELECT rental_id
FROM evaluation_rental
WHERE penalty IS NOT NULL;

-- gibts nicht, also bekommt rental_id 1 die penalty 100

UPDATE evaluation_rental
SET penalty = 100
WHERE rental_id = 1;

-- jetzt der Test:
SELECT sales_penalty.GetPenalty(1)
FROM dual;
-- liefert null

-- c) kein Rückgabedatum vorhanden
SELECT rental_id
FROM evaluation_rental
WHERE return_date IS NULL;
-- z.B. rental_id 13862

SELECT sales_penalty.GetPenalty(13862)
FROM dual;



-- 2.2. in der Funktion oben

EXECUTE sales_penalty.GetOverdueCustomers;


-- 2.3 top n Kunden absteigend. Bei keiner Angabe eines Parameters nur die top 10
-- umbenannt, damit die oberen testbar bleiben

CREATE OR REPLACE PACKAGE sales_penalty1 AS
    FUNCTION GetPenalty(p_rental_id IN evaluation_rental.rental_id%TYPE)
        RETURN NUMBER;
    
    PROCEDURE GetOverdueCustomers(top_n IN NUMBER DEFAULT 10);

END;
/

CREATE OR REPLACE PACKAGE BODY sales_penalty1 AS
    PROCEDURE GetOverdueCustomers(top_n IN NUMBER DEFAULT 10)
    IS
            -- Deklaration eines Cursor
        CURSOR highest_penalty_cursor IS
            SELECT customer_id,
                    first_name,
                    last_name,
                    SUM(getPenalty(rental_id)) AS total_penalty
            FROM evaluation_rental
                JOIN customer USING (customer_id)
            GROUP BY customer_id, first_name, last_name
            HAVING SUM(getPenalty(rental_id)) > 0
            ORDER BY total_penalty DESC
            FETCH FIRST top_n ROWS ONLY;
    BEGIN
        FOR line in highest_penalty_cursor LOOP
            DBMS_OUTPUT.PUT_LINE(
                line.first_name || ' ' ||
                line.last_name || ' ' ||
                line.total_penalty || ' '
                );
        END LOOP;
    END;

    FUNCTION GetPenalty(p_rental_id IN evaluation_rental.rental_id%TYPE)
        RETURN NUMBER 
    IS
        m_rental_date evaluation_rental.rental_date%TYPE;
        m_rental_duration film.rental_duration%TYPE;
        m_rental_rate film.rental_rate%TYPE;
        m_replacement_cost film.replacement_cost%TYPE;
        m_late_days NUMBER(10); 
        m_penalty evaluation_rental.penalty%TYPE;
        m_return_date evaluation_rental.return_date%TYPE;
    BEGIN
        SELECT r.rental_date,
           f.rental_duration,
           f.rental_rate,
           f.replacement_cost,
           r.return_date
        INTO m_rental_date, m_rental_duration, m_rental_rate,
            m_replacement_cost, m_return_date
        FROM evaluation_rental r
            JOIN inventory i USING (inventory_id)
            JOIN film f USING (film_id)
        WHERE r.rental_id = p_rental_id
            AND r.penalty IS NULL
            AND r.return_date IS NOT NULL;
        -- NO_DATA_FOUND wenn kein passender Datensatz gefunden wird (erster Punkt)
        -- NO_DATA_FOUND wenn penalty not null ist (zweiter Punkt)
        -- NO_DATA_FOUND wenn return_date null ist (dritter Punkt)
        -- diese Ausnahme wird einfach behandelt und dann NULL returnt

        -- verspätung
        m_late_days := GREATEST(
            CEIL(m_return_date - m_rental_date) - m_rental_duration, 0);

        -- Strafgebühr berechnen
        m_penalty := LEAST(
            m_late_days * m_rental_rate,
            m_replacement_cost
    );

        RETURN m_penalty;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END GetPenalty;
END;
/


EXECUTE sales_penalty1.getOverDueCustomers(5);
EXECUTE sales_penalty1.getOverDueCustomers();


--------------------------------------------------------------
-- Aufgabe 3


SELECT * FROM evaluation_rental ORDER BY customer_id;
-- 3.1
CREATE OR REPLACE PACKAGE sales_penalty2 AS
    FUNCTION GetPenalty(p_rental_id IN evaluation_rental.rental_id%TYPE)
        RETURN NUMBER;
    
    PROCEDURE GetOverdueCustomers(top_n IN NUMBER DEFAULT 10);
    PROCEDURE PayPenalty(m_customer_id IN customer.customer_id % TYPE);

END;
/



CREATE OR REPLACE PACKAGE BODY sales_penalty2 AS
    PROCEDURE PayPenalty(m_customer_id IN customer.customer_id % TYPE)
    IS
        -- deklarieren eines cursers
        -- abfrage:
        CURSOR c_pay_penalty IS
            SELECT rental_id
            FROM evaluation_rental
            WHERE customer_id = m_customer_id
                AND penalty IS NULL
                AND return_date IS NOT NULL
        FOR UPDATE;

        m_penalty evaluation_rental.penalty%TYPE;

    BEGIN
        FOR line IN c_pay_penalty LOOP
            m_penalty := GetPenalty(line.rental_id);

            IF m_penalty > 0 THEN
                UPDATE evaluation_rental
                SET penalty = m_penalty
                WHERE CURRENT OF c_pay_penalty;
            END IF;

        END LOOP;

    END;

    PROCEDURE GetOverdueCustomers(top_n IN NUMBER DEFAULT 10)
    IS
            -- Deklaration eines Cursor
        CURSOR highest_penalty_cursor IS
            SELECT customer_id,
                    first_name,
                    last_name,
                    SUM(getPenalty(rental_id)) AS total_penalty
            FROM evaluation_rental
                JOIN customer USING (customer_id)
            GROUP BY customer_id, first_name, last_name
            HAVING SUM(getPenalty(rental_id)) > 0
            ORDER BY total_penalty DESC
            FETCH FIRST top_n ROWS ONLY;
    BEGIN
        FOR line in highest_penalty_cursor LOOP
            DBMS_OUTPUT.PUT_LINE(
                line.first_name || ' ' ||
                line.last_name || ' ' ||
                line.total_penalty || ' '
                );
        END LOOP;
    END;

    FUNCTION GetPenalty(p_rental_id IN evaluation_rental.rental_id%TYPE)
        RETURN NUMBER 
    IS
        m_rental_date evaluation_rental.rental_date%TYPE;
        m_rental_duration film.rental_duration%TYPE;
        m_rental_rate film.rental_rate%TYPE;
        m_replacement_cost film.replacement_cost%TYPE;
        m_late_days NUMBER(10); 
        m_penalty evaluation_rental.penalty%TYPE;
        m_return_date evaluation_rental.return_date%TYPE;
    BEGIN
        SELECT r.rental_date,
           f.rental_duration,
           f.rental_rate,
           f.replacement_cost,
           r.return_date
        INTO m_rental_date, m_rental_duration, m_rental_rate,
            m_replacement_cost, m_return_date
        FROM evaluation_rental r
            JOIN inventory i USING (inventory_id)
            JOIN film f USING (film_id)
        WHERE r.rental_id = p_rental_id
            AND r.penalty IS NULL
            AND r.return_date IS NOT NULL;
        -- NO_DATA_FOUND wenn kein passender Datensatz gefunden wird (erster Punkt)
        -- NO_DATA_FOUND wenn penalty not null ist (zweiter Punkt)
        -- NO_DATA_FOUND wenn return_date null ist (dritter Punkt)
        -- diese Ausnahme wird einfach behandelt und dann NULL returnt

        -- verspätung
        m_late_days := GREATEST(
            CEIL(m_return_date - m_rental_date) - m_rental_duration, 0);

        -- Strafgebühr berechnen
        m_penalty := LEAST(
            m_late_days * m_rental_rate,
            m_replacement_cost
    );

        RETURN m_penalty;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END GetPenalty;
END;
/


-- 3.2 testen von PayPenalty




EXECUTE sales_penalty2.GetOverdueCustomers;
-- BULL ist der mit der höchsten Strafe (siehe 2.3)
SELECT customer_id
FROM evaluation_rental
    JOIN customer USING (customer_id)
WHERE last_name = 'BULL';
-- Seine customer_id ist also 469

-- dieser soll jetzt bezahlen!
EXECUTE sales_penalty2.PayPenalty(469);
EXECUTE sales_penalty2.GetOverdueCustomers;

-- 3.3
COMMIT;

-- eine zweite test customer_id finden mit:
SELECT customer_id
FROM evaluation_rental
    JOIN customer USING (customer_id)
WHERE last_name = 'DEAN';
-- ihre customer_id ist 236

-- jetzt Test so wie beschrieben durchführen:
-- hier bezahlen:
EXECUTE sales_penalty2.PayPenalty(236);

-- nach Aufruf von EXECUTE in session 2 wird hier committet
COMMIT;

-- 3.4 NOWAIT
CREATE OR REPLACE PACKAGE sales_penalty3 AS
    FUNCTION GetPenalty(p_rental_id IN evaluation_rental.rental_id%TYPE)
        RETURN NUMBER;
    
    PROCEDURE GetOverdueCustomers(top_n IN NUMBER DEFAULT 10);
    PROCEDURE PayPenalty(m_customer_id IN customer.customer_id % TYPE);

END;
/

CREATE OR REPLACE PACKAGE BODY sales_penalty3 AS
    PROCEDURE PayPenalty(m_customer_id IN customer.customer_id % TYPE)
    IS
        -- deklarieren eines cursers
        -- abfrage:
        CURSOR c_pay_penalty IS
            SELECT rental_id
            FROM evaluation_rental
            WHERE customer_id = m_customer_id
                AND penalty IS NULL
                AND return_date IS NOT NULL
        FOR UPDATE NOWAIT;

        m_penalty evaluation_rental.penalty%TYPE;

    BEGIN
        FOR line IN c_pay_penalty LOOP
            m_penalty := GetPenalty(line.rental_id);

            IF m_penalty > 0 THEN
                UPDATE evaluation_rental
                SET penalty = m_penalty
                WHERE CURRENT OF c_pay_penalty;
            END IF;

        END LOOP;

    END;

    PROCEDURE GetOverdueCustomers(top_n IN NUMBER DEFAULT 10)
    IS
            -- Deklaration eines Cursor
        CURSOR highest_penalty_cursor IS
            SELECT customer_id,
                    first_name,
                    last_name,
                    SUM(getPenalty(rental_id)) AS total_penalty
            FROM evaluation_rental
                JOIN customer USING (customer_id)
            GROUP BY customer_id, first_name, last_name
            HAVING SUM(getPenalty(rental_id)) > 0
            ORDER BY total_penalty DESC
            FETCH FIRST top_n ROWS ONLY;
    BEGIN
        FOR line in highest_penalty_cursor LOOP
            DBMS_OUTPUT.PUT_LINE(
                line.first_name || ' ' ||
                line.last_name || ' ' ||
                line.total_penalty || ' '
                );
        END LOOP;
    END;

    FUNCTION GetPenalty(p_rental_id IN evaluation_rental.rental_id%TYPE)
        RETURN NUMBER 
    IS
        m_rental_date evaluation_rental.rental_date%TYPE;
        m_rental_duration film.rental_duration%TYPE;
        m_rental_rate film.rental_rate%TYPE;
        m_replacement_cost film.replacement_cost%TYPE;
        m_late_days NUMBER(10); 
        m_penalty evaluation_rental.penalty%TYPE;
        m_return_date evaluation_rental.return_date%TYPE;
    BEGIN
        SELECT r.rental_date,
           f.rental_duration,
           f.rental_rate,
           f.replacement_cost,
           r.return_date
        INTO m_rental_date, m_rental_duration, m_rental_rate,
            m_replacement_cost, m_return_date
        FROM evaluation_rental r
            JOIN inventory i USING (inventory_id)
            JOIN film f USING (film_id)
        WHERE r.rental_id = p_rental_id
            AND r.penalty IS NULL
            AND r.return_date IS NOT NULL;
        -- NO_DATA_FOUND wenn kein passender Datensatz gefunden wird (erster Punkt)
        -- NO_DATA_FOUND wenn penalty not null ist (zweiter Punkt)
        -- NO_DATA_FOUND wenn return_date null ist (dritter Punkt)
        -- diese Ausnahme wird einfach behandelt und dann NULL returnt

        -- verspätung
        m_late_days := GREATEST(
            CEIL(m_return_date - m_rental_date) - m_rental_duration, 0);

        -- Strafgebühr berechnen
        m_penalty := LEAST(
            m_late_days * m_rental_rate,
            m_replacement_cost
    );

        RETURN m_penalty;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END GetPenalty;
END;
/

COMMIT;

-- eine dritte test customer_id finden mit:
SELECT customer_id
FROM evaluation_rental
    JOIN customer USING (customer_id)
WHERE last_name = 'JOY';
-- ihre customer_id ist 307

-- jetzt Test so wie beschrieben durchführen:
-- hier bezahlen:
EXECUTE sales_penalty3.PayPenalty(307);

-- nach Aufruf von EXECUTE in session 2 wird hier committet
COMMIT;