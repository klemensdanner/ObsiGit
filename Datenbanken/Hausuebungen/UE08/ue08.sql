

-- Aufgabe 1
-- 1.1)
CREATE TABLE schema_logging (
    session_id NUMBER,
    time TIMESTAMP,
    db_user VARCHAR2(255),
    os_user VARCHAR2(255),
    ip VARCHAR2(50),
    host_name VARCHAR2(255),
    object VARCHAR2(500)
);


-- 1.2

SELECT SYS_CONTEXT('USERENV', 'SESSIONID') AS session_id,
       SYS_CONTEXT('USERENV', 'SESSION_USER') AS db_user,
       SYS_CONTEXT('USERENV', 'OS_USER') AS os_user,
       SYS_CONTEXT('USERENV', 'IP_ADDRESS') AS ip,
       SYS_CONTEXT('USERENV', 'HOST') AS host_name
FROM dual;


CREATE OR REPLACE TRIGGER monitor_login
AFTER LOGON ON SCHEMA
DECLARE
    m_session_id schema_logging.session_id % TYPE 
        := SYS_CONTEXT('USERENV', 'SESSIONID');
    m_ip schema_logging.ip % TYPE 
        := SYS_CONTEXT('USERENV', 'IP_ADDRESS');
    m_os_user schema_logging.os_user % TYPE 
        := SYS_CONTEXT('USERENV', 'OS_USER');
    m_host_name schema_logging.host_name % TYPE 
        := SYS_CONTEXT('USERENV', 'HOST');
    m_db_user schema_logging.db_user % TYPE 
        := SYS_CONTEXT('USERENV', 'SESSION_USER');
    m_current_time DATE := SYSDATE;
    m_clock_time NUMBER;
BEGIN
    -- Uhrzeit extrahieren
    m_clock_time := m_current_time - TRUNC(m_current_time);
    -- logon time checken, ob sie zwischen 16h und 6h ist
    IF ((m_clock_time < (6/24)) OR (m_clock_time > (16/24))) THEN
        INSERT INTO schema_logging (session_id, ip, os_user, 
                                        host_name, db_user, time)
        VALUES (m_session_id, m_ip, m_os_user, m_host_name,
                m_db_user, SYSTIMESTAMP);
    END IF;
END;
/


-- 1.3)
-- ich melde mich zweimal aus und ein, damit ich Effekte sehe.
-- schöne Ausgabe machen und nachschauen:

SELECT TO_CHAR(time, 'DD.MM.YYYY HH24:MI:SS') AS time,
        session_id, db_user, os_user, ip, host_name, object
FROM schema_logging;

-- 1.4) Zusätzlich: alle CREATE und ALTER Operationen, zu jeder Uhrzeit
-- Object ist: Aktion: Tabelle, z.B. ALTER TABLE: PAYMENT
CREATE OR REPLACE TRIGGER monitor_login
AFTER LOGON OR CREATE OR ALTER
ON SCHEMA
DECLARE
    m_session_id schema_logging.session_id % TYPE 
        := SYS_CONTEXT('USERENV', 'SESSIONID');
    m_ip schema_logging.ip % TYPE 
        := SYS_CONTEXT('USERENV', 'IP_ADDRESS');
    m_os_user schema_logging.os_user % TYPE 
        := SYS_CONTEXT('USERENV', 'OS_USER');
    m_host_name schema_logging.host_name % TYPE 
        := SYS_CONTEXT('USERENV', 'HOST');
    m_db_user schema_logging.db_user % TYPE 
        := SYS_CONTEXT('USERENV', 'SESSION_USER');
    m_current_time DATE := SYSDATE;
    m_clock_time NUMBER;
    m_object schema_logging.object%TYPE;
BEGIN
    -- Uhrzeit extrahieren
    m_clock_time := m_current_time - TRUNC(m_current_time);
    -- logon time checken, ob sie zwischen 16h und 6h ist
    -- String bauen:
    IF ORA_SYSEVENT IN ('CREATE', 'ALTER') THEN
        m_object := ORA_SYSEVENT || ' ' || ORA_DICT_OBJ_TYPE || ': ' || ORA_DICT_OBJ_NAME;
    END IF;


    IF (ORA_SYSEVENT = 'LOGON' AND ((m_clock_time < (6/24)) OR (m_clock_time > (16/24))))
        OR ORA_SYSEVENT IN ('CREATE', 'ALTER') THEN
        INSERT INTO schema_logging (session_id, ip, os_user,
                                        host_name, db_user, time, object)
        VALUES (m_session_id, m_ip, m_os_user, m_host_name,
                m_db_user, SYSTIMESTAMP, m_object);
    END IF;
END;
/


