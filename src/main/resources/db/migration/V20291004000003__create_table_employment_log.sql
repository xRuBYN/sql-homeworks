CREATE TABLE employment_log
(
    employment_log_id NUMBER(6) NOT NULL PRIMARY KEY ,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    employment_action VARCHAR(5) NOT NULL CHECK(employment_action IN ('HIRED' ,'FIRED')),
    employment_status_updtd_tmstmp DATE NOT NULL

);

CREATE SEQUENCE emp_log_seq INCREMENT BY 1 MAXVALUE 9990 NOCACHE;

ALTER TABLE employment_log MODIFY employment_log_id DEFAULT emp_log_seq.nextval;