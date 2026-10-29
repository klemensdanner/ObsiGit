-- PIVOT und UNPIVOT

-- Anzahl der Angestellten pro Abteilung (als Spalten)
-- Ergebnis: 1 Gesamtzeile
-- Hinweis: IN-Clause in Pivot ist nicht dynamisch (muss bei Bedarf im vorangehenden SQL ausgef�hrt werden)
SELECT * 
FROM (
  SELECT department_id
  FROM employees
)
PIVOT
( COUNT(*)
  FOR department_id
  IN (10,20,30,40) );
  
  
-- Minimum- und Maximum-Geh�lter aller Angestellten pro JOB_ID und Abteilung
-- Die JOB_IDs sollen als Spalten ausgegeben werden (Sales = SA, Mangers = MAN/MGR und Others)
-- Ergebnis: Pro Abteilung 1 Zeile
SELECT *
FROM (
   SELECT department_id, salary, -- nach einer nicht verwendeten spalte wird unten gruppiert
      CASE 
        WHEN job_id LIKE 'SA%' THEN 'SA'
        WHEN job_id LIKE '%MAN' OR job_id LIKE '%MGR' THEN 'MAN'
        ELSE 'OTH' 
      END AS job_desc
   FROM employees
)
PIVOT
(
  MIN(salary) AS min_sal,
  MAX(salary) AS max_sal
  FOR job_desc
  IN ('SA',	-- Vergabe von Spalten-Alias mit AS moeglich
      'MAN',
      'OTH')
);


-- Zusammenfassung aller Kontaktdaten der Angestellten.
-- Die Tabelle soll als Spalten den Nachnamen (last_name), die Kontakt-Art (contact_method = email, phone_number)
-- und den Wert (die jeweilige E-Mail-Adresse bzw. Telefonnummer) enthalten.
SELECT * 
FROM (
  SELECT last_name, email, phone_number
  FROM employees
)
UNPIVOT
( value							-- neuer Spaltenname (der Werte enth�lt)
  FOR contact_method			-- neuer Spaltenname (der Spalten-�berschriften enth�lt)
  IN (email, phone_number) );	-- Spalten-�berschriften, die (in contact_method) verwendet werden sollen

