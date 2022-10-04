CREATE TABLE projects
(
    project_id INTEGER PRIMARY KEY,
    project_description VARCHAR(255)
        CHECK (LENGTH(project_description) > 10),
    project_investments INTEGER
        CHECK (project_investments > 0),
    project_revenue INTEGER
        CHECK (project_revenue > 0),
    employee_id NUMBER(6)
);
