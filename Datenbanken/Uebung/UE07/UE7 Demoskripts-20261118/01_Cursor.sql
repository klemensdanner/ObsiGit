-- SQL Cursor

-- Beispiel 1: Verwendung eines impliziten Cursors,
--              der automatisch für die Ausführung einer SQL-Anweisung erstellt wird.

VARIABLE rows_deleted VARCHAR2(30);
DECLARE
    empno employees.employee_id%TYPE := 104;
BEGIN
    -- SQL-Anweisung, auf deren impliziten Cursor zugegriffen werden soll.
    DELETE FROM employees
    WHERE employee_id = empno;
    
    -- TODO: Verwendung des impliziten Cursors, der automatisch für die o.a. SQL-Anweisung erstellt wurde.
    -- Zugriff auf Host-Variable mit :varName
    -- Zugriff auf impliziten Cursor mit 'SQL' und '%ROWCOUNT' für die Zeilenanzahl
    -- '%FOUND' oder '%NOTFOUND' wenn Zeilen gefunden bzw. nicht gefunden werden
    
    IF SQL%FOUND THEN -- es waren Zeilen betroffen, dann ist das true. sonst 
        :rows_deleted := SQL%ROWCOUNT || ' rows deleted';
        
    ELSE
        DBMS_OUTPUT.PUT_LINE('No rows found.');
    END IF;
    
END; --Beispiel 1: Verwendung eines impliziten Cursors, 
/
-- Anzeigen der Host-Variable: PRINT ist ein Oracle (bzw. SQLPLUS) spezifischer Befehl!
PRINT rows_deleted;

ROLLBACK;



-- Beispiel 2: Verwendung eines expliziten Cursors
SET SERVEROUTPUT ON;
DECLARE
    -- Deklaration eines Cursor
    CURSOR emp_cursor IS
        SELECT employee_id, last_name FROM employees
        WHERE department_id = 50;

    empno employees.employee_id%TYPE;
    lname employees.last_name%TYPE;

-- Das Ergebnis der SQL-Anweisung soll hinausgeschrieben werden.    
BEGIN
    -- TODO: Cursor öffnen und auf erste Zeile positionieren.
    OPEN emp_cursor; -- optional kann Parameter mitgegeben werden
    
    DBMS_OUTPUT.PUT_LINE(emp_cursor%ROWCOUNT); -- hier ist rowcount noch 0
            
    -- TODO: Das Ergebnis der SQL-Anweisung soll hinausgeschrieben werden.
    --        Abrufen einer Zeile aus dem Cursor (2 Variablen!) u. Weiterschalten auf die nächste Zeile
    --        Abfragen auf das Cursor-Attribut %NOTFOUND
    
        
    LOOP
        FETCH emp_cursor INTO empno, lname;
        DBMS_OUTPUT.PUT_LINE(emp_cursor%ROWCOUNT);        
        
        EXIT WHEN emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(empno || ' ' || lname);
    END LOOP;
                    
    IF emp_cursor%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE( 'No rows selected in emp_cursor!');
    END IF;

    -- TODO: Schließen des Cursor und Freigabe der aktiven Menge
    CLOSE emp_cursor;

    
END; -- Beispiel 2: Verwendung eines expliziten Cursors
/


-- Beispiel 3: Expliziter CURSOR mit Parameter und Cursor-Record
DECLARE
    -- Deklaration eines Cursor mit Parameter
    CURSOR emp_cursor (deptno NUMBER) IS
        SELECT employee_id, last_name
        FROM employees
        WHERE department_id = deptno;
    
    -- TODO: Record emp_rec vom Typ des Cursors emp_cursor anlegen (Attribute des Cursor mit deren Typen)
    emp_rec emp_cursor % ROWTYPE; -- Es geht um eine Zeile vom cursor (rowtype geht auf cursor und tabelle)

BEGIN
    -- TODO: Cursor für department = 50 öffnen.
    OPEN emp_cursor(50);
    
    -- TODO: Prüfung ob emp_cursor richtig geöffnet wurde.
    IF  emp_cursor%ISOPEN THEN                                
        LOOP
            -- TODO: Abrufen einer Zeile aus dem Cursor u. weiterschalten auf die nächste Zeile
            FETCH emp_cursor INTO emp_rec; -- wird automatisch weitergesprungen
            
            -- TODO: Exitbedingung festlegen
            EXIT WHEN emp_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE( emp_rec.employee_id ||' '||emp_rec.last_name);
        END LOOP;
                    
        IF emp_cursor%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE( 'No rows selected in emp_cursor!');            
        END IF;
    END IF;
    -- TODO: Schließen des Cursor und Freigabe der aktiven Menge 
    CLOSE emp_cursor;
END; -- Beispiel 3: Expliziter CURSOR mit Parameter und Cursor-Record
/


-- Beispiel 4: Verwendung eines expliziten CURSORs in Kombination mit FOR-Schleifen 
DECLARE
    -- Deklaration eines Cursor
    CURSOR emp_cursor IS
        SELECT employee_id, last_name FROM employees
        WHERE department_id = 50;
BEGIN

    -- TODO: expliziten CURSOR in Kombination mit FOR-Schleife verwenden
    -- Das Öffnen und Schließen des Cursor und das Fetchen der einzelnen Zeilen
    -- passiert implizit in der FOR-Schleife in Verbindung des Cursor mit dem Record
    -- Das Record emp_record wird ebenfalls implizit erzeugt u. muss nicht deklariert werden.
    
    FOR line IN emp_cursor LOOP
        DBMS_OUTPUT.PUT_LINE( line.employee_id || ' ' ||line.last_name);
    END LOOP;
        
END; -- Beispiel 4: Verwendung eines expliziten CURSORs in Kombination mit FOR-Schleifen 
/

-- Beispiel 5: Verwendung eines impliziten CURSORs in Kombination mit FOR-Schleifen 
SET SERVEROUTPUT ON;

DECLARE     
    i INTEGER := 0;
BEGIN
    -- TODO: Die SELECT-Anweisung kann durch den indirekten Cursor direkt in die FOR-Schleife eingebettet werden
    

            
    FOR line in (SELECT employee_id, last_name
        FROM employees
        WHERE department_id = 50) LOOP
        i := i+1;
        DBMS_OUTPUT.PUT_LINE('Anzahl: '|| i);
        DBMS_OUTPUT.PUT_LINE( line.employee_id ||' '||line.last_name);
    END LOOP;
END; -- Beispiel 5: Verwendung eines impliziten CURSORs in Kombination mit FOR-Schleifen 
/
