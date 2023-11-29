
# Calculate the average salary for each department, including both interns and regular employees for both table.
SELECT position, AVG(salary) FROM 
(SELECT position, salary FROM interns_brainstation23 
UNION ALL
SELECT position, salary FROM employee_brainstation23) AS COMBINED_DATA 
GROUP BY position;

# List all employees and their laptops. Include employees without laptops.
SELECT be.full_name, bl.full_name, bl.brand, bl.price FROM employee_brainstation23 be 
LEFT JOIN laptop_brainstation23 bl ON be.Empid = bl.Empid;

# Find those who are in the INTERN table but not in the EMPLOYEE table.
SELECT bi.full_name
FROM interns_brainstation23 bi
LEFT JOIN employee_brainstation23 be ON bi.full_name = be.full_name
WHERE be.full_name IS NULL;


# Find pairs of employees who have the same division and education. Display their full names, division and education. 
SELECT be.full_name, be.division, be.education FROM employee_brainstation23 be 
INNER JOIN interns_brainstation23 bi ON be.Empid = bi.Empid AND be.division = bi.division;


