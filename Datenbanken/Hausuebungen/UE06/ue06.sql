-- Aufgabe 1
-- 1.1
SELECT film_id, title, rental_duration,
        COUNT(rental_id) AS rental_ct,
        COUNT(return_date) AS rental_return_ct,
        COUNT(CASE WHEN
                (return_date - rental_date) > rental_duration
                THEN 1 END) 
                AS late_return_ct
FROM film
    LEFT JOIN inventory USING (film_id)
    LEFT JOIN rental using (inventory_id)
GROUP BY film_id, title, rental_duration
ORDER BY film_id;

SET SERVEROUTPUT ON;
-- 1.2
DECLARE
    m_title film.title%TYPE;
    m_rental_duration film.rental_duration%TYPE;
    m_rental_ct NUMBER(20);
    m_rental_return_ct NUMBER(20);
    m_late_return_ct NUMBER(20);
    m_late_return_ratio NUMBER(4,1);
BEGIN
    SELECT title,
        rental_duration,
        COUNT(rental_id) AS rental_ct,
        COUNT(return_date) AS rental_return_ct,
        COUNT(CASE WHEN
                (return_date - rental_date) > rental_duration
                THEN 1 END) 
                AS late_return_ct
        INTO m_title,
            m_rental_duration,
            m_rental_ct,
            m_rental_return_ct,
            m_late_return_ct
    FROM film
        LEFT JOIN inventory USING (film_id)
        LEFT JOIN rental using (inventory_id)
    WHERE film_id = '&film_id'
    GROUP BY film_id, title, rental_duration;

    -- calc m_late_return_ratio
    IF (m_rental_return_ct != 0) THEN
        m_late_return_ratio := ROUND(100 * COALESCE((m_late_return_ct / m_rental_return_ct), 0), 1); -- Wert auf eine Nachkommastelle
    ELSE m_late_return_ratio := 0; -- wenn kein Film zurückgegeben wurde, ist kein Film zu spät gewesen
    END IF;

    -- Ausgaben:
    DBMS_OUTPUT.PUT_LINE('Film: ' || m_title 
            || ' (erlaubte Leihdauer: ' 
            || m_rental_duration || ' Tage');
    DBMS_OUTPUT.PUT_LINE('Verleihvorgänge: '
            || m_rental_ct || ', davon zurückgegeben: '
            || m_rental_return_ct);
    DBMS_OUTPUT.PUT_LINE('Verspätet zurückgegeben: '
            || m_late_return_ct || ' ('
            || m_late_return_ratio || ' %)');
    DBMS_OUTPUT.PUT('Empfehlung: ');
    CASE
        WHEN m_late_return_ratio > 30 THEN DBMS_OUTPUT.PUT_LINE('Penalty dringend empfohlen');
        WHEN m_late_return_ratio > 10 THEN DBMS_OUTPUT.PUT_LINE('Penalty prüfen');
        ELSE DBMS_OUTPUT.PUT_LINE('keine Maßnahme nötig');
    END CASE;
END;
/



-- 1.3
-- penalty: film 4
-- penalty prüfen: film 103
-- keine Maßnahme: Film 3

-----------------------------------------------------
-- Aufgabe 2
-- 2.1
INSERT INTO staff (staff_id, first_name, last_name,
                address_id, store_id, username,
                last_update)
VALUES (9, 'Klemens', 'Danner',9, 1, USER, SYSTIMESTAMP);
COMMIT;

SELECT * FROM STAFF;


-- 2.2
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


-- 2.3. und 2.4 -- für 2.4 ein zweites Mal ausführen
-- Verleihe film_id 3 so oft bis es nix mehr gibt
-- rent_film(customer_id, film_id);
BEGIN
    rent_film(1, 3);
    rent_film(1, 3);
END;
/



-- 2.4


