-- Einführung: Ohne LISTAG
-- Nachnamen und Anstellungsdatum aller Angestellten im Department 50, 
-- geordnet nach Anstellungsdatum und Nachname.
SELECT last_name, hire_date 
FROM employees
WHERE department_id = 50
ORDER BY hire_date, last_name;

-- Aggregierte Liste aller Angestellten (LISTAGG) im Department 50, 
-- getrennt durch ';' und geordnet nach Anstellungsdatum und Nachname.
-- Zusätzliche Ausgabe: Frühestes Anstellungsdatum im Department 50.
SELECT LISTAGG(last_name, '; ') 
          WITHIN GROUP (ORDER BY hire_date, last_name) Employees,
       MIN(hire_date) Earliest
FROM employees
WHERE department_id = 50;

-- Aggregierte Liste aller Angestellten (LISTAGG) für jedes Department (GROUP BY), 
-- getrennt durch ',' und geordnet nach Anstellungsdatum und Nachname.
-- Geordnet nach department_id.
SELECT department_id AS Dept, 
      LISTAGG(last_name, ', ') 
          WITHIN GROUP (ORDER BY hire_date, last_name) Employees
FROM employees
GROUP BY department_id
ORDER BY Dept;

-- Für jeden Angestellten, der vor dem 1.1.1997 angestellt wurde,
-- werden department_id, hire_date und last_name ausgegeben
-- und zusätzlich mit LISTAGG die Nachnamen aller Angestellten 
-- die im gleichen Department ebenfalls vor dem 1.1.1997 angestellt wurden.

-- Hinweis: Die Auswahl der Gruppe erfolgt durch PARTITION BY, 
-- d.h. keine zusätzliches GROUP BY erforderlich.
-- Ohne PARTITION BY wäre ein Subquery für den LISTAGG-Teil notwendig.
SELECT department_id Dept, 
       hire_date HDate, 
       last_name Name,
       LISTAGG(last_name, '; ') 
          WITHIN GROUP (ORDER BY hire_date, last_name)
          OVER (PARTITION BY department_id) 
          AS Employees
FROM employees
WHERE hire_date < to_date('01-JAN-1997', 'dd-mon-yyyy')
ORDER BY Dept, HDate, Name;

