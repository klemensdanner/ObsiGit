-- =====================================================================
-- TEIL 1: Einstieg Analytische Funktionen (HR)
-- Ziel: Verstehen, WAS ein Fenster ist.
-- Danach weiter mit 2b_Komplexe_Analytische_Funktionen_Sakila.sql
--
-- Merksatz:
--   GROUP BY : aus vielen Zeilen wird EINE.
--   OVER()   : jede Zeile BLEIBT und bekommt zusaetzlich Infos ueber ihre Gruppe.
--
-- Die drei "Regler" der OVER-Klausel:
--   funktion(...) OVER ( PARTITION BY ...   -- 1) Welche Gruppe?
--                        ORDER BY ...       -- 2) Welche Reihenfolge? (wird standardmäßig zu "laufenden" Wert)
--                        ROWS/RANGE ... )   -- 3) Wie weit sehe ich? (Fenster)
--
-- Abarbeitungsreihenfolge:
--   FROM -> WHERE -> GROUP BY -> HAVING -> analytische Funktionen -> SELECT -> ORDER BY
-- =====================================================================


-- a) GROUP BY vs. OVER
-- Mit GROUP BY: eine Zeile pro Abteilung, Einzelpersonen sind "weg"
SELECT department_id, ROUND(AVG(salary)) AS avg_abt
FROM employees
GROUP BY department_id;

-- Mit OVER: alle Personen bleiben, der Abteilungsschnitt kommt als Spalte dazu
-- Frage: Wer verdient mehr als der Abteilungsschnitt?
SELECT last_name, department_id, salary,
       ROUND(AVG(salary) OVER (PARTITION BY department_id)) AS avg_abt,
       salary - ROUND(AVG(salary) OVER (PARTITION BY department_id)) AS diff_zum_schnitt
FROM employees
ORDER BY department_id, salary DESC;


-- b) Was ändert ein ORDER BY in OVER()?
-- OVER ()                  -> Fenster = alle Zeilen -> Gesamtsumme
-- OVER (ORDER BY salary)   -> DEFAULT-Fenster (RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
--                             -> laufende Summe, GLEICHE Gehälter bekommen GLEICHE Summe (vgl. Kochhar/De Haan)
-- ROWS UNBOUNDED PRECEDING -> laufende Summe Zeile für Zeile
SELECT last_name, salary,
       SUM(salary) OVER ()                                          AS gesamt,
       SUM(salary) OVER (ORDER BY salary)                           AS laufend_range, -- default ist range unbounded preceiding
       SUM(salary) OVER (ORDER BY salary ROWS UNBOUNDED PRECEDING)  AS laufend_rows
FROM employees
WHERE department_id IN (20, 90, 100)
ORDER BY salary;


-- c) Fenster definieren/sichtbar machen ("Debug-Spalten")
-- So sieht man, welche Zeilen im Fenster waren (hilfreich für die Hausuebung!).
SELECT last_name, hire_date, salary,
       ROUND(AVG(salary)      OVER (ORDER BY hire_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)) AS avg_vorher_nachher,
       COUNT(*)               OVER (ORDER BY hire_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS anz_im_fenster,
       FIRST_VALUE(last_name) OVER (ORDER BY hire_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS fenster_von,
       LAST_VALUE(last_name)  OVER (ORDER BY hire_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS fenster_bis
FROM employees
WHERE department_id = 50
ORDER BY hire_date;


-- d) ROW_NUMBER vs. RANK vs. DENSE_RANK ("Siegerehrung")
-- Abteilung 90: Kochhar und De Haan verdienen beide 17000 -> Gleichstand
-- RANK:       1, 2, 2, 4  (nach zwei Silbernen kein Bronze -> Lücke)
-- DENSE_RANK: 1, 2, 2, 3  (keine Lücke)
-- ROW_NUMBER: 1, 2, 3, 4  (Gleichstand wird willkürlich aufgelöst -> nicht deterministisch!)
SELECT last_name, department_id, salary,
       RANK()       OVER (ORDER BY salary DESC) AS rank,
       DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank,
       ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_number
FROM employees
WHERE department_id IN (20, 90, 100)
ORDER BY salary DESC;

-- Top-2 Verdiener*innen pro Abteilung (inkl. Gleichstand)
-- Analytische Funktion nicht im WHERE möglich -> Subquery
SELECT department_id, last_name, salary, rang
FROM (
  SELECT department_id, last_name, salary,
         DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rang
  FROM employees
)
WHERE rang <= 2
ORDER BY department_id, rang;


-- e) LAG / LEAD: Blick in die vorherige / nächste Zeile
-- Erste Person pro Abteilung hat kein Vorgänger -> NULL (fachlich: "keine vorherige Einstellung")
SELECT department_id, last_name, hire_date,
       LAG(hire_date)  OVER (PARTITION BY department_id ORDER BY hire_date) AS vorherige_einstellung,
       LEAD(hire_date) OVER (PARTITION BY department_id ORDER BY hire_date) AS naechste_einstellung,
       hire_date - LAG(hire_date) OVER (PARTITION BY department_id ORDER BY hire_date) AS tage_seit_vorheriger
FROM employees
ORDER BY department_id, hire_date;


-- f) RANGE mit Wert-Abstand
-- Wie viele Kolleg*innen derselben Abteilung wurden +/- 180 Tage um mich herum eingestellt?
-- RANGE arbeitet mit dem WERT der ORDER BY-Spalte (bei DATE: Tage), ROWS mit der Anzahl Zeilen.
-- "- 1": die eigene Zeile ist immer im Fenster und wird abgezogen.
SELECT department_id, last_name, hire_date,
       COUNT(*) OVER (PARTITION BY department_id ORDER BY hire_date
                      RANGE BETWEEN 180 PRECEDING AND 180 FOLLOWING) - 1 AS kolleg_innen_180_tage
FROM employees
ORDER BY department_id, hire_date;