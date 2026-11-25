-- INSTEAD OF-Trigger: 
-- werden verwendet, um Daten zu �ndern, bei denen eine DML-Anweisung 
-- f�r eine View abgesetzt wird, die implizit nicht aktualisierbar ist.
-- Der Oracle-Server f�hrt nicht das Ereignis aus, sondern f�hrt statt dessen den Trigger aus.
-- INSTEAD OF Trigger sind immer Row-Trigger

-- Erzeugen von 2 Hilfstabellen, um die Orginal-Tabellen nicht zu ver�ndern!
CREATE TABLE new_emps AS
	SELECT employee_id, last_name, salary, department_id
	FROM employees;

CREATE TABLE new_depts AS
  SELECT department_id, d.department_name, sum(e.salary) dept_sal
    FROM employees e
        INNER JOIN departments d USING (department_id)
  GROUP BY department_id,d.department_name;

--Erzeugen einer View auf die beiden Hilfstabellen, die das Abteilungsgehalt beinhaltet
CREATE OR REPLACE VIEW emp_details AS
  SELECT e.employee_id, e.last_name, e.salary, department_id, d.department_name
    FROM new_emps e
        INNER JOIN new_depts d USING (department_id)
  GROUP BY department_id, d.department_name, e.employee_id, e.last_name, e.salary;

SELECT * FROM new_emps;
SELECT * FROM new_depts;
SELECT * FROM emp_details;

-- Insert/Update/Delete w�re auf View emp_details nicht erlaubt
-- Instead of Trigger wird anstelle der INSERT/UPDATE/DELETE Anweisung auf die View emp_details ausgef�hrt.
-- Dabei werden die Tabellen new_emps und new_depts entsprechend angepasst 
-- Ein Instead-of Trigger ist immer ein ROW-Trigger
-- d.h. er wird einmal f�r jede vom ausl�senden Ereignis betroffene Zeile ausgef�hrt.
-- Mit Hilfe von Korrelationsnamen (OLD,NEW) kann auf die alten und neuen Spaltenwerte der
-- Zeile zugegriffen werden, die durch den Trigger verarbeitet wird.
CREATE OR REPLACE TRIGGER new_emp_dept
  INSTEAD OF INSERT OR UPDATE OR DELETE ON emp_details
  FOR EACH ROW	
BEGIN
  IF INSERTING THEN
	  -- Einf�gen in die Tabelle new_emps
	  INSERT INTO new_emps VALUES (:NEW.employee_id, :NEW.last_name,:NEW.salary, :NEW.department_id);
	
	  -- Aktualisieren des Abteilungsgehaltes in new_depts, da ein neuer Angestellter eingef�gt wurde.
	  UPDATE new_depts
       SET dept_sal = dept_sal + :NEW.salary
	   WHERE department_id = :NEW.department_id;

  ELSIF DELETING THEN
	  -- L�schen des Angestellten in new_emps
	  DELETE FROM new_emps
          WHERE employee_id = :OLD.employee_id;
	
	  -- Aktualisieren des Abteilungsgehaltes in new_emps, da ein Angestellter entfernt wurde.
	  UPDATE new_depts
       SET dept_sal = dept_sal - :OLD.salary
	  WHERE department_id = :OLD.department_id;

  -- die Spalte salary wird aktualisiert
  ELSIF UPDATING('salary') THEN
	  -- Aktualisieren des Gehalts f�r den entsprechenden Mitarbeiter in new_emps
  	UPDATE new_emps
       SET salary = :NEW.salary
	   WHERE employee_id = :OLD.employee_id;
	
	  -- Aktualisieren des Abteilungsgehaltes in new_depts
	UPDATE new_depts
       SET dept_sal = dept_sal - :OLD.salary
	   WHERE department_id = :OLD.department_id;
    UPDATE new_depts
       SET dept_sal = dept_sal + :NEW.salary
	   WHERE department_id = :NEW.department_id;

  -- Spalte department_id wird aktualisiert
  ELSIF UPDATING('department_id') THEN
	  UPDATE new_emps
       SET department_id = :NEW.department_id
	   WHERE employee_id = :OLD.employee_id;
	  UPDATE new_depts
       SET dept_sal = dept_sal - :OLD.salary
	   WHERE department_id = :OLD.department_id;
	  UPDATE new_depts
       SET dept_sal = dept_sal + :NEW.salary
	   WHERE department_id = :NEW.department_id;
  END IF;
END;
/

--Test1:  Aktualisierung des Gehalts des Angestellten 'Higgins', Abteilung 110 (Accounting) in emp_details 
SELECT * FROM new_depts; -- -- Accounting 20300

UPDATE emp_details
   SET salary = 1.1 * salary
 WHERE last_name LIKE 'Higgins'; 

SELECT * FROM new_depts; -- Accounting 21500
-- Abteilungsgehalt in 110 hat sich ver�ndert.

-- Test2: Abteilungswechsel von 'Higgins' zu Abteilung 10 (Administration)
SELECT * FROM new_depts; -- Augenmerk auf Abteilung 10

UPDATE emp_details
   SET department_id = 10
 WHERE last_name LIKE 'Higgins'; -- 1 row updated, aber das UPDATE von last_name ist im Trigger nicht behandlet! dardurch passiert nix

SELECT * FROM new_depts;

-- Unbehandeltes Update
UPDATE emp_details SET last_name = 'Hickins' WHERE last_name LIKE 'Higgins';
-- 1 Zeile aktualisiert.
SELECT * FROM emp_details;
SELECT * FROM new_emps;
-- Trigger wurde 1 mal ausgef�hrt, keine echte �nderung

-- Trigger verwalten:
-- Einen Datenbank-Trigger deaktivieren (DISABLE) oder aktivieren (ENABLE):
ALTER TRIGGER new_emp_dept DISABLE;

UPDATE emp_details
   SET salary = 1.1 * salary
  WHERE last_name LIKE 'Higgins';
--Update ist auf der View nicht erlaubt

DROP TABLE new_emps;
DROP TABLE new_depts;
DROP VIEW emp_details;

-- TRIGGER new_emp_dept muss nicht separat gel�scht werden, da die View emp_details gel�scht wird