CREATE OR REPLACE PROCEDURE return_film (
    p_rental_id IN evaluation_rental.rental_id%TYPE,
    p_return_date IN DATE DEFAULT SYSDATE
) AS
    m_rental_date evaluation_rental.rental_date%TYPE;
    m_rental_duration film.rental_duration%TYPE;
    m_rental_rate film.rental_rate%TYPE;
    m_replacement_cost film.replacement_cost%TYPE;
    m_late_days NUMBER(10);
    m_penalty evaluation_rental.penalty%TYPE;
BEGIN

    SELECT r.rental_date,
           f.rental_duration,
           f.rental_rate,
           f.replacement_cost
    INTO m_rental_date, m_rental_duration, m_rental_rate,
         m_replacement_cost
    FROM evaluation_rental r
        JOIN inventory i USING (inventory_id)
        JOIN film f USING (film_id)
    WHERE r.rental_id = p_rental_id;

    -- verspätung
    m_late_days := GREATEST(
        CEIL(p_return_date - m_rental_date) - m_rental_duration,
        0
    );

    -- Strafgebühr berechnen
    m_penalty := LEAST(
        m_late_days * m_rental_rate,
        m_replacement_cost
    );

    -- rückgabe übernehmen
    UPDATE evaluation_rental
    SET return_date = p_return_date,
        penalty = m_penalty
    WHERE rental_id = p_rental_id;

    DBMS_OUTPUT.PUT_LINE('Verspätungstage: ' || m_late_days);
    DBMS_OUTPUT.PUT_LINE('Penalty: ' || m_penalty);
END;
/


-- 2.5
-- Testen:
-- rent_film(customer_id, film_id);

BEGIN
    rent_film(1, 4);
    rent_film(1, 5);
    rent_film(1, 6);
    rent_film(1, 7);
END;
/
-- zurückgeben:

-- aktuelles Datum (default)
BEGIN
    return_film(100002);
END;
/

-- nach 10 tagen
BEGIN
    return_film(100003, SYSDATE + 10);
END;
/

-- nach 60 Tagen
BEGIN
    return_film(100004, SYSDATE + 60);
END;
/

-- gestern zurückgegeben
BEGIN
    return_film(100005, SYSDATE - 1);
END;
/



-- Aufgabe 3

-- 3.1
SELECT COUNT(*) AS off_sessions
FROM v$session
WHERE TYPE = 'USER'
        AND username IS NOT NULL;


-- 3.2
CREATE TABLE monitor_sessions (
    id NUMBER(20) PRIMARY KEY,
    session_ct NUMBER(20),
    time TIMESTAMP
);

CREATE SEQUENCE monitor_sessions_seq START WITH 1;

ALTER TABLE monitor_sessions MODIFY
    id DEFAULT monitor_sessions_seq.NEXTVAL;

-- 3.3


INSERT INTO monitor_sessions (session_ct, time)
SELECT COUNT(*), SYSTIMESTAMP
FROM v$session
WHERE TYPE = 'USER'
    AND username IS NOT NULL;

SELECT *
FROM monitor_sessions
ORDER BY id;



-- 3.4

BEGIN
  DBMS_SCHEDULER.CREATE_JOB(
      job_name => 'protocol_session_ct'
     ,job_type => 'PLSQL_BLOCK'
     ,job_action => 'DECLARE
                     BEGIN
                        INSERT INTO monitor_sessions (session_ct, time)
                        SELECT COUNT(*), SYSTIMESTAMP
                        FROM v$session
                        WHERE TYPE = ''USER''
                        AND username IS NOT NULL;
                     END;'
     ,start_date      => SYSDATE
     ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=30'
     ,end_date        => SYSDATE + 7
     ,comments        => 'Protocol of number of opened sessions');
END;
/



BEGIN
    DBMS_SCHEDULER.ENABLE (
        name => 'protocol_session_ct'
        );
END;
/


SELECT job_name, enabled, run_count, next_run_date
FROM user_scheduler_jobs
WHERE job_name = 'PROTOCOL_SESSION_CT';

SELECT log_date, status, error#, job_name
FROM user_scheduler_job_run_details
WHERE job_name = 'PROTOCOL_SESSION_CT'
ORDER BY log_date DESC;


