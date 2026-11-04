-- Baumstruktur durchlaufen: von unten nach oben (Bottom Up)
-- START WITH: gibt den Ausgangspunkt der Hierarchie an.
-- CONNECT BY PRIOR: gibt die Richtung an, in der die Hierarchie durchlaufen wird.
-- Gibt f�r den Angestellten mit id=101 alle Vorgesetzten aus
SELECT employee_id, last_name, job_id, manager_id
  FROM employees
START WITH employee_id = 101
CONNECT BY PRIOR manager_id = employee_id;
-- PRIOR manager_id = employee_id hei�t: Suche ausgehend von der manager_id die zugeh�rige employee_id -> aufw�rts

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
 WHERE last_name != 'Higgins' -- das kommt nach der Rekursion, d.h. man kann die Rekursionsfunktionen hier anwenden
START WITH manager_id IS NULL -- ohne start with fängt die Rekursion überall an
CONNECT BY PRIOR employee_id = manager_id;

-- Mit einer zus�tzlichen Bedingung in der CONNECT BY Klausel k�nnen gesammte Zweige
-- in der Baumstruktur ausgeblendet werden.
-- Der gesammte Zweig (alle Kindknoten) ab 'Higgins' wird ausgeblendet.
COLUMN org_chart FORMAT A25
SELECT LPAD(last_name, LENGTH(last_name)+(LEVEL*2)-2,'_') AS org_chart
  FROM employees
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id
       AND last_name != 'Higgins'; -- das alles muss true sein, damit die Rekursion forgesetzt wird
	   
