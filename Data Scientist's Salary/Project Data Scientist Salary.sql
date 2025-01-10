-- Find total salary of every 'Experience Level' employee
SELECT experience_level, SUM(salary) as 'Total'  
FROM customer.ds_salaries
GROUP BY experience_level;


-- Average Salary of 'Employement Type'
SELECT employment_type, SUM(salary) as 'Total'  
FROM customer.ds_salaries
GROUP BY employment_type;



-- Maximum salary of every Experience Level
SELECT experience_level, MAX(salary) as "Maximum Salary"
from customer.ds_salaries group by experience_level;



-- Maximum salary of every Employment Type
select employment_type, MAX(salary) as "Maximum Salary" 
from customer.ds_salaries group by employment_type;



-- Top 10 Maximum salary of Every Job Title
select job_title, MAX(salary) from customer.ds_salaries 
group by job_title order by MAX(salary) desc limit 10;


-- Filtering
SELECT job_title, salary from customer.ds_salaries 
where job_title IN ('Data Scientist', 'ML Engineer');


-- Find some specific data about company size 'S' or 'Small'
SELECT experience_level, employment_type, job_title, salary 
from customer.ds_salaries where company_size = 'S';



-- Average salary by company size
SELECT company_size, avg(salary) as 'Average Salary' 
from customer.ds_salaries group by(company_size);



-- Find the job_title where average salary is greater than 500000
select job_title, avg(salary) from customer.ds_salaries group by(job_title) having avg(salary) > 500000;
