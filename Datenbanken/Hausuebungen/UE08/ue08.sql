

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

SELECT TO_CHAR(time, 'DD.MM.YYYY HH24:MI:SS') AS time,
        session_id, db_user, os_user, ip, host_name, object
FROM schema_logging;

