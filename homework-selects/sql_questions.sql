-- Write a query to display: 
-- 1. the first name, last name, salary, and job grade for all employees.
SELECT first_name, last_name, salary, job_title
FROM employees
         LEFT JOIN jobs USING (job_id);
-- 2. the first and last name, department, city, and state province for each employee.
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_NAME, STATE_PROVINCE
FROM DEPARTMENTS
         LEFT JOIN EMPLOYEES E on DEPARTMENTS.DEPARTMENT_ID = E.DEPARTMENT_ID
         LEFT JOIN LOCATIONS L on DEPARTMENTS.LOCATION_ID = L.LOCATION_ID;
-- 3. the first name, last name, department number and department name, for all employees for departments 80 or 40.
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID, DEPARTMENT_NAME
FROM EMPLOYEES
         LEFT JOIN DEPARTMENTS
                   USING (DEPARTMENT_ID)
WHERE DEPARTMENT_ID IN(40,80);
-- 4. those employees who contain a letter z to their first name and also display their last name, department, city, and state province.
SELECT first_name, last_name, department_name, city, state_province
FROM employees e
         LEFT JOIN departments d on d.department_id = e.department_id
         LEFT JOIN locations l on d.location_id = l.location_id
WHERE first_name like '%z%';
-- 5. the first and last name and salary for those employees who earn less than the employee earn whose number is 182.
SELECT first_name, last_name, salary
FROM employees e
WHERE e.salary < (SELECT salary
                  FROM employees
                  where employee_id = 182);
-- 6. the first name of all employees including the first name of their manager.
SELECT E.FIRST_NAME, M.FIRST_NAME AS MANAGER_NAME
FROM EMPLOYEES E
         JOIN EMPLOYEES M ON E.MANAGER_ID = M.EMPLOYEE_ID;
-- 7. the first name of all employees and the first name of their manager including those who does not working under any manager.
SELECT E.FIRST_NAME, M.FIRST_NAME AS MANAGER_NAME
FROM EMPLOYEES E
         LEFT JOIN EMPLOYEES M ON E.MANAGER_ID = M.EMPLOYEE_ID;
-- 8. the details of employees who manage a department.
SELECT *
FROM EMPLOYEES E
WHERE E.EMPLOYEE_ID = ANY (SELECT MANAGER_ID FROM DEPARTMENTS WHERE MANAGER_ID IS NOT NULL);
-- 9. the first name, last name, and department number for those employees who works in the same department as the employee who holds the last name as Taylor.
SELECT e.first_name, e.last_name, e.department_id
FROM employees e
WHERE department_id = ANY (SELECT department_id FROM employees WHERE last_name LIKE 'Taylor');

--10. the department name and number of employees in each of the department.
SELECT d.department_name, COUNT(e.employee_id)
FROM employees e
         RIGHT JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;
--11. the name of the department, average salary and number of employees working in that department who got commission.
SELECT d.department_name, AVG(e.salary), COUNT(e.employee_id)
FROM employees e
         RIGHT JOIN departments d USING (department_id)
WHERE e.commission_pct IS NOT NULL
GROUP BY d.department_name;
--12. job title and average salary of employees.
SELECT j.job_title, AVG(e.salary)
FROM employees e
         RIGHT JOIN jobs j ON j.job_id = e.job_id
GROUP BY j.job_title;
--13. the country name, city, and number of those departments where at least 2 employees are working.
SELECT e.department_id, c.country_name, l.city, d.DEPARTMENT_NAME
FROM departments d
         JOIN locations l USING (location_id)
         JOIN countries c USING (country_id)
         LEFT JOIN employees e ON e.department_id = d.department_id
GROUP BY e.department_id, c.country_name, l.city, d.DEPARTMENT_NAMe
HAVING COUNT(e.employee_id) >= 2;

--14. the employee ID, job name, number of days worked in for all those jobs in department 80.
SELECT EMPLOYEE_ID, J.JOB_TITLE, SUM(END_DATE - START_DATE)
FROM JOB_HISTORY
         LEFT JOIN JOBS J USING (JOB_ID)
         LEFT JOIN EMPLOYEES E USING (EMPLOYEE_ID)
WHERE E.DEPARTMENT_ID = 80
GROUP BY EMPLOYEE_ID, J.JOB_TITLE;

