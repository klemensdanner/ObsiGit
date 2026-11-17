
-- Aufgabe 1


























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
FROM monitor_sessions;


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


