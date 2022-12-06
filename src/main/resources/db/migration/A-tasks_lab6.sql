
USE employeesdb;


--------------------------------------------------------
--  Create schema TERRITORY and add something in it, also create synonyms for this schema
--------------------------------------------------------

CREATE SCHEMA territory AUTHORIZATION Rubin
GRANT SELECT ON SCHEMA :: territory TO Rubin


ALTER SCHEMA territory
    TRANSFER dbo.countries
ALTER SCHEMA territory
    TRANSFER dbo.locations
ALTER SCHEMA territory
    TRANSFER dbo.regions


CREATE SYNONYM countries_syn FOR employeesdb.territory.countries;
CREATE SYNONYM locations_syn FOR employeesdb.territory.locations;
CREATE SYNONYM regions_syn FOR employeesdb.territory.regions;


--------------------------------------------------------
--  Create schema PEOPLE and add something in it, also create synonyms for this schema
--------------------------------------------------------


CREATE SCHEMA people AUTHORIZATION Rubin
GRANT SELECT ON SCHEMA :: people TO Rubin

ALTER SCHEMA people
    TRANSFER dbo.departments
ALTER SCHEMA people
    TRANSFER dbo.employees
ALTER SCHEMA people
    TRANSFER dbo.pay

CREATE SYNONYM departments_syn FOR employeesdb.people.departments;
CREATE SYNONYM employees_syn FOR employeesdb.people.employees;
CREATE SYNONYM pay_syn FOR employeesdb.people.pay;


--------------------------------------------------------
--  Revoke Changes with sinonyms and schemas
--------------------------------------------------------

ALTER SCHEMA dbo
    TRANSFER territory.countries
ALTER SCHEMA dbo
    TRANSFER territory.regions
ALTER SCHEMA dbo
    TRANSFER territory.locations


ALTER SCHEMA dbo
    TRANSFER people.employees
ALTER SCHEMA dbo
    TRANSFER people.departments
ALTER SCHEMA dbo
    TRANSFER people.pay