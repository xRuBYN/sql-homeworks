-- print the biggest number
DECLARE @N1 INT, @N2 INT, @N3 INT; DECLARE @MAI_MARE INT;
SET @N1 = 60 * RAND();
SET @N2 = 60 * RAND();
SET @N3 = 60 * RAND();

IF(@N1 > @N2)
SET @MAI_MARE = @N1
ELSE SET @MAI_MARE = @N2
IF(@MAI_MARE < @N3)
SET @MAI_MARE = @N3

PRINT @MAI_MARE

PRINT @N1;
PRINT @N2;
PRINT @N3;
PRINT 'Mai mare ' + @MAI_MARE;

--print biggest number using case
DECLARE @N1 INT, @N2 INT, @N3 INT;
DECLARE	@MAI_MARE INT;
SET @N1=60*RAND();
SET @N2=60*RAND();
SET @N3=60*RAND();

SET @MAI_MARE=@N1;
SET @MAI_MARE = CASE
		WHEN @N2>@MAI_MARE THEN @N2
		WHEN @N3>@MAI_MARE THEN @N3
		ELSE @MAI_MARE
END

PRINT @N1;
PRINT @N2;
PRINT @N3;
PRINT 'Mai mare = '+CAST(@MAI_MARE AS VARCHAR(2));

--select the employee who works in a product management department
DECLARE @employee_department_id numeric(4) , @department_name varchar(30), @department_id numeric(4)
SET @department_name=(SELECT department_name FROM departments where department_name='Product Management')

IF (@employee_department_id in (SELECT department_id FROM employees WHERE department_id not in (1)))
	PRINT 'No employees with this department id'

ELSE SELECT  TOP (10) first_name, last_name, department_name
     FROM employees, departments
     WHERE departments.department_id=employees.department_id
       and departments.department_name=@department_name
     ORDER BY salary DESC;

--using try catch statement ex1
BEGIN TRY
	DECLARE @N1 INT, @N2 INT, @N3 INT;
	DECLARE	@MAI_MARE INT;
	SET @N1=60*RAND();
	SET @N2=60*RAND();
	SET @N3=60*RAND();

	SET @MAI_MARE=@N1;
	IF @N2>@MAI_MARE  SET @MAI_MARE=@N2;
ELSE IF @N3>@MAI_MARE  SET @MAI_MARE=@N3;

	PRINT @N1;
	PRINT @N2;
	PRINT @N3;
	PRINT 'Mai mare = '+CAST(@MAI_MARE AS VARCHAR(2));
END TRY
BEGIN CATCH
PRINT 'A aparut o eroare'
END CATCH

if @N1=@N2 and @N1=@N3
begin
		RAISERROR('Numerele sunt egale',10,1)
end
else
begin
		SET @MAI_MARE=@N1;
	IF @N2>@MAI_MARE  SET @MAI_MARE=@N2;
ELSE IF @N3>@MAI_MARE  SET @MAI_MARE=@N3;

	PRINT @N1;
	PRINT @N2;
	PRINT @N3;
	PRINT 'Mai mare = '+CAST(@MAI_MARE AS VARCHAR(2));
end

-- EX2 USING TRY CATCH STATEMENT
DECLARE @employee_department_id numeric(4) , @department_name varchar(30), @department_id numeric(4)
SET @department_name=(SELECT department_name FROM departments where department_name='Product Management')
BEGIN TRY
IF (@employee_department_id in (SELECT department_id FROM employees WHERE department_id not in (1)))
	PRINT 'No employees with this department id'

ELSE SELECT  TOP (10) first_name, last_name, department_name
     FROM employees, departments
     WHERE departments.department_id=employees.department_id
       and departments.department_name=@department_name
     ORDER BY salary DESC;
END TRY
BEGIN CATCH
PRINT 'Rise a error';
END CATCH

--chapter 8
--crearea primului view
DROP VIEW IF EXISTS employees_view1;
GO
CREATE VIEW employees_view1 AS
(SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_NAME, STATE_PROVINCE
FROM DEPARTMENTS
         LEFT JOIN EMPLOYEES E on DEPARTMENTS.DEPARTMENT_ID = E.DEPARTMENT_ID
         LEFT JOIN LOCATIONS L on DEPARTMENTS.LOCATION_ID = L.LOCATION_ID)

DROP VIEW IF EXISTS department_s
    GO
CREATE VIEW department_s
AS
SELECT department_name
FROM departments WHERE(SELECT department_id FROM employees)=4;

--EX2
DROP VIEW IF EXISTS region_view;
GO
CREATE VIEW region_view AS
SELECT * FROM regions;
GO
INSERT INTO region_view VALUES(7,'SUA');

UPDATE region_view
SET region_name='AFGAN'
WHERE region_id=7;

DELETE FROM region_view WHERE region_id=7;

SELECT * FROM region_view;

--ex3
GO
ALTER VIEW department_s
WITH SCHEMABINDING -- cant modif and delete the table form view
AS
SELECT department_name
FROM departments WHERE(SELECT department_id FROM employees)=4
    WITH CHECK OPTION -- dont accept dml if where is false

--ex4
GO
DROP TABLE departments;
GO
UPDATE department_s SET department_name='WTF is this' WHERE department_name='Product Management';
--ex5
SELECT CONCAT(e.first_name, e.last_name) AS name
FROM employees e
WHERE e.salary > (SELECT salary FROM employees WHERE employee_id = 4)

with salary_of_employee_id_4(salary) AS
(SELECT salary FROM employees WHERE employee_id = 4)
SELECT CONCAT(e.first_name, e.last_name) AS name
FROM employees e, salary_of_employee_id_4
WHERE e.salary > salary_of_employee_id_4.salary
--use some CTE
SELECT *
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES)

with avg_salary(salary) AS
(SELECT AVG(salary) from employees)
SELECT *
FROM employees, avg_salary
WHERE employees.salary > avg_salary.salary






--ex6
DECLARE @Graph_tab table
(ID INT,
prev_ID INT)
INSERT @Graph_tab
select 5, null union all
select 4, null union all
select 3, null union all
select 0, 5 union all
select 2, 4 union all
select 2, 3 union all
select 1, 2 union all
select 0, 1;

with graph_ex6
         as
         (SELECT *, prev_ID as pred_Nod,0 as generation from @Graph_tab where prev_ID IS NULL and ID=3
          UNION ALL
          SELECT graph.*,graph_ex6.ID as pred_Nod, generation+1
          from @Graph_tab as graph
                   inner join graph_ex6
                              on graph.prev_ID=graph_ex6.ID)

SELECT * FROM graph_ex6;


