
-- Hilfstabelle erstellen

CREATE TABLE MY_EMPLOYEE (
    id NUMBER(6) CONSTRAINT my_employee_id_pk PRIMARY KEY,
    last_name VARCHAR2(25) NOT NULL,
    first_name VARCHAR2(20) NOT NULL,
    email VARCHAR2(8),
    salary NUMBER(8,2) NOT NULL,
    hire_date DATE DEFAULT SYSDATE);


-- 1












