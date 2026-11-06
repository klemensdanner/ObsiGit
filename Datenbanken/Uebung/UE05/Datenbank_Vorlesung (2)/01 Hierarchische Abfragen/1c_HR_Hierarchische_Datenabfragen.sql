-- Baumstruktur durchlaufen: von unten nach oben (Bottom Up)
-- START WITH: gibt den Ausgangspunkt der Hierarchie an.
-- CONNECT BY PRIOR: gibt die Richtung an, in der die Hierarchie durchlaufen wird.
-- Gibt f�r den Angestellten mit id=101 alle Vorgesetzten aus
SELECT employee_id, last_name, job_id, manager_id
  FROM employees
START WITH employee_id = 141
CONNECT BY NOCYCLE PRIOR manager_id = employee_id;
-- PRIOR manager_id = employee_id hei�t: Suche ausgehend von der manager_id die zugeh�rige employee_id -> aufw�rts

select employee_id
from employees;

WITH tmp_table AS (
  SELECT e1.employee_id, e1.manager_id, e2.employee_id, e2.manager_id
  FROM employees e1
      JOIN employees e2 ON e1.manager_id = e2.employee_id
  WHERE e1.employee_id = 141
)

SELECT employee_id FROM tmp_table;









WITH tmp_table  AS (
    SELECT
        e.employee_id AS emp1,
        e.manager_id AS mgr1,
        m.employee_id AS emp2,
        m.manager_id AS mgr2
    FROM employees e
        JOIN employees m
            ON e.manager_id = m.employee_id
    WHERE e.employee_id = 141
),


tmp_table_pivot AS (SELECT nummer, spaltenname
  FROM tmp_table
  UNPIVOT (
      (nummer)
      FOR spaltenname IN (
        emp1,
        mgr1,
        emp2,
        mgr2

      )
  )
)
/* SELECT * FROM tmp_table_pivot; */

SELECT *
FROM tmp_table_pivot

PIVOT (
  SUM(nummer)
  FOR spaltenname IN (
    'EMP1' as emp1,
    'MGR1' as mgr1,
    'EMP2' as emp2,
    'MGR2' as mgr2
  )
);


/* 

kategorie    film_id     drittespalte                    kategorie          spalte1         spalte2         spalte3

action          2             15                          action                 6                 3           null // weil spalte 3 kein action wert hat
action          4             15                          horror                 null           null            7
action          3             30
horror          4             50
horror          3             50


select *
from blabla
PIVOT (
  SUM(film_id)
  FOR drittespalte IN (
    15 AS spalte1
    30 AS spalte2
    50 AS spalte3
  )

)
*/






WITH tmp_table AS (
    SELECT
        e.employee_id AS emp1,
        e.manager_id AS mgr1,
        m.employee_id AS emp2,
        m.manager_id AS mgr2
    FROM employees e
        JOIN employees m
            ON e.manager_id = m.employee_id
    WHERE e.employee_id = 141
)

SELECT employee_id, manager_id, alte_spalte
FROM tmp_table
UNPIVOT (
    (employee_id, manager_id)
    FOR alte_spalte IN (
        (emp1, mgr1),
        (emp2, mgr2)
    )
);








-- Baumstruktur durchlaufen: von oben nach unten (Top Down)
SELECT employee_id, last_name, job_id, manager_id
  FROM employees
START WITH last_name = 'King'
CONNECT BY PRIOR employee_id = manager_id;
-- PRIOR employee_id = manager_id hei�t: Suche ausgehend von der employee_id die zugeh�rige manager_id -> abw�rts

-- Hierarchische Berichte mit LEVEL und LPAD formatieren
-- Anzeige der Managementebenen des Unternehmens
-- FORMAT A25 setzt die Anzeigebreite f�r alphanumerische Werte auf 25 Zeichen
-- LPAD definiert das Anzeigeformat und f�llt die linke Seite einer Spalte mit beliebigen Zeichenfolge auf.
-- RPAD f�hrt die gleiche Aktion auf der rechten Seite aus
-- LEVEL ist eine Pseudospalte und gibt die Ebene einer Zeile in der Hierarchie an.
-- Der Wurzelknoten hat den LEVEL=1

COLUMN org_chart FORMAT A25
SELECT LPAD(last_name, LENGTH(last_name)+(LEVEL*2)-2,'_') AS org_chart
  FROM employees
START WITH last_name = 'King'
CONNECT BY PRIOR employee_id = manager_id;

COLUMN org_chart CLEAR

-- Zweige ausblenden
-- Mit der WHERE-Klausel k�nnen einzelne Knoten aus der Baumstruktur ausgeblendet werden.
-- Der Knoten 'Higgins' wird ausgeblendet
COLUMN org_chart FORMAT A25
SELECT LPAD(last_name, LENGTH(last_name)+(LEVEL*2)-2,'_') AS org_chart
  FROM employees
 WHERE last_name != 'Higgins'
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id;

-- Mit einer zus�tzlichen Bedingung in der CONNECT BY Klausel k�nnen gesammte Zweige
-- in der Baumstruktur ausgeblendet werden.
-- Der gesammte Zweig (alle Kindknoten) ab 'Higgins' wird ausgeblendet.
COLUMN org_chart FORMAT A25
SELECT LPAD(last_name, LENGTH(last_name)+(LEVEL*2)-2,'_') AS org_chart
  FROM employees
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id
       AND last_name != 'Higgins';
	   
