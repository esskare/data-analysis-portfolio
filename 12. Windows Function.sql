-- Window Function: looking at partition

select dem.first_name, dem.last_name, gender, avg(salary) as avg_sal #rolled the average salary for the unique rows M AND F
from employee_demographics dem 
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by dem.first_name, dem.last_name, gender;

select dem.first_name, dem.last_name, gender, avg(salary) over(partition by gender) # avergae salary on individual rows for everybody
from employee_demographics dem 
join employee_salary sal
	on dem.employee_id = sal.employee_id
;

-- sum by gender
select dem.first_name, dem.last_name, gender,
 sum(salary) over(partition by gender) 
from employee_demographics dem 
join employee_salary sal
	on dem.employee_id = sal.employee_id
;
-- start at a specific value and add subsequent values
select dem.first_name, dem.last_name, gender, salary,
 sum(salary) over(partition by gender order by dem.employee_id) as rolling_total
from employee_demographics dem 
join employee_salary sal
	on dem.employee_id = sal.employee_id
;

select dem.employee_id, dem.first_name, dem.last_name, gender, salary,
row_number() over(partition by gender order by salary desc) as row_num,
rank() over(partition by gender order by salary desc) as rank_num,
dense_rank() over(partition by gender order by salary desc) as dense_rank_num
from employee_demographics dem 
join employee_salary sal
	on dem.employee_id = sal.employee_id
;



