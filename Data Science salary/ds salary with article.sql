-- 1. How many job title was included in the dataset?
select count(distinct job_title) from ds_salaries;

-- 2. Which experience level has the highest salary?
select experience_level, max(salary_in_usd) as highest_salary from ds_salaries 
group by experience_level order by highest_salary desc;

-- 3. Does the employment type affect salary?
select case 
when employment_type = 'FT' then 'Full Time'
when employment_type = 'PT' then 'Part Time'
when employment_type = 'FL' then 'Freelance'
when employment_type = 'CT' then 'Contract'
else null end as employment_category, 
round(min(salary_in_usd), 2) as Min_salary,
round(max(salary_in_usd), 2) as Max_salary 
from ds_salaries group by case 
when employment_type = 'FT' then 'Full Time'
when employment_type = 'PT' then 'Part Time'
when employment_type = 'FL' then 'Freelance'
when employment_type = 'CT' then 'Contract'
else null end;

-- 4. What is the average salary per job title in USD?
select job_title, round(avg(salary_in_usd), 0) as average_salary from ds_salaries group by job_title order by average_salary desc;

-- 5. What is the highest salary per job title in USD?
select distinct job_title, round(max(salary_in_usd), 0) as max_salary from ds_salaries group by job_title order by max_salary desc;

-- 6. What is the highest paying entry-level data science job?
select job_title as entry_level, max(salary_in_usd) as max_salary from ds_salaries where experience_level='EN' 
group by entry_level order by max_salary desc;

-- 7. What is the highest paying mid-level data science job?
-- 8. What is the highest paying senior-level data science job?
-- 9. What is the highest paying Executive level data science job?

-- 10. What is the average salary per experience level?
select experience_level, round(avg(salary_in_usd)) as average_salary from ds_salaries 
group by experience_level order by average_salary desc;

select case 
when experience_level = 'EN' then 'Entry Level' 
when experience_level = 'MI' then 'Mid Level' 
when experience_level = 'SE' then 'Senior Level' 
when experience_level = 'EX' then 'Executive Level' 
else null end as experience_category, 
round(avg(salary_in_usd), 2) as average_salary 
from ds_salaries 
group by case  
when experience_level = 'EN' then 'Entry Level' 
when experience_level = 'MI' then 'Mid Level' 
when experience_level = 'SE' then 'Senior Level' 
when experience_level = 'EX' then 'Executive Level' else null end  
order by average_salary desc;

-- 11. What is the lowest paying entry-level data science job?
-- 12. What is the lowest paying Mid-level Data Science Job?
-- 13. What is the lowest paying Senior level data science job?
-- 14. What is the lowest paying Executive level data science job?
select job_title, min(salary_in_usd) as lowest_salary 
from ds_salaries where experience_level='EX' group by job_title 
order by lowest_salary desc;

-- 15. Does company size affect salary?
SELECT CASE 
WHEN company_size = 'L' THEN 'Large Company' 
WHEN company_size = 'M' THEN 'Medium Company'
WHEN company_size = 'S' THEN 'Small Company' 
ELSE NULL END AS Companies_size, 
ROUND(MIN(salary_in_usd), 2) AS min_salary,
ROUND(MAX(salary_in_usd), 2) AS max_salary 
FROM ds_salaries 
GROUP BY CASE WHEN company_size='L' THEN 'Large Company' 
WHEN company_size = 'M' THEN 'Medium Company'
WHEN company_size = 'S' THEN 'Small Company' 
ELSE NULL END;

-- 16. Does company location affect Salary?
SELECT CASE 
WHEN company_location = 'US' THEN 'In the US'
ELSE 'Not in US' END AS company_loc_category,
ROUND(MIN(salary_in_usd), 2) AS min_salary,
ROUND(MAX(salary_in_usd), 2) AS max_salary
FROM ds_salaries
GROUP BY CASE WHEN company_location = 'US' THEN 'In the US' 
ELSE 'Not in US' END;
