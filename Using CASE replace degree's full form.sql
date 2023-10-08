-- We have some data that contains employee name and their degre and salary. 
-- I am creating a new column which will contain full form of degree
SELECT *, CASE 
WHEN degree = 'BCS' THEN 'Bachelor of Computer Science'
WHEN degree = 'LLB' THEN 'Bachelor of Laws'
WHEN degree = 'BBA' THEN 'Bachelor of Business Administration' 
WHEN degree = 'B.Pharm' THEN 'Bachelor of Pharmacy' 
END as degree_full_form FROM employee;

-- What if I want to make it a permanent column?

UPDATE employee 
SET degree = CASE degree 
WHEN 'BCS' THEN 'Bachelor of Computer Science' 
WHEN 'LLB' THEN 'Bachelor of Laws'
WHEN 'BBA' THEN 'Bachelor of Business Administration'
WHEN 'B.Pharm' THEN 'Bachelor of Pharmacy'
END;