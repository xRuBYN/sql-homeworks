CREATE OR REPLACE TRIGGER add_employment_log
    AFTER INSERT
    ON employees
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        procedure_add_employment_log(:new.first_name, :new.last_name,'HIRED',current_date);

    end if;
END;

CREATE OR REPLACE TRIGGER add_employment_log
    BEFORE DELETE
    ON employees
    FOR EACH ROW
BEGIN
    IF DELETING THEN
        procedure_add_employment_log(:old.first_name, :old.last_name,'FIRED',current_date);

    end if;
END;




CREATE OR REPLACE PROCEDURE procedure_add_employment_log
( p_first_name                        employment_log.first_name%type
, p_last_name                         employment_log.last_name%type
, p_employment_action                 employment_log.employment_action%type
, p_employment_status_updtd_tmstmp    employment_log.employment_status_updtd_tmstmp%type
)
IS
BEGIN
    INSERT INTO employment_log(first_name, last_name, employment_status_updtd_tmstmp)
    VALUES(p_first_name, p_last_name, p_employment_action, p_employment_status_updtd_tmstmp);
END procedure_add_employment_log;