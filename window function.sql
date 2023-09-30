# total points based on job title
SELECT job_title, SUM(points) AS total_points FROM salary GROUP BY job_title ORDER BY total_points DESC;

-- ROW_NUMBER() ranking functions provides a sequential ranking of the given partition. 
-- If two rows have the same information,the function makes a determination of which gets
-- ranked first based on the information provided in the OVER() statement. No Duplicates or Skipped numbers.

SELECT names, points, ROW_NUMBER() OVER(ORDER BY points DESC) AS row_num FROM salary;
SELECT names, points, ROW_NUMBER() OVER(PARTITION BY job_title) AS ranks FROM salary;

-- Provides similar results as the ROW_NUMBER() function but in the RANK() function if two rows have the same information, 
-- then it gives the same value and the follow on values are skipped. RANK() function gives non-sequential number and duplicate values.
SELECT names, job_title, points, RANK() OVER(PARTITION BY job_title ORDER BY points DESC) AS ranks FROM salary;

-- DENSE_RANK() works like hybrid between ROW_NUMBER() and RANK() function. Also if it ties, it will give you sequential number.
SELECT *, DENSE_RANK() OVER(PARTITION BY job_title ORDER BY points DESC) AS ranks FROM salary;

