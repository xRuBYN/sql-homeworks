ALTER TABLE locations ADD department_amount INTEGER DEFAULT 0;
COMMENT ON COLUMN locations.department_amount IS 'Contains the amount of departments in the location';
