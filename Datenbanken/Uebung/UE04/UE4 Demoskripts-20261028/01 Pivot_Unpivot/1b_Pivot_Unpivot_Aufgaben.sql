-- PIVOT und UNPIVOT

-- Erstellen Sie eine Pivot-Tabelle, die angibt, wie viele Employees und welche Jobs es in welcher Abteilung gibt.
-- Listen Sie die Job-IDs zeilenweise auf und verwenden Sie die Abteilungen in den Spalten.
-- Sie k�nnen einschr�nken auf die Abteilungen 'Shipping', 'Marketing', 'Sales', 'Executive', 'Accounting'.
     
      
-- Erstellen Sie eine Unpivot-Tabelle f�r die vorherige Abfrage, nennen Sie die Spalten 
-- num_employees und department_name und geben Sie nur jene Zeilen an, deren
-- Anzahl an Angestellten gr��er als 0 sind.     





WITH job_pivot AS (
    SELECT *
    FROM (
        SELECT employee_id, job_id, department_name
        FROM employees
            JOIN departments USING (department_id)
    )
    PIVOT (
        COUNT(*)
        FOR department_name
        IN (
            'Shipping' AS Shipping,
            'Marketing' AS Marketing,
            'Sales' AS Sales,
            'Executive' AS Executive,
            'Accounting' AS Accounting
        )
    )
)



SELECT *
FROM job_pivot
UNPIVOT (
    num_employees -- neuer Spaltenname
    FOR department_name
    IN (Shipping, Marketing, Sales, Executive, Accounting)
)
WHERE num_employees > 0;