CREATE TABLE projects_employees
(
    employee_id NUMBER(6),
    project_id INTEGER,
    CONSTRAINT fk_employee_id
        FOREIGN KEY (employee_id)
            REFERENCES employees(employee_id),
    CONSTRAINT fk_project_id
            FOREIGN KEY (project_id)
            REFERENCES projects(project_id)
);