--15. the name ( first name and last name ) for those employees who gets more salary than the employee whose ID is 163.
SELECT CONCAT(e.first_name, e.last_name) AS name
FROM employees e
WHERE e.salary > (SELECT salary FROM employees WHERE employee_id = 163);
--16. the employee id, employee name (first name and last name ) for all employees who earn more than the average salary.
SELECT e.employee_id, CONCAT(e.first_name, e.last_name) AS employee_name
FROM employees e
WHERE e.salary > (SELECT AVG(salary) FROM employees);
--17. the employee name ( first name and last name ), employee id and salary of all employees who report to Payam.
SELECT CONCAT(CONCAT(E.FIRST_NAME, ' '), E.LAST_NAME), E.EMPLOYEE_ID, E.SALARY
FROM EMPLOYEES E
         LEFT JOIN EMPLOYEES M ON E.MANAGER_ID = M.EMPLOYEE_ID
WHERE M.FIRST_NAME LIKE 'Payam';
--18. the department number, name ( first name and last name ), job and department name for all employees in the Finance department.
SELECT department_id, CONCAT(e.first_name, e.last_name), job_title, department_name
FROM employees e
         LEFT JOIN departments USING (department_id)
         LEFT JOIN jobs USING (job_id)
WHERE department_name LIKE 'Finance';
--19. all the information of an employee whose id is any of the number 134, 159 and 183.
SELECT *
FROM employees
WHERE employee_id IN (134, 159, 183);
--20. all the information of the employees whose salary is within the range of smallest salary and 2500.
SELECT *
FROM EMPLOYEES
WHERE SALARY > (SELECT MIN(SALARY) FROM EMPLOYEES)
  AND SALARY < 2500;
--21. all the information of the employees who does not work in those departments where some employees works whose id within the range 100 and 200.
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID != ANY (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID > 100 AND EMPLOYEE_ID < 200);
--22. all the information for those employees whose id is any id who earn the second highest salary.
SELECT *
FROM EMPLOYEES
WHERE SALARY = ((SELECT MIN(SALARY)
                 FROM (SELECT DISTINCT SALARY FROM EMPLOYEES ORDER BY SALARY DESC)
                 WHERE ROWNUM < 3));
--23. the employee name( first name and last name ) and hiredate for all employees in the same department as Clara. Exclude Clara.
SELECT CONCAT(CONCAT(FIRST_NAME, ' '), LAST_NAME) as name, HIRE_DATE
FROM EMPLOYEES
WHERE DEPARTMENT_ID =
      (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEES.FIRST_NAME LIKE 'Clara')
  AND FIRST_NAME NOT LIKE 'Clara';
--24. the employee number and name( first name and last name ) for all employees who work in a department with any employee whose name contains a T.
SELECT EMPLOYEE_ID, CONCAT(CONCAT(FIRST_NAME, ' '), LAST_NAME) as name
FROM EMPLOYEES
WHERE DEPARTMENT_ID = ANY (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME LIKE '%T%');
--25. full name(first and last name), job title, starting and ending date of last jobs for those employees with worked without a commission percentage.
SELECT CONCAT(CONCAT(FIRST_NAME, ' '), LAST_NAME), JOB_TITLE, START_DATE, END_DATE
FROM EMPLOYEES
         JOIN JOB_HISTORY JH on EMPLOYEES.EMPLOYEE_ID = JH.EMPLOYEE_ID
         JOIN JOBS J on JH.JOB_ID = J.JOB_ID
WHERE COMMISSION_PCT IS NULL;
--26. the employee number, name( first name and last name ), and salary for all employees who earn more than the average salary and who work in a department with any employee with a J in their name.
SELECT EMPLOYEE_ID, CONCAT(CONCAT(FIRST_NAME, ' '), LAST_NAME) as name
FROM EMPLOYEES
WHERE DEPARTMENT_ID =
    ANY (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME LIKE '%J%')
  AND SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);
--27. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN.
SELECT EMPLOYEE_ID, CONCAT(CONCAT(FIRST_NAME, ' '), LAST_NAME) as name, JOB_TITLE
FROM EMPLOYEES E
         JOIN JOBS J ON E.JOB_ID = J.JOB_ID
WHERE SALARY <= (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID LIKE 'MK_MAN');