-- Testweise eine Tabelle anlegen (einfach aus dem demo skript):
CREATE TABLE new_emps AS
	SELECT employee_id, last_name, salary, department_id
	FROM employees;

ALTER TABLE new_emps ADD (
    new_test_column VARCHAR2(20)
);

CREATE SEQUENCE test_sequence;


CREATE TABLE new_emps1 AS
	SELECT employee_id, last_name, salary, department_id
	FROM employees;


SELECT TO_CHAR(time, 'DD.MM.YYYY HH24:MI:SS') AS time,
        session_id, db_user, os_user, ip, host_name, object
FROM schema_logging
ORDER BY time ASC;

-- 1.5)
SELECT TO_CHAR(time, 'DD.MM.YYYY HH24:MI:SS') AS time,
        session_id, db_user, os_user, ip, host_name, object
FROM schema_logging
ORDER BY time ASC;



-- Aufgabe 2
SELECT *
FROM evaluation_rental;

CREATE OR REPLACE PROCEDURE check_amount
    (p_film_id IN film.film_id%TYPE,
     p_paid_amount IN NUMBER,
     p_rented_days IN NUMBER)
IS
    m_target_amount NUMBER;
    m_discount NUMBER;

BEGIN
    -- calculate target amount
    SELECT rental_rate * p_rented_days
        INTO m_target_amount
    FROM film
    WHERE film_id = p_film_id;

    IF (p_paid_amount < 0.8 * m_target_amount) THEN
        m_discount := ROUND(((1 - (p_paid_amount / m_target_amount)) * 100), 2);
        RAISE_APPLICATION_ERROR(-20003, 
        'Invalid amount for film ' ||
        p_film_id ||
        ', the given discount of ' ||
        m_discount ||
        '% is too high.');
    END IF;
END;
/

-- usage:
-- check_amount(film_id, paid_amount, rented_days);


BEGIN
    check_amount(200, 5, 3);
END;
/


-- 2.2)

CREATE OR REPLACE TRIGGER check_amount_trg
BEFORE INSERT OR UPDATE OF rental_id, amount, payment_date 
    ON payment
FOR EACH ROW
DECLARE
    m_film_id film.film_id%TYPE;
    m_rental_duration NUMBER;

BEGIN
    -- film_id und verleihdauer aus rental und inventory
    SELECT film_id,
            CEIL(return_date - rental_date) AS rental_duration -- jeder angebrochene Tag zählt
    INTO m_film_id, m_rental_duration
    FROM rental
        JOIN inventory USING (inventory_id)
    WHERE rental_id = :NEW.rental_id; -- zu der neuen rental_id die richtigen werte finden
    
    IF :NEW.payment_date > SYSDATE THEN
        :NEW.payment_date := SYSDATE;
    END IF;
    check_amount(m_film_id, :NEW.amount, m_rental_duration);
END;
/


-- 2.3 Testen:

SELECT payment_id, amount,
       TO_CHAR(payment_date, 'DD.MM.YYYY HH24:MI:SS') AS payment_date
FROM payment
WHERE payment_id IN (6500, 3000, 1200);

UPDATE payment
SET amount = 10
WHERE payment_id = 6500;

UPDATE payment
SET amount = 10
WHERE payment_id = 3000;
-- funktioniert


UPDATE payment
SET payment_date = SYSDATE + 1
WHERE payment_id = 1200;

SELECT payment_id, amount,
       TO_CHAR(payment_date, 'DD.MM.YYYY HH24:MI:SS') AS payment_date
FROM payment
WHERE payment_id IN (6500, 3000, 1200);

SELECT TO_CHAR(SYSDATE, 'DD.MM.YYYY HH24:MI:SS')
FROM DUAL;

ROLLBACK;





----------------------------------------
-- Aufgabe 3

-- gegebener code wird ausgeführt
CREATE TABLE new_rental AS
SELECT *
FROM rental;
ALTER TABLE new_rental ADD CONSTRAINT new_rental_pk PRIMARY KEY  (rental_id);

CREATE TABLE new_customer (customer_id, store_id NULL, first_name, last_name, email, address_id NULL, active, create_date, last_update) AS
SELECT *
FROM customer;

ALTER TABLE new_customer ADD CONSTRAINT new_customer_pk PRIMARY KEY  (customer_id);


-- 3.1 Sicht erstellen
CREATE OR REPLACE VIEW premium_customer AS
SELECT customer_id, first_name, last_name,
        COUNT(inventory_id) AS numFilms
FROM new_customer
    JOIN new_rental USING (customer_id)
GROUP BY customer_id, first_name, last_name
HAVING COUNT(inventory_id) > 30;

SELECT *
FROM premium_customer
ORDER BY numfilms ASC;

-- 3.2
SELECT MAX(customer_id)
FROM new_customer;
-- 599; neue werte ab 600 einfügen

