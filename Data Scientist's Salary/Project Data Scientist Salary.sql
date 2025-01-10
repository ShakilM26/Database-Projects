-- 1. How many job title was included in the dataset?
select count(distinct job_title) from ds_salaries;

-- 2. Which experience level has the highest salary?
select experience_level, max(salary_in_usd) as highest_salary from ds_salaries 
group by experience_level order by highest_salary desc;


-- 3. Find total salary of every 'Experience Level' employee
SELECT experience_level, SUM(salary) as 'Total'  
FROM customer.ds_salaries
GROUP BY experience_level;


-- 4. Average Salary of 'Employement Type'
SELECT employment_type, SUM(salary) as 'Total'  
FROM customer.ds_salaries
GROUP BY employment_type;



-- 5. Maximum salary of every Experience Level
SELECT experience_level, MAX(salary) as "Maximum Salary"
from customer.ds_salaries group by experience_level;


-- 6. Maximum salary of every Employment Type
select employment_type, MAX(salary) as "Maximum Salary" 
from customer.ds_salaries group by employment_type;



-- 7. Top 10 Maximum salary of Every Job Title
select job_title, MAX(salary) from customer.ds_salaries 
group by job_title order by MAX(salary) desc limit 10;


-- 8. Filtering
SELECT job_title, salary from customer.ds_salaries 
where job_title IN ('Data Scientist', 'ML Engineer');


-- 9. Find some specific data about company size 'S' or 'Small'
SELECT experience_level, employment_type, job_title, salary 
from customer.ds_salaries where company_size = 'S';



-- 10. Average salary by company size
SELECT company_size, avg(salary) as 'Average Salary' 
from customer.ds_salaries group by(company_size);



-- 11. Find the job_title where average salary is greater than 500000
select job_title, avg(salary) from customer.ds_salaries group by(job_title) having avg(salary) > 500000;

-- 12. What is the highest paying entry-level data science job?
select job_title as entry_level, max(salary_in_usd) as max_salary from ds_salaries where experience_level='EN' 
group by entry_level order by max_salary desc;

-- 13. What is the average salary per experience level?
select experience_level, round(avg(salary_in_usd)) as average_salary from ds_salaries 
group by experience_level order by average_salary desc;
