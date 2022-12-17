insert into regions (region_id, region_name) values (1, 'EU');
insert into regions (region_id, region_name) values (2, 'RU');
insert into regions (region_id, region_name) values (3, 'DE');
insert into regions (region_id, region_name) values (4, 'AU');
insert into regions (region_id, region_name) values (5, 'ANT');
insert into regions (region_id, region_name) values (6, 'SOUTH-AMERICA');


insert into jobs (job_id, job_title, min_salary, max_salary) values (1, 'Quality Engineer', 318, 1508);
insert into jobs (job_id, job_title, min_salary, max_salary) values (2, 'Geological Engineer', 833, 3040);
insert into jobs (job_id, job_title, min_salary, max_salary) values (3, 'Electrical Engineer', 471, 5185);
insert into jobs (job_id, job_title, min_salary, max_salary) values (4, 'Financial Analyst', 389, 9812);
insert into jobs (job_id, job_title, min_salary, max_salary) values (5, 'Senior Quality Engineer', 124, 5112);
insert into jobs (job_id, job_title, min_salary, max_salary) values (6, 'Assistant Manager', 277, 7577);
insert into jobs (job_id, job_title, min_salary, max_salary) values (7, 'GIS Technical Architect', 284, 8541);
insert into jobs (job_id, job_title, min_salary, max_salary) values (8, 'VP Marketing', 37, 9113);


insert into countries (country_id, country_name, region_id) values ('RU', 'Russia', 1);
insert into countries (country_id, country_name, region_id) values ('CH', 'China', 4);
insert into countries (country_id, country_name, region_id) values ('Sd', 'Macedonia', 3);
insert into countries (country_id, country_name, region_id) values ('PG', 'Indonesia', 4);
insert into countries (country_id, country_name, region_id) values ('CO', 'Belarus', 5);
insert into countries (country_id, country_name, region_id) values ('ET', 'China', 6);

insert into locations (location_id, street_address, postal_code, city, state_province, country_id) values (1, '65 Bartelt Plaza', '74-210', 'Przelewice', null, 'RU');
insert into locations (location_id, street_address, postal_code, city, state_province, country_id) values (2, '54 Comanche Point', null, 'Masparrito', null, 'CH');
insert into locations (location_id, street_address, postal_code, city, state_province, country_id) values (3, '726 Mccormick Center', '442680', 'Nikol’sk', null, 'RU');
insert into locations (location_id, street_address, postal_code, city, state_province, country_id) values (4, '14 Fallview Plaza', null, 'Ghayl Bā Wazīr', null, 'Sd');
insert into locations (location_id, street_address, postal_code, city, state_province, country_id) values (5, '8181 Hanson Plaza', null, 'Selorejo', null, 'PG');
insert into locations (location_id, street_address, postal_code, city, state_province, country_id) values (6, '11 Tomscot Pass', '439 24', 'Onsala', 'Halland', 'CO');
insert into locations (location_id, street_address, postal_code, city, state_province, country_id) values (7, '5 American Ash Terrace', null, 'Chauk', null, 'ET');
insert into locations (location_id, street_address, postal_code, city, state_province, country_id) values (8, '68775 Loomis Street', '1033', 'Sydney', 'New South Wales', 'CO');


insert into departments (department_name, location_id, department_id) values ('Product Management', 1, 1);
insert into departments (department_name, location_id, department_id) values ('ITS', 8, 2);
insert into departments (department_name, location_id, department_id) values ('Business Development', 7, 3);
insert into departments (department_name, location_id, department_id) values ('Human Resources', 8, 4);

insert into employees (employee_id, first_name, last_name, email, hire_date, job_id, salary, commission_pct, manager_id, department_id, postal_address) values (2, 'Andrea', 'Piwell', 'apiwell1@irs.gov', GETDATE(), 2, 2551, 0, null, 2, '42952 Claremont Court');
insert into employees (employee_id, first_name, last_name, email, hire_date, job_id, salary, commission_pct, manager_id, department_id, postal_address) values (3, 'Dionysus', 'Rosel', 'drosel2@buzzfeed.com', GETDATE(), 3, 9312, 0, null, 3, '51 Golf View Center');
insert into employees (employee_id, first_name, last_name, email, hire_date, job_id, salary, commission_pct, manager_id, department_id, postal_address) values (4, 'Brittney', 'Vassall', 'bvassall3@mlb.com', GETDATE(), 4, 796, 0, null, 4, '0 Sunnyside Hill');
insert into employees (employee_id, first_name, last_name, email, hire_date, job_id, salary, commission_pct, manager_id, department_id, postal_address) values (5, 'Fidole', 'Cardon', 'fcardon4@sakura.ne.jp', GETDATE(), 5, 5337, 0, null, 4, '29916 Hallows Road');
insert into employees (employee_id, first_name, last_name, email, hire_date, job_id, salary, commission_pct, manager_id, department_id, postal_address) values (6, 'Christy', 'Fumagallo', 'cfumagallo5@house.gov', GETDATE(), 6, 9811, 0, null, 1, '1 Marquette Way');
insert into employees (employee_id, first_name, last_name, email, hire_date, job_id, salary, commission_pct, manager_id, department_id, postal_address) values (7, 'Flossy', 'MacGow', 'fmacgow6@constantcontact.com', GETDATE(), 7, 9673, 0, null, 2, '3 Old Shore Circle');
insert into employees (employee_id, first_name, last_name, email, hire_date, job_id, salary, commission_pct, manager_id, department_id, postal_address) values (8, 'Berte', 'Vannoort', 'bvannoort7@thetimes.co.uk', GETDATE(), 8, 8314, 0, null, 3, '44 Ryan Circle');
insert into employees (employee_id, first_name, last_name, email, hire_date, job_id, salary, commission_pct, manager_id, department_id, postal_address) values (9, 'Hunfredo', 'Ratt', 'hratt8@yellowbook.com', GETDATE(), 1, 7908, 0, null, 4, '7629 Banding Park');

insert into job_history(employee_id, start_date, end_date, job_id, department_id) values (2,'2008-11-11','2011-11-11',2,1);
insert into job_history(employee_id, start_date, end_date, job_id, department_id) values (4,'2008-11-11','2011-11-11',2,1);
insert into job_history(employee_id, start_date, end_date, job_id, department_id) values (5,'2020-11-11','2021-11-11',4,3);
insert into job_history(employee_id, start_date, end_date, job_id, department_id) values (6,'2018-11-11','2021-11-11',5,4);

TRUNCATE TABLE countries;
TRUNCATE TABLE departments;
TRUNCATE TABLE employees;
TRUNCATE TABLE job_history;
TRUNCATE TABLE jobs;
TRUNCATE TABLE locations;
TRUNCATE TABLE pay;
TRUNCATE TABLE projects;
TRUNCATE TABLE projects_employees;
TRUNCATE TABLE regions;