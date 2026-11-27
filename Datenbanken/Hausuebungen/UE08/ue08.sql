

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