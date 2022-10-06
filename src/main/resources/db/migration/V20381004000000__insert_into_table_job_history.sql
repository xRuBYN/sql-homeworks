INSERT INTO regions(region_id,region_name) VALUES (1,'Europe');
INSERT INTO countries(country_id, country_name,region_id) VALUES ('MD','Moldova',1);
INSERT INTO locations(LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID) VALUES(1111,'Studentilor 1','MD-2045','Chisinau','Rishka','MD');
INSERT INTO departments(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) VALUES (1,'IT Development',null,1111);
INSERT INTO jobs(JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY) VALUES ('IT','Dev',100,1999);
INSERT INTO employees(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID)
                 VALUES (1,'rufbign','urfsgu','rubin.ursgu@engdav.com','373658g977',current_date,'IT',2000,0,NULL,1);
INSERT INTO JOB_HISTORY(EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID) VALUES (1,'10-JAN-2010','10-JAN-2012','IT',1);