CREATE TABLE employment_log
(
    employment_log_id NUMBER(6) GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    employment_action VARCHAR(5) CHECK(employment_action = 'HIRED' OR employment_action = 'FIRED'),
    employment_status_updtd_tmstmp DATE

);