CREATE SEQUENCE gen_customer_id
    START WITH 600
    INCREMENT BY 1;

CREATE OR REPLACE TRIGGER modify_premium_customer
  INSTEAD OF INSERT OR UPDATE OR DELETE ON premium_customer
  FOR EACH ROW
DECLARE
    m_new_customer_id new_customer.customer_id%TYPE;
    m_count NUMBER;
BEGIN
     
    IF INSERTING THEN
        -- zuweisen:
        m_new_customer_id := :NEW.customer_id;
        IF m_new_customer_id IS NULL THEN
            -- in schleife zuweisen
            LOOP
                -- neuen value zuweisen
                m_new_customer_id := gen_customer_id.nextVal;

                -- abfragen wie oft es die schon gibt
                SELECT COUNT(*)
                    INTO m_count
                FROM new_customer
                WHERE customer_id = m_new_customer_id;

                -- exit wenn sis nicht gibt - dann darf sie verwendet werden
                EXIT WHEN m_count = 0;
            END LOOP;
        END IF;

        INSERT INTO new_customer (customer_id, first_name, last_name
        , create_date, last_update)
        VALUES (m_new_customer_id, :NEW.first_name, :NEW.last_name, SYSDATE, SYSDATE);
    ELSIF UPDATING('numFilms') THEN
        RAISE_APPLICATION_ERROR(-20006, 'Cannot modify numFilms');
    ELSIF UPDATING('customer_id') THEN
        RAISE_APPLICATION_ERROR(-20007, 'Cannot modify primary key customer_id');
    ELSIF UPDATING THEN
        UPDATE new_customer
        SET first_name = :NEW.first_name,
            last_name = :NEW.last_name,
            last_update = SYSDATE
        WHERE customer_id = :OLD.customer_id;
    ELSIF DELETING THEN
        DELETE FROM new_rental
        WHERE customer_id = :OLD.customer_id;

        DELETE FROM new_customer
        WHERE customer_id = :OLD.customer_id;
    END IF;
END;
/



-- 3.3) Testen (vorgegebener code)
-------

-- 3.3.T1)
-- vor dem Insert: es gibt keine 'Poppins'
SELECT *
FROM new_customer
WHERE last_name = 'Poppins';
-- kein Ergebnis

SELECT *
FROM premium_customer
WHERE last_name = 'Poppins';
-- kein Ergebnis

INSERT INTO premium_customer (customer_id, first_name, last_name) 
       VALUES (3000, 'Mary', 'Poppins');
INSERT INTO premium_customer (first_name, last_name) 
       VALUES ('Mary', 'Poppins');

-- es gibt keine Möglichkeit, über die View in new_rental einzufügen
-- Daher eine Abfrage auf new_customer
-- nach dem statement:
SELECT *
FROM new_customer
WHERE last_name = 'Poppins';
-- es gibt zwei Poppins, eine mit customer_id 3000 und eine mit einer neu generierten customer_id

-- Abfragen auf die Sicht:
SELECT *
FROM premium_customer
WHERE last_name = 'Poppins';
-- kein Ergebnis, weil neue Kunden keine Premiumkunden sind (noch keine Filme ausgeliehen)



-- 3.3.T2

SELECT *
FROM premium_customer
WHERE last_name = 'Poppins';

-- 3.3.T3
-- Abfrage vor dem Löschen
SELECT *
FROM premium_customer
WHERE customer_id = 51;

SELECT *
FROM new_customer
WHERE customer_id = 51;

SELECT *
FROM new_rental
WHERE customer_id = 51;


DELETE FROM premium_customer
WHERE customer_id = 51;

-- 3.3.T4
UPDATE premium_customer
   SET numFilms = 40
 WHERE customer_id = 470;
 

-- 3.3.T5
UPDATE premium_customer
   SET customer_id = 40
 WHERE customer_id = 470; 


-- 3.3.T6
SELECT *
FROM new_customer
WHERE customer_id = 470;

SELECT *
FROM premium_customer
WHERE customer_id = 470;

UPDATE premium_customer
   SET first_name = 'John',
       last_name = 'Smith'
 WHERE customer_id = 470;  
------------- End vorgegebener code


ROLLBACK;


-- Aufräumen:
DROP VIEW premium_customer;
DROP SEQUENCE gen_customer_id;
DROP TABLE new_rental;
DROP TABLE new_customer;




-- Aufgabe 1.5 nach der Bearbeitung des Rests.
SELECT TO_CHAR(time, 'DD.MM.YYYY HH24:MI:SS') AS time,
        session_id, db_user, os_user, ip, host_name, object
FROM schema_logging
ORDER BY time ASC;
-- nochmal ausgeführt