--28. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN.
SELECT EMPLOYEE_ID, CONCAT(CONCAT(FIRST_NAME, ' '), LAST_NAME) as name, JOB_TITLE
FROM EMPLOYEES E
         JOIN JOBS J ON E.JOB_ID = J.JOB_ID
WHERE SALARY <= (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID LIKE 'MK_MAN')
  AND E.JOB_ID NOT LIKE 'MK_MAN';
--29. all the information of those employees who did not have any job in the past.
SELECT *
FROM EMPLOYEES
WHERE NOT EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM JOB_HISTORY);

--30. the employee number, name( first name and last name ) and job title for all employees whose salary is more than any average salary of any department.
SELECT EMPLOYEE_ID, CONCAT(CONCAT(FIRST_NAME, ' '), LAST_NAME) as name, JOB_TITLE
FROM EMPLOYEES E
         JOIN JOBS J USING (JOB_ID)
WHERE SALARY > ANY (SELECT AVG(SALARY)
                    FROM EMPLOYEES
                    WHERE DEPARTMENT_ID IN
                              (SELECT DEPARTMENT_ID FROM DEPARTMENTS)
                    GROUP BY DEPARTMENT_ID);

--31. the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.
SELECT  EMPLOYEE_ID,  CONCAT(CONCAT(FIRST_NAME, ' '), LAST_NAME) as name,
        CASE
            WHEN 'ST_MAN' = JOB_ID THEN 'SALESMAN'
            WHEN 'IT_PROG' = JOB_ID THEN 'DEVELOPER'
            ELSE JOB_ID
            END AS NEW_JOB,  SALARY
FROM EMPLOYEES;
--32. the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
SELECT  EMPLOYEE_ID,  CONCAT(CONCAT(FIRST_NAME, ' '), LAST_NAME) as name, SALARY,
        CASE WHEN SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEES)
                 THEN 'HIGH'
             ELSE 'LOW'
            END AS SalaryStatus
FROM EMPLOYEES;
--33. the employee id, name ( first name and last name ), SalaryDrawn, AvgCompare (salary - the average salary of all employees)
-- and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than
-- the average salary of all employees.
SELECT  EMPLOYEE_ID,  FIRST_NAME, LAST_NAME,  SALARY AS SalaryDrawn,
        ROUND((SALARY -(SELECT AVG(SALARY) FROM EMPLOYEES)), 2) AS AvgCompare,
        CASE  WHEN SALARY >=
                   (SELECT AVG(SALARY) FROM EMPLOYEES)
                  THEN 'HIGH'
              ELSE 'LOW'
            END AS SalaryStatus
FROM EMPLOYEES;
--34. all the employees who earn more than the average and who work in any of the IT departments.
SELECT *
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES)
  AND DEPARTMENT_ID = ANY(SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME LIKE '%IT%');
--35. who earns more than Mr.Ozer.
SELECT *
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE LAST_NAME LIKE 'Ozer');
--36. which employees have a manager who works for a department based in the US.
SELECT E.FIRST_NAME, E.LAST_NAME, E.MANAGER_ID
FROM DEPARTMENTS D
         LEFT JOIN EMPLOYEES E USING(DEPARTMENT_ID)
WHERE E.MANAGER_ID = ANY(SELECT MANAGER_ID
FROM DEPARTMENTS
WHERE DEPARTMENTS.LOCATION_ID = ANY(SELECT  DISTINCT LOCATION_ID
    FROM LOCATIONS
    WHERE COUNTRY_ID LIKE 'US'));

--37. the names of all employees whose salary is greater than 50% of their department’s total salary bill.
SELECT CONCAT(CONCAT(FIRST_NAME, ' '), LAST_NAME)
FROM EMPLOYEES
WHERE SALARY > ANY(SELECT (SUM(SALARY) /2) FROM EMPLOYEES
                   WHERE DEPARTMENT_ID =
                   ANY(SELECT DEPARTMENT_ID FROM DEPARTMENTS) GROUP BY DEPARTMENT_ID) GROUP BY DEPARTMENT_ID,CONCAT(CONCAT(FIRST_NAME, ' '), LAST_NAME) ;
