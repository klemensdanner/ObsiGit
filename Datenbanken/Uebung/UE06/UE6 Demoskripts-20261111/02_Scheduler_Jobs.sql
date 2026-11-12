-- Mit dem DBMS_SCHEDULER Package k�nnen regelm��ige Aufgaben in der Datenbank erstellt werden.
-- Grunds�tzlich k�nnen Sie einen anonymen PL/SQL-Block, eine gespeicherte Prozedur, eine ausf�hrbare Datei, ein externes Skript oder eine Backup-Aufgabe ausf�hren.

DROP TABLE job_test;
CREATE TABLE job_test (
    current_time DATE,
    message VARCHAR2(100)
);

--Vorbereitung/Test des PL/SQL-Blocks f�r den Job 
ALTER SESSION SET NLS_DATE_FORMAT = 'yyyy-mm-dd hh24:mi:ss';
DECLARE
    msg VARCHAR2(100) := NULL;
BEGIN
    IF EXTRACT(hour FROM SYSTIMESTAMP) > 12 THEN
       msg := 'es ist schon nach Mittag';
    ELSE
       msg := 'es ist noch vor Mittag';
    END IF;
    INSERT INTO job_test VALUES (SYSDATE, msg);
END;
/
SELECT * FROM job_test;


-- Anlegen eines einfachen Jobs (anonymer PL/SQL-Block)
BEGIN
  DBMS_SCHEDULER.CREATE_JOB(
      job_name => 'demo_job_schedule'
     ,job_type => 'PLSQL_BLOCK'             -- ein anonymer Block
     ,job_action => 'DECLARE
                        msg VARCHAR2(100) := NULL;
                     BEGIN
                        IF EXTRACT(hour FROM SYSTIMESTAMP) > 12 THEN
                           msg := ''es ist schon nach Mittag'';
                        ELSE
                           msg := ''es ist noch vor Mittag'';
                        END IF;
                        INSERT INTO job_test VALUES (SYSDATE, msg);
                     END;'
     ,start_date      => SYSDATE                    -- fr�hester Job-Beginn
     ,repeat_interval => 'FREQ=SECONDLY;INTERVAL=15'   -- H�ufigkeit
     ,end_date        => SYSDATE + 14               -- Job-Ende
     ,comments        => 'Demo for job schedule.');
END;
/

-- Abfrage der Eintr�ge in der Tabelle 'job_test'
SELECT *
FROM job_test;

-- Abfrage der Scheduler-Jobs
-- Job existiert und ist korrekt definiert, allerdings: enabled => FALSE
SELECT * FROM user_scheduler_jobs;

-- Job wurde nicht gestartet, dh. gibt es auch keine Eintr�ge in der Tabelle
-- Starten des Jobs (Aufruf in PL/SQL-Block)
-- Job kann auch direkt bei Definition gestartet werden: Angabe von "enabled => TRUE"
BEGIN
    DBMS_SCHEDULER.ENABLE (
        name => 'demo_job_schedule'
        );
END;
/

-- Erneute Abfrage der Tabelle
SELECT *
FROM job_test;


-- Demo: L�schen eines Jobs (siehe u.a. Ende des Skripts)
BEGIN
    DBMS_SCHEDULER.DROP_JOB(
       job_name => 'demo_job_schedule'
    );
END;
/


-- Der Schedule f�r den Job kann auch alleine definiert und von mehreren Jobs verwendet werden.

-- Syntax f�r die Angabe eines Intervals: https://docs.oracle.com/cd/B28359_01/server.111/b28310/scheduse004.htm#i1023132
-- TODO: Intervall zum Testen anpassen
BEGIN
  DBMS_SCHEDULER.CREATE_SCHEDULE(  
      schedule_name   => 'demo_schedule'
    , start_date      =>  to_date('11/11/2026 14:00:00', 'dd/mm/yyyy hh24:mi:ss')      -- fr�hester Start
    , repeat_interval => 'FREQ=DAILY; BYHOUR=15,16,17,18,19; BYMINUTE=55,56,57,58,59'  -- jeden Tag um 15, 16, 17 und 18 Uhr, zu den gegebenen Minuten
    , comments        => 'Daily in the afternoon');
END;
/

-- Definierten SCHEDULE anzeigen
SELECT * FROM user_scheduler_schedules;

-- Prozedur 'remind_me' erstellen (wird sp�ter vom Scheduler aufgerufen)
CREATE OR REPLACE PROCEDURE remind_me AS
BEGIN
    INSERT INTO job_test VALUES (SYSDATE, 'go home, it''s already late, you''ll miss the bus');
END;
/

-- Verwenden des erzeugten Schedules und Aufruf der gespeicherten Prozedur
BEGIN
  DBMS_SCHEDULER.CREATE_JOB(
       job_name      => 'demo_job_2'
     , job_type      => 'STORED_PROCEDURE'
     , job_action    => 'remind_me'         -- Name der Prozedur
     , schedule_name => 'demo_schedule'     -- Schedule verwenden
     , enabled => TRUE
     , comments => 'Reminder to catch the bus'); 
END;
/

-- Definierten Job �berpr�fen
SELECT * FROM user_scheduler_jobs;

-- erneute Abfrage der Tabelle
SELECT *
FROM job_test;


-- Bereinigen der angelegten Datenbank-Objekte
BEGIN
    DBMS_SCHEDULER.DROP_JOB(
       job_name => 'demo_job_schedule'
    );
END;
/
BEGIN
    DBMS_SCHEDULER.DROP_SCHEDULE(
      schedule_name => 'demo_schedule'
     ,force => TRUE ); -- erlaubt das L�schen, selbst wenn ein Job darauf referenziert
    
    DBMS_SCHEDULER.DROP_JOB(
       job_name => 'demo_job_2'
    );
END;
/

DROP PROCEDURE remind_me;
DROP TABLE job_test;