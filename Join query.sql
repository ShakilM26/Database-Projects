# 1. Retrieve the full name, department, and salary of all employees, whether they are interns or regular employees.
SELECT full_name, department, salary
FROM google_interns
UNION
SELECT full_name, department, salary
FROM google_employees;

#2. Calculate the average salary for each department, including both interns and regular employees.  
SELECT gi.department, AVG(gi.salary) AS Avg_intern_salary, AVG(ge.salary) AS Avg_employee_salary  
FROM google_interns gi 
LEFT JOIN google_employees ge 
ON gi.Empid = ge.Empid GROUP BY gi.department; 


# 3. List all employees (interns or regular employees) and their laptops. Include employees without laptops
SELECT gi.full_name, gl.laptop_brand 
FROM google_interns gi 
RIGHT JOIN google_laptop gl ON gi.Empid = gl.Empid;
