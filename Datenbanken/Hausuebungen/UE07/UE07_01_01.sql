CREATE OR REPLACE PROCEDURE customer_export (id_list IN VARCHAR2)
IS
    CURSOR ids IS
        SELECT to_number(REGEXP_SUBSTR(id_list, '[^, ]+',  1, LEVEL)) id
        FROM dual
        CONNECT BY LEVEL <= LENGTH(id_list) - LENGTH(REGEXP_REPLACE(id_list, ',? ?','')) + 1;
    first_name  customer.first_name%TYPE;
    last_name   customer.last_name%TYPE;
    email       customer.email%TYPE;
BEGIN
    FOR id_rec IN ids LOOP
        SELECT first_name, last_name, email
            INTO first_name, last_name, email
        FROM customer
        WHERE customer_id = id_rec.id
          AND active = 1;
        DBMS_OUTPUT.PUT_LINE(first_name || ',' || last_name || ',' || email);
    END LOOP;
END;
/
