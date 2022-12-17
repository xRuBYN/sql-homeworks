--create 2 procedure
SELECT first_name, last_name, salary, job_title
FROM employees e
         LEFT JOIN jobs j ON e.job_id = j.job_id ;
GO
CREATE PROCEDURE info_employees
    AS
BEGIN
SELECT first_name, last_name, salary, job_title
FROM employees e
         LEFT JOIN jobs j ON e.job_id = j.job_id;
END

EXEC info_employees;
GO
CREATE PROCEDURE employee_info2
    AS
BEGIN
SELECT FIRST_NAME, LAST_NAME, d.DEPARTMENT_ID, DEPARTMENT_NAME
FROM EMPLOYEES e
         LEFT JOIN DEPARTMENTS d
                   on e.department_id = d.department_id
WHERE d.DEPARTMENT_ID IN(1,6);
END

EXEC employee_info2
--numarul de muncitori cu salariul mai mare de 5k ex2
drop procedure if exists nrEmployees
    go
create procedure nrEmployees
    @nr int=null output
	as
begin
			set nocount on;
			SET @nr=(select Count(employee_id)
							from employees
								where salary > 5000)
			print ('Numarul muncitorilor cu salariul mai mare de 5000 este '+CAST(@nr as varchar(10))+'.');
end

exec nrEmployees;

--create a procedure with parametres that insert data in employees table
create PROCEDURE addEmployees
    @employee_id    numeric(6),
    @first_name     VARCHAR(20),
    @last_name      VARCHAR(25),
    @email          VARCHAR(25),
    @phone_number   VARCHAR(20),
    @hire_date      DATE,
    @job_id         VARCHAR(10),
    @salary         numeric(8,2),
    @commission_pct numeric(2,2),
    @manager_id     numeric(6),
    @department_id  numeric(4) AS
BEGIN
INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES(@employee_id, @first_name, @last_name, @email, @phone_number, @hire_date, @job_id, @salary, @commission_pct, @manager_id, @department_id)
END

EXEC addEmployees
    @employee_id=10,
    @first_name='Rubin',
    @last_name='Ursu',
    @email='rubin.ursu@mail.ru',
    @phone_number='+37368948069',
    @hire_date='2018-10-10',
    @job_id='1',
    @salary=6500,
    @commission_pct=0,
    @manager_id=null,
    @department_id=4

--create a procedure that change job for employee and add job history
drop PROCEDURE if EXISTS changeJob
    GO
CREATE PROCEDURE changeJob
@employee_id NUMERIC(6),
@job_id VARCHAR(10) AS
BEGIN
DECLARE @temp_job_id VARCHAR(10), @temp_hire_date DATE, @temp_department_id numeric(4)
SET @temp_department_id=(select department_id from employees WHERE employee_id=@employee_id)
SET @temp_job_id=(select job_id from employees WHERE employee_id=@employee_id);
SET @temp_hire_date=(select hire_date from employees WHERE employee_id=@employee_id);
INSERT INTO job_history VALUES(@employee_id, @temp_hire_date,GETDATE(),@job_id, @temp_department_id)
UPDATE employees SET job_id=@job_id WHERE employee_id=@employee_id
END

EXEC changeJob
@employee_id=10,
@job_id=8
--ex5 create a procedure that update salary
drop PROCEDURE if EXISTS salary_proc
    GO
create PROCEDURE salary_proc
    @department_id NUMERIC(4)
as
DECLARE @list TABLE (employee_id NUMERIC(6), salary NUMERIC(8,2))
insert into @list
SELECT top(3) employee_id, salary
from employees
where department_id=@department_id
ORDER BY salary DESC

UPDATE employees SET salary=(CASE WHEN salary > 4000 THEN 5000 ELSE salary+500 END)
WHERE department_id=@department_id and employee_id in (select employee_id from @list)
    GO
EXEC salary_proc
@department_id=4
--ex6 function with parameter
drop FUNCTION if EXISTS employee_func

GO
CREATE FUNCTION employee_func(@department_id numeric(4))
    RETURNS TABLE
    as
RETURN
(SELECT FIRST_NAME, LAST_NAME, d.DEPARTMENT_ID, DEPARTMENT_NAME
FROM EMPLOYEES e
         LEFT JOIN DEPARTMENTS d
                   on e.department_id = d.department_id
WHERE d.DEPARTMENT_ID=@department_id)
go
SELECT * FROM employee_func(4);