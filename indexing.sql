SELECT * FROM employees

EXPLAIN ANALYSE
SELECT * FROM employees
WHERE employee_name ='Jane Smith'

CREATE INDEX idx_employee_employee_name
ON employees(employee_name);
