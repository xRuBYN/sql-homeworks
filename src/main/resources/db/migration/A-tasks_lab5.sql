--task 1 add new column postal address and set the address mun.Chisinau is it null
ALTER TABLE employees_syn
   ADD  postal_address VARCHAR(255);
UPDATE employees_syn
    SET employees_syn.postal_address = 'mun.Chisinau'
WHERE employees_syn.postal_address IS NULL
--task 2 create a new constraint for department
ALTER TABLE departments_syn
    ADD CONSTRAINT UQ_department_name UNIQUE(department_name);

--task 3 update department manager with the max salary manager
UPDATE departments_syn
    SET manager_id =
        (SELECT TOP 1 employee_id FROM employees_syn WHERE salary =
                                                 (SELECT MAX(salary) FROM employees_syn))

-- task 4 add 3000 if salarty is less than 10000 or equal
UPDATE employees_syn
SET salary = salary + 3000
WHERE salary <= 10000;

--task 5 create new table with name new_employee with 3 new column
SELECT employee_id, first_name, last_name, salary,
       SUBSTRING(postal_address, 0, CHARINDEX(',',postal_address,0)) AS location,
       SUBSTRING(postal_address,CHARINDEX(',',postal_address,0) + 1,CHARINDEX('|',postal_address,0) - CHARINDEX(',',postal_address,0) - 1) AS address1,
       SUBSTRING(postal_address,CHARINDEX('|',postal_address,0) + 1,LEN(postal_address)) AS address2
INTO  new_employees
FROM employees_syn;

--task 6 insert data into table
INSERT INTO regions_syn(region_id,region_name) VALUES (1,'Europe');
INSERT INTO countries_syn(country_id, country_name,region_id) VALUES ('MD','Moldova',1);
INSERT INTO locations_syn(LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID) VALUES(1111,'Studentilor 1','MD-2045','Chisinau','Rishka','MD');
INSERT INTO departments_syn(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) VALUES (1,'IT Development',null,1111);
INSERT INTO jobs(JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY) VALUES ('IT','Dev',100,1999);
INSERT INTO employees_syn(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID,postal_address)
VALUES (1,'rufbign','urfsgu','rubin.ursgu@engdav.com','373658g977',GETDATE(),'IT',2000,0,NULL,1,'Fetesti,1|2');
INSERT INTO JOB_HISTORY(EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID) VALUES (1,'10-JAN-2010','10-JAN-2012','IT',1);

--task 7


--task 8 add file group userdatafgroup1 and nonclustered index
ALTER DATABASE employeesdb ADD FILEGROUP userdatafgroup1;
CREATE NONCLUSTERED INDEX department_manager ON departments_syn (manager_id);

