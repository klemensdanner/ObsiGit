---------------------------------------
-- Demo-Skript: Materialisierte Sichten
---------------------------------------

-- Wann wird aktualisiert?
--------------------------
--- ON DEMAND: Nur bei Aufruf von speziellen Funktionen
--- ON COMMIT: Beim Abschluss von Transaktionen, die mindestens eine Basistabelle ver�ndern
--- START WITH date NEXT date: Aktualisiert Sicht zun�chst basierend auf START WITH date;
--                             mit NEXT date erfolgt Aktualisierung in Intervallen

-- Wie wird aktualisiert?
-------------------------
--- COMPLETE: Komplette Neuberechnung der Sicht bei �nderungen an mindestens einer Basistabelle
--- FAST: Inkrementelles Nachf�hren von �nderungen - nur bei einfachen materialisierten Sichten m�glich (= Daten nur aus einer Basistabelle)
--- FORCE: Ausf�hrung von FAST, wenn m�glich; sonst COMPLETE

-- cleanup
DROP MATERIALIZED VIEW dempart_sal_sum;

----------------------------------------------------
-- Variante 1 mit defaults
-- default REFRESH_MODE == ON DEMAND
-- default REFRESH_METHOD == FORCE
CREATE MATERIALIZED VIEW dempart_sal_sum AS
  SELECT department_name d_name,
         SUM(salary) sum_sal
  FROM departments
       INNER JOIN employees USING (department_id)
  GROUP BY department_name;

SET AUTOTRACE ON;

-- Test: Ausf�hrungsplan analysieren und Kosten ermitteln
SELECT *
FROM dempart_sal_sum
WHERE d_name = 'IT';
-- 19200

-- Vergleich; Ausf�hrungsplan analysieren und Kosten ermitteln
SELECT department_name d_name,
     SUM(salary) sum_sal
FROM departments
   INNER JOIN employees USING (department_id)
GROUP BY department_name;
-- 19200, ok

-- explizite Freigabe von QUERY REWRITE
-- Optimizer verwendet nun materialisierte Sicht f�r QUERY REWRITE
ALTER MATERIALIZED VIEW dempart_sal_sum
ENABLE QUERY REWRITE;
-- obige Abfragen nochmals durchf�hren und Ausf�hrungspl�ne vergleichen
-- Fazit: Durch automatischen QUERY REWRITE konnte Ausf�hrungszeit
-- erheblich vermindert werden.

-- ANMERKUNG: QUERY REWRITE ist nicht unterst�tzt f�r Materialized Views, 
-- welche eine einfache Selektion (ohne Aggregation) auf eine einzelne 
-- Tabelle (ohne Join) darstellen.

-- Durchf�hren einer �nderung, employee 103 von 9000 auf 9800 erh�hen
SELECT employee_id, salary 
FROM employees
WHERE employee_id = 103;

UPDATE employees
SET salary = 9800
WHERE employee_id = 103;

-- ist jetzt 20000
SELECT department_name d_name,
       SUM(salary) sum_sal
FROM departments
    INNER JOIN employees USING (department_id)
WHERE department_name = 'IT'
GROUP BY department_name;

-- materialized view immer noch 19200
SELECT *
FROM dempart_sal_sum 
WHERE d_name = 'IT';


COMMIT;

-- auch nach commit 19200
SELECT *
FROM dempart_sal_sum 
WHERE d_name = 'IT';

-- manuelles REFRESH durchf�hren
BEGIN
  dbms_mview.REFRESH('dempart_sal_sum' );
END;
/
-- slash auf eigener zeile sendet block sofort zum server

SELECT *
FROM dempart_sal_sum 
WHERE d_name = 'IT';

-- jetzt 20000

----------------------------------------------------
-- Variante 2 mit refresh complete

DROP MATERIALIZED VIEW dempart_sal_sum;

CREATE MATERIALIZED VIEW dempart_sal_sum
REFRESH COMPLETE ON COMMIT
AS
  SELECT department_name d_name,
         SUM(salary) sum_sal
  FROM departments
    INNER JOIN employees USING (department_id)
  GROUP BY department_name;

SELECT *
FROM dempart_sal_sum 
WHERE d_name = 'IT';

-- jetzt 20000
UPDATE employees
SET salary = 9000
WHERE employee_id = 103;

SELECT *
FROM dempart_sal_sum
WHERE d_name = 'IT';

COMMIT;

--
SELECT *
FROM dempart_sal_sum 
WHERE d_name = 'IT';
-- 19200 -> automatisch aktualisiert

DROP MATERIALIZED VIEW dempart_sal_sum;


----------------------------------------------------
-- Variante 3 mit automatischen Refresh

-- datumsformat f�r session umstellen um akt. Uhrzeit zu sehen:
ALTER SESSION SET nls_date_format = 'dd.mm.rr hh24:mi:ss';

--
-- Datumsaritmetik:
-- trunc liefert bei Datum mit Uhrzeit 00:00, 
-- +1 ist ein Tag, 1/24 ist eine Stunde etc..
SELECT TRUNC(SYSDATE) + 22/24 START_WITH, -- heute + 22h
       TRUNC(SYSDATE+1) + 1/24 * 22 NEXT, -- morgen + 22h
       SYSDATE + 1/24/60 jetzt_plus_1min, -- jetzt + 1min
       SYSDATE jetzt -- jetzt
FROM DUAL;

DROP MATERIALIZED VIEW dempart_sal_sum;

--
-- Folgendes Beispiel macht ein erstes REFRESH in einer Minute und 
-- dann jeweils alle zwei Minuten einen Refresh
--
CREATE MATERIALIZED VIEW dempart_sal_sum REFRESH --FAST
       START WITH SYSDATE + 1/24/60 
       NEXT SYSDATE + 2/24/60 -- das ist wie eine Formel, d.h. hier alle
AS
  SELECT department_name d_name,
  SUM(salary) sum_sal
  FROM departments
    INNER JOIN employees USING (department_id)
  GROUP BY department_name;
  
-- Hinweis zur Berechnung von "NEXT": der Ausdruck wird bei der ersten bzw. vorhergehenden Berechnung
-- ausgewertet und die n�chste Ausf�hrungszeit davon neu bestimmt dh. SYSDATE wird evaluiert und darauf 
-- die Berechnung durchgef�hrt. Da die Ausf�hrung nicht exakt ist, "verschleppt" diese sich langsam (Milli-Sekunden).

SELECT *
FROM dempart_sal_sum 
WHERE d_name = 'IT';
-- 19200

UPDATE employees e
SET salary = 9800
WHERE e.employee_id = 103;

SELECT *
FROM dempart_sal_sum 
WHERE d_name = 'IT';
-- 19200

COMMIT;

SELECT s.*, SYSDATE
FROM dempart_sal_sum s
WHERE d_name = 'IT';
-- 19200 -> nicht automatisch aktualisiert

-- warten

SELECT *
FROM dempart_sal_sum 
WHERE d_name = 'IT';
-- 20000 -ok!



SELECT department_name d_name,
       SUM(salary) sum_sal
FROM departments 
    INNER JOIN employees USING (department_id)
GROUP BY department_name;

UPDATE employees e
SET salary = 9000
WHERE e.employee_id = 103;

COMMIT;

-- warten

SELECT s.*, SYSDATE
FROM dempart_sal_sum s
WHERE d_name = 'IT';
-- wieder 19200

-- Materialisierte View dempart_sal_sum   B I T T E   wieder l�schen
DROP MATERIALIZED VIEW dempart_sal_sum;
