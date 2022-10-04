CREATE TABLE pay
(
    cardNr NUMBER(16) PRIMARY KEY,
    salary NUMBER(8,2),
    commission_pct NUMBER(2, 2),
    employee_id NUMBER(6),
    CONSTRAINT fk_pay_table
        FOREIGN KEY (employee_id)
            REFERENCES employees(employee_id)

);
