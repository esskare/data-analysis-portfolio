-- Having vs where
-- the function below is an error because we are trying to filter a function that hasn't been created yet
select gender, avg(age) 
from employee_demographics
where avg(age) >40
group by gender
;
-- this is corre t since the function comes after group by
select gender, avg(age) 
from employee_demographics
group by gender
having avg(age) >40
;
-- now what about both
select occupation, avg(salary)
from employee_salary
where occupation like '%manager%' # filtered at the row
group by occupation
having avg(salary) > 75000 # filtered at the agg function
;