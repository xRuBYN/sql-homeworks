CREATE OR REPLACE TRIGGER add_department_amount
    AFTER INSERT
    ON departments
    FOR EACH ROW
BEGIN
UPDATE locations
SET locations.department_amount = (locations.department_amount + 1)
WHERE locations.location_id = : new.location_id;
END;

CREATE OR REPLACE TRIGGER minus_department_amount
    AFTER DELETE
    ON departments
    FOR EACH ROW
BEGIN
UPDATE locations
SET locations.department_amount = (locations.department_amount - 1)
WHERE locations.location_id = : old.location_id;
END;