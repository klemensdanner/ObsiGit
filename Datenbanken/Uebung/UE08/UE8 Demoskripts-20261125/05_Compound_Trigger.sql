-- Compound Trigger zur Vermeidung von Mutating Tables (seit Oracle 11g)
-- Es kommt immer wieder vor, dass bei einem DML-Trigger f�r �berpr�fungen oder Protokollierungen 
-- Daten aus der zu �ndernden Tabelle ben�tigt werden. Ein Row Trigger scheidet dann in der Regel aus, 
-- weil man sonst in das Problem mit Mutating Tables l�uft.
-- Ein Beispiel dazu: Stellen Sie sich vor, eine Gesch�ftsregel besagt, dass niemand innerhalb einer
-- Berufsgruppe mehr als 50% �ber dem Durchschnittsgehalt verdienen darf. Der einfachste Ansatz 
-- dazu sieht folgenderma�en aus:

CREATE OR REPLACE TRIGGER check_sal
  AFTER UPDATE OF salary ON employees
  FOR EACH ROW
DECLARE
  v_avgsal NUMBER;
BEGIN
  SELECT AVG(salary) INTO v_avgsal
    FROM employees
   WHERE job_id = :NEW.job_id;
  IF :NEW.salary > 1.5 * v_avgsal THEN
    RAISE_APPLICATION_ERROR(-20000, 'Verdienst liegt zu weit �ber dem Durchschnitt');
  END IF;
END;
/

-- Ein Update f�hrt zu einem Fehler aufgrund von Mutating Tables
UPDATE employees
   SET salary = 50000
 WHERE employee_id = 100;

--SQL-Fehler: ORA-04091: Tabelle <USER>.EMPLOYEES wird gerade ge�ndert, 
--Trigger/Funktion sieht dies m�glicherweise nicht
--ORA-06512: in "<USER>.CHECK_SAL", Zeile 4
--ORA-04088: Fehler bei der Ausf�hrung von Trigger '<USER>.CHECK_SAL'
--04091. 00000 -  "table %s.%s is mutating, trigger/function may not see it"
--*Cause:    A trigger (or a user defined plsql function that is referenced in
--           this statement) attempted to look at (or modify) a table that was
--           in the middle of being modified by the statement which fired it.
--*Action:   Rewrite the trigger (or function) so it does not read that table.

-- Ein Workaround dazu k�nnte so aussehen, dass man �ber einen BEFORE STATEMENT 
-- Trigger zuerst den Durchschnitt aller Berufsgruppen einliest und beispielsweise 
-- in einer Tabelle zwischenspeichert. Der Row Trigger kann dann auf diese Werte zugreifen, 
-- ohne die zu �ndernde Tabelle lesen zu m�ssen. Das ist machbar, aber umst�ndlich.

-- Seit Oracle 11g gibt es eine einfachere L�sung: Compound Trigger haben 
-- Abschnitte f�r bisher unterschiedliche Triggertypen und bieten die M�glichkeit, Werte 
-- f�r die Dauer der Durchf�hrung des DML-Befehls zu speichern. Obiges Beispiel k�nnte 
-- mit einem Compound Trigger folgenderma�en aussehen:

CREATE OR REPLACE TRIGGER check_sal
  FOR UPDATE OF salary ON employees
COMPOUND TRIGGER
  TYPE t_number  IS TABLE OF NUMBER       INDEX BY pls_integer;
  TYPE t_varchar IS TABLE OF VARCHAR2(30) INDEX BY pls_integer;
  TYPE t_avgsal  IS TABLE OF NUMBER       INDEX BY VARCHAR2(30);
  
  v_avgsal t_number;        -- f�r SELECT d. Durchschnittsgehalts
  v_job    t_varchar;       -- f�r SELECT d. Job-IDs
  v_avgJob t_avgsal;        -- um Zusammenhang Job-ID <-> Durchschnittsgehalt zu speichern
  
  BEFORE STATEMENT IS
  BEGIN
    --BULK COLLECT erlaubt es, mehrere Zeilen in eine oder mehrere Collections einzulesen
    -- (mit nur einem einzigen Kontext-Switch bei der Kommunikation zwischen PL/SQL engine und SQL engine)
    SELECT AVG(salary), job_id BULK COLLECT INTO v_avgsal, v_job
      FROM employees e
    GROUP BY e.job_id;
    
    FOR i IN 1..v_avgsal.COUNT LOOP
      v_avgJob(v_job(i)) := v_avgsal(i);
    END LOOP;
  END BEFORE STATEMENT;
  
  AFTER EACH ROW IS
  BEGIN
    IF v_avgJob.EXISTS(:NEW.job_id)
    THEN
      IF :NEW.salary > 1.5 * v_avgJob(:NEW.job_id)
      THEN
        RAISE_APPLICATION_ERROR(-20000,
          'Verdienst liegt zu weit �ber dem Durchschnitt');
      END IF;
    END IF;
  END AFTER EACH ROW;
END;
/

-- Erlaubtes Update
UPDATE employees
   SET salary = 5000
 WHERE employee_id = 100;
--1 row updated.

-- Verbotenes Update
UPDATE employees
   SET salary = 500000
 WHERE employee_id = 100;
-- ORA-20000: Zu weit �ber Durchschnitt
-- ORA-06512: in "<USER>.CHECK_SAL", Zeile 29
-- ORA-04088: Fehler bei der Ausf�hrung von Trigger '<USER>.CHECK_SAL'

ROLLBACK;

DROP TRIGGER check_sal;


-- COMPOUND TRIGGER - Allgemeine Struktur
-- Mit dem Compound Trigger ist es m�glich, einen Programmierung zu erstellen mit Aktionen,
-- die zu verschiedenen Zeitpunkten ausgef�hrt werden und sich gemeinsame Daten bzw. Logik teilen.

CREATE OR REPLACE TRIGGER compound_trigger
    FOR UPDATE OF salary ON employees
    COMPOUND TRIGGER
    -- Declarative part (optional)
    threshold CONSTANT INTEGER := 200; -- common data/objects

    BEFORE STATEMENT IS
    BEGIN
       NULL;
    END BEFORE STATEMENT;
   
    BEFORE EACH ROW IS
    BEGIN
       NULL;
    END BEFORE EACH ROW;
   
    AFTER EACH ROW IS
    BEGIN
       NULL;
    END AFTER EACH ROW;
   
    AFTER STATEMENT IS
    BEGIN
       NULL;
    END AFTER STATEMENT;
END compound_trigger;
/