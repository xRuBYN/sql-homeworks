
-- sterge baza de date inidiferent daca este utilizata sau nu;
IF DB_ID('employeedb') IS NOT NULL
 BEGIN
  DECLARE @kill varchar(8000) = '';
SELECT @kill = @kill + 'kill ' + CONVERT(varchar(5), session_id) + ';'
FROM sys.dm_exec_sessions
WHERE database_id  = db_id('employeedb')
    EXEC(@kill);

DROP DATABASE employeedb;
END


CREATE TABLE countries
(
    country_id   CHAR(2),
    country_name VARCHAR(40),
    region_id    numeric NOT NULL,
    CONSTRAINT country_c_id_pk PRIMARY KEY (country_id)
);


CREATE TABLE departments
(
    department_id   NUMERIC(4) PRIMARY KEY,
    department_name VARCHAR(30) NOT NULL,
    manager_id      numeric(6),
    location_id     numeric(4) NOT NULL
);

CREATE SEQUENCE departments_seq INCREMENT BY 10 MAXVALUE 9990;


CREATE TABLE employees
(
    employee_id    numeric(6) PRIMARY KEY,
    first_name     VARCHAR(20),
    last_name      VARCHAR(25)        NOT NULL,
    email          VARCHAR(25) UNIQUE NOT NULL,
    phone_number   VARCHAR(20),
    hire_date      DATE                NOT NULL,
    job_id         VARCHAR(10)        NOT NULL,
    salary         numeric(8,2),
    commission_pct numeric(2,2),
    manager_id     numeric(6),
    department_id  numeric(4)           NOT NULL,
    CONSTRAINT emp_salary_min CHECK (salary > 0)
);

CREATE SEQUENCE employees_seq;

CREATE INDEX emp_name_ix ON employees (last_name, first_name);


CREATE TABLE jobs
(
    job_id     VARCHAR(10) PRIMARY KEY,
    job_title  VARCHAR(35) NOT NULL,
    min_salary numeric(6),
    max_salary numeric(6),
    CONSTRAINT min_max_salary_ck CHECK ( min_salary < max_salary )
);


CREATE TABLE job_history
(
    employee_id   numeric(6)   NOT NULL,
    start_date    DATE         NOT NULL,
    end_date      DATE         NOT NULL,
    job_id        VARCHAR(10) NOT NULL,
    department_id NUMERIC(4)    NOT NULL,
    CONSTRAINT jhist_date_interval CHECK (end_date > start_date),
    CONSTRAINT jhist_emp_id_st_date_pk PRIMARY KEY (employee_id, start_date)
);


CREATE TABLE locations
(
    location_id    numeric(4) PRIMARY KEY,
    street_address VARCHAR(40),
    postal_code    VARCHAR(12),
    city           VARCHAR(30),
    state_province VARCHAR(25),
    country_id     CHAR(2) NOT NULL
);

CREATE SEQUENCE locations_seq MINVALUE 1 MAXVALUE 9900 INCREMENT BY 100 START WITH 3300;


CREATE INDEX loc_country_ix ON locations (country_id);


CREATE TABLE regions
(
    region_id   numeric PRIMARY KEY,
    region_name VARCHAR(25)
);

CREATE TABLE pay
(
    cardNr NUMERIC(16) PRIMARY KEY,
    salary NUMERIC(8,2),
    commission_pct NUMERIC(2, 2),
    employee_id numeric(6),
    CONSTRAINT fk_pay_table
        FOREIGN KEY (employee_id)
            REFERENCES employees(employee_id)

);


CREATE TABLE projects
(
    project_id INTEGER PRIMARY KEY,
    project_description VARCHAR(255)
        CHECK (LEN(project_description) > 10),
    project_investments INTEGER
        CHECK (project_investments > 0),
    project_revenue INTEGER
        CHECK (project_revenue > 0),
    employee_id NUMERIC(6)
);

CREATE TABLE projects_employees
(
    employee_id numeric(6),
    project_id INTEGER,
    CONSTRAINT fk_employee_id
        FOREIGN KEY (employee_id)
            REFERENCES employees(employee_id),
    CONSTRAINT fk_project_id
        FOREIGN KEY (project_id)
            REFERENCES projects(project_id)
);


--------------------------------------------------------
--  Ref Constraints for Table COUNTRIES
--------------------------------------------------------

ALTER TABLE COUNTRIES
    ADD CONSTRAINT COUNTR_REG_FK FOREIGN KEY (REGION_ID)
        REFERENCES REGIONS (REGION_ID);
--------------------------------------------------------
--  Ref Constraints for Table DEPARTMENTS
--------------------------------------------------------

ALTER TABLE DEPARTMENTS
    ADD CONSTRAINT DEPT_LOC_FK FOREIGN KEY (LOCATION_ID)
        REFERENCES LOCATIONS (LOCATION_ID);
ALTER TABLE DEPARTMENTS
    ADD CONSTRAINT DEPT_MGR_FK FOREIGN KEY (MANAGER_ID)
        REFERENCES EMPLOYEES (EMPLOYEE_ID);
--------------------------------------------------------
--  Ref Constraints for Table EMPLOYEES
--------------------------------------------------------

ALTER TABLE EMPLOYEES
    ADD CONSTRAINT EMP_DEPT_FK FOREIGN KEY (DEPARTMENT_ID)
        REFERENCES DEPARTMENTS (DEPARTMENT_ID);
ALTER TABLE EMPLOYEES
    ADD CONSTRAINT EMP_JOB_FK FOREIGN KEY (JOB_ID)
        REFERENCES JOBS (JOB_ID);
ALTER TABLE EMPLOYEES
    ADD CONSTRAINT EMP_MANAGER_FK FOREIGN KEY (MANAGER_ID)
        REFERENCES EMPLOYEES (EMPLOYEE_ID);
--------------------------------------------------------
--  Ref Constraints for Table JOB_HISTORY
--------------------------------------------------------

ALTER TABLE JOB_HISTORY
    ADD CONSTRAINT JHIST_JOB_FK FOREIGN KEY (JOB_ID)
        REFERENCES JOBS (JOB_ID);
ALTER TABLE JOB_HISTORY
    ADD CONSTRAINT JHIST_EMP_FK FOREIGN KEY (EMPLOYEE_ID)
        REFERENCES EMPLOYEES (EMPLOYEE_ID);
ALTER TABLE JOB_HISTORY
    ADD CONSTRAINT JHIST_DEPT_FK FOREIGN KEY (DEPARTMENT_ID)
        REFERENCES DEPARTMENTS (DEPARTMENT_ID);
--------------------------------------------------------
--  Ref Constraints for Table LOCATIONS
--------------------------------------------------------

ALTER TABLE LOCATIONS
    ADD CONSTRAINT LOC_C_ID_FK FOREIGN KEY (COUNTRY_ID)
        REFERENCES COUNTRIES (COUNTRY_ID);
