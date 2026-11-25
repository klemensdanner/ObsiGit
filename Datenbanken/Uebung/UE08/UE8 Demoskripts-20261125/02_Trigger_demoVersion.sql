-- DML-Trigger (Statement-Trigger und ROW-Trigger) 


CREATE OR REPLACE TRIGGER secure_emp
BEFORE INSERT ON employees -- statement trigger, weil kein FOR EACH ROW dasteht
BEGIN
  IF (TO_CHAR(SYSDATE,'DY') IN ('SAT','SUN')) OR
     (TO_CHAR(SYSDATE,'HH24:MI') NOT BETWEEN '06:00' AND '12:00') THEN
      RAISE_APPLICATION_ERROR(-20500, 'You may insert into EMPLOYEES table only during '
                  ||' business hours.');
  END IF;
END;
/

--Test des secure_emp Triggers:
INSERT INTO employees (employee_id, last_name, first_name, email, hire_date,
             job_id, salary, department_id)
VALUES (300, 'Smith', 'Rob', 'RSMITH', SYSDATE, 'IT_PROG', 4500, 60);
SELECT * FROM employees WHERE last_name = 'Smith';
ROLLBACK;

-- Beim Debuggen eines Trigger muss dieser von einer Prozedur aufgerufen werden
-- bzw. die Aktion in der Prozedur muss zu einem Feuern des Triggers führen.
-- Die Prozedur muss in der Datenbank vorhanden sein und mit Compile for Debug
-- übersetzt werden. Entsprechender Breakpoint muss im Trigger gesetzt sein.
-- Hinweis: Debugging in FH nicht möglich.
CREATE OR REPLACE
PROCEDURE test_trigger_secure_emp
IS
BEGIN
  INSERT INTO employees (employee_id, last_name, first_name, email, hire_date, job_id, salary, department_id)
  VALUES (300, 'Smith', 'Rob', 'RSMITH', SYSDATE, 'IT_PROG', 4500, 60);
END;
/


CREATE OR REPLACE TRIGGER secure_emp 
BEFORE INSERT OR UPDATE OR DELETE ON employees 
BEGIN
  IF (TO_CHAR(SYSDATE,'DY') IN ('SAT','SUN')) OR
     (TO_CHAR(SYSDATE,'HH24') NOT BETWEEN '10' AND '12') THEN
    IF DELETING THEN
      RAISE_APPLICATION_ERROR(-20502,
        'You may delete from EMPLOYEES table only during business hours.');
    ELSIF INSERTING THEN 
      RAISE_APPLICATION_ERROR(-20500,
        'You may insert into EMPLOYEES table only during business hours.');
    ELSIF UPDATING('SALARY') THEN -- das gibts nur bei updateing
      RAISE_APPLICATION_ERROR(-20503,
        'You may update SALARY only during business hours.');
    ELSE 
      RAISE_APPLICATION_ERROR(-20504,
        'You may update EMPLOYEES table only during business hours.');
    END IF;
  END IF;
END;
/


SELECT trigger_name, trigger_type, description
  FROM user_triggers;


DROP TRIGGER secure_emp;



CREATE OR REPLACE TRIGGER restrict_salary
BEFORE INSERT OR UPDATE OF salary ON employees -- trigger nur bei salary
FOR EACH ROW 
BEGIN
IF NOT (:NEW.job_id IN ('AD_PRES', 'AD_VP')) -- :NEW ist der Zielwert, der eingefügt werden soll; :AFTER: der Wert der vorher dagestanden ist?
   AND :NEW.salary > 15000 THEN
     RAISE_APPLICATION_ERROR (-20202, 'Employee cannot earn more than $15,000.');
END IF;
END;
/

UPDATE employees
   SET salary = 15500
 WHERE last_name = 'Lorentz';

-- Änderungen gehen entweder durch oder eben nicht - sobald eine exception fällt ist es vorbei

DROP TRIGGER restrict_salary;



CREATE OR REPLACE TRIGGER derive_commission_pct
BEFORE INSERT OR UPDATE OF salary ON employees
FOR EACH ROW
WHEN (NEW.job_id = 'SA_REP') -- Beispiel: Einrelationenmodell, man kann alles andere vorher bereits aussortieren
BEGIN
  IF INSERTING THEN
    :NEW.commission_pct := 0;
  ELSIF :OLD.commission_pct IS NULL THEN
    :NEW.commission_pct := 0;
  ELSE
    :NEW.commission_pct := :OLD.commission_pct + 0.05;
  END IF;
END;
/


-- Angaben mit :NEW oder :OLD können NULL werden, wenn die nicht existieren
-- z.B. bei einem INSERTING gibt es nur NEW aber kein OLD

DROP TRIGGER derive_commission_pct;

-- Ab hier anschauen
UPDATE employees SET department_id = 9999
 WHERE employee_id = 141;


CREATE OR REPLACE TRIGGER employee_dept_fk_trg
BEFORE UPDATE OF department_id ON employees 
FOR EACH ROW
BEGIN
  INSERT INTO departments VALUES(:new.department_id, 'Dept ' || :new.department_id, NULL, NULL);
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN  
    NULL; -- exception ist gefangen
END;
/

UPDATE employees SET department_id = 9998
 WHERE employee_id = 141;


UPDATE employees SET department_id = 10
 WHERE employee_id = 141;


SELECT * FROM departments;
ROLLBACK;
DROP TRIGGER employee_dept_fk_trg;

