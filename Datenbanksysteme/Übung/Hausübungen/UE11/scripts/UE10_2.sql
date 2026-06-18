
CREATE TABLE bonus (
    employee_id NUMBER(6) CONSTRAINT bonus_employee_id_pk PRIMARY KEY,
    bonus NUMBER(6,2) DEFAULT 100);


INSERT INTO bonus (employee_id)
    (SELECT employee_id
    FROM EMPLOYEES
    WHERE department_id IN (50, 80));


SELECT * FROM bonus;

COMMIT;



-- change comment of WHERE NOT (PersNr = 2126) to show that 2126 has to be
-- affected in "MATCHED" to be deleted
MERGE	INTO pruefungsstatistik ziel
USING (
  SELECT PersNr, COUNT(*) AS PrfAnzahl
  FROM pruefen
  WHERE PersNr != 2126
  GROUP BY PersNr) quelle
ON (ziel.PersNr = quelle.PersNr)
WHEN MATCHED THEN
  UPDATE SET ziel.Anzahl = quelle.PrfAnzahl
  DELETE WHERE ziel.PersNr = 2126
WHEN NOT MATCHED THEN
  INSERT (PersNr, Anzahl)
  VALUES (quelle.PersNr, quelle.PrfAnzahl)
  WHERE NOT (quelle.PersNr = 2126)
  ;



MERGE INTO bonus b
USING employees e
    ON e.employee_id = b.employee_id
WHEN MATCHED THEN -- Mitarbeiter existiert in Bonus
                  -- department_id = 80 werden gelöscht
                  -- über 11000€ Leute werden gelöscht
                  -- Erhöhung um 15% des aktuellen Bonusbetrages

WHEN NOT MATCHED THEN -- Mitarbeiter hat noch keinen bonus erhalten
                      -- Bonus beträgt 1 % des Gehalts (e.salary)
                      -- department_id = 80 werden nicht eingefügt
                      -- Null soll einen Bonus bekommen können