--38. the employee id, name ( first name and last name ), salary, department name and city for all
SELECT EMPLOYEE_ID,CONCAT(CONCAT(FIRST_NAME, ' '), LAST_NAME) as name, SALARY, DEPARTMENT_NAME, CITY
FROM DEPARTMENTS
RIGHT JOIN EMPLOYEES USING(DEPARTMENT_ID)
LEFT JOIN LOCATIONS USING(LOCATION_ID);
--the employees who gets the salary as the salary earn by the employee which is maximum within the joining person January 1st, 2002 and December 31st, 2003.
SELECT *
FROM EMPLOYEES
WHERE SALARY = (SELECT MAX(SALARY)
                FROM EMPLOYEES
                WHERE HIRE_DATE BETWEEN TO_DATE('2002-JAN-01','YYYY-MM-DD') AND TO_DATE('2003-DEC-31','YYYY-MM-DD'));
--39. the first and last name, salary, and department ID for all those employees who earn more than the average salary and arrange the list in descending order on salary.
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES)
ORDER BY SALARY DESC;
--40. the first and last name, salary, and department ID for those employees who earn more than the maximum salary of a department which ID is 40.
SELECT FIRST_NAME, LAST_NAME,SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY > (SELECT MAX(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID = 40);
--41. the department name and Id for all departments where they located, that Id is equal to the Id for the location where department number 30 is located.
SELECT  DEPARTMENT_NAME, LOCATION_ID
FROM DEPARTMENTS
    WHERE LOCATION_ID = (SELECT LOCATION_ID FROM DEPARTMENTS WHERE DEPARTMENT_ID = 30);
--42. the first and last name, salary, and department ID for all those employees who work in that department where the employee works who hold the ID 201.
SELECT FIRST_NAME, LAST_NAME, SALARY,DEPARTMENT_ID
FROM EMPLOYEES
    WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 201);
--43. the first and last name, salary, and department ID for those employees whose salary is equal to the salary of the employee who works in that department which ID is 40.
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY = ANY(SELECT SALARY FROM EMPLOYEES WHERE DEPARTMENT_ID = 40);
--44. the first and last name, salary, and department ID for those employees who earn more than the minimum salary of a department which ID is 40.
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY > (SELECT MIN(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID = 40);
--45. the first and last name, salary, and department ID for those employees who earn less than the minimum salary of a department which ID is 70.
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY < (SELECT MIN(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID = 70);
--46. the first and last name, salary, and department ID for those employees who earn less than the average salary, and also work at the department where the employee Laura is working as a first name holder.
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEES)
  AND DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME LIKE 'Laura');
--47. the full name (first and last name) of manager who is supervising 4 or more employees.
SELECT CONCAT(CONCAT(M.FIRST_NAME,' '), M.LAST_NAME) AS MANAGER_NAME, E.MANAGER_ID
FROM EMPLOYEES E
         LEFT JOIN EMPLOYEES M ON E.MANAGER_ID = M.EMPLOYEE_ID
GROUP BY E.MANAGER_ID, CONCAT(CONCAT(M.FIRST_NAME,' '), M.LAST_NAME), E.MANAGER_ID
HAVING COUNT(E.MANAGER_ID) >= 4;
--48. the details of the current job for those employees who worked as a Sales Representative in the past.
SELECT *
FROM JOBS
WHERE JOB_ID = (SELECT E.JOB_ID
                FROM EMPLOYEES E LEFT JOIN JOB_HISTORY JH USING(EMPLOYEE_ID)
                WHERE E.JOB_ID = ANY(SELECT JOB_ID FROM JOB_HISTORY)
                  AND JH.JOB_ID = (SELECT JOBS.JOB_ID FROM JOBS WHERE JOB_TITLE LIKE 'Sales Representative'));
--49. all the infromation about those employees who earn second lowest salary of all the employees.
SELECT *
FROM EMPLOYEES
WHERE SALARY = ((SELECT max(SALARY)
                 FROM (SELECT DISTINCT SALARY FROM EMPLOYEES ORDER BY SALARY ASC)
                 WHERE ROWNUM < 3));
--50. the department ID, full name (first and last name), salary for those employees who is highest salary drawar in a department.
SELECT DEPARTMENT_ID,CONCAT(CONCAT(FIRST_NAME, ' '), LAST_NAME),SALARY
FROM EMPLOYEES E
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID = E.DEPARTMENT_ID)