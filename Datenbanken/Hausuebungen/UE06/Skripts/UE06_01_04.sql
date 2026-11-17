-- DROP TABLE evaluation_rental;
-- DROP SEQUENCE evaluation_rental_seq;

-- Erstellen der Tabelle evaluation_rental (als Kopie von rental)
CREATE TABLE evaluation_rental AS
SELECT rental_id, rental_date, inventory_id, customer_id, return_date, staff_id
FROM rental;
ALTER TABLE evaluation_rental ADD PRIMARY KEY (rental_id);

-- Sequence anlegen: Neue Verleihvorgänge erhalten Ids ab 100000
CREATE SEQUENCE evaluation_rental_seq START WITH 100000;
ALTER TABLE evaluation_rental
    MODIFY rental_id DEFAULT evaluation_rental_seq.NEXTVAL;

-- Neue Spalte Penalty hinzufügen
ALTER TABLE evaluation_rental ADD penalty NUMBER(5,2);

-- Check Constraints in evaluation_rental hinterlegen
ALTER TABLE evaluation_rental ADD CONSTRAINT eval_rental_dates_ck
    CHECK (return_date IS NULL OR return_date >= rental_date);
ALTER TABLE evaluation_rental ADD CONSTRAINT eval_rental_penalty_ck
    CHECK (penalty >= 0);
