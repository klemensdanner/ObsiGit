INSERT INTO premium_customer (customer_id, first_name, last_name) 
       VALUES (3000, 'Mary', 'Poppins');
INSERT INTO premium_customer (first_name, last_name) 
       VALUES ('Mary', 'Poppins');

DELETE FROM premium_customer
WHERE customer_id = 51;

UPDATE premium_customer
   SET numFilms = 40
 WHERE customer_id = 470;
 
UPDATE premium_customer
   SET customer_id = 40
 WHERE customer_id = 470; 
 
UPDATE premium_customer
   SET first_name = 'John',
       last_name = 'Smith'
 WHERE customer_id = 470;  
