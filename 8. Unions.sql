-- Unions: combine rows together from separate or same tables
# take one select statement and use union to combine with another select 

select first_name, last_name
from employee_demographics
union #by default this is unions DISTINCT; duplicates will be joined if we use ALL, it will show everything plus the duplicates
select first_name, last_name
from employee_salary
;

select first_name, last_name, 'Old Man' as Label
from employee_demographics
where age > 40 and gender = 'Male'
union
select first_name, last_name, 'Old Lady' as Label
from employee_demographics
where age > 40 and gender = 'Female' 
union
select first_name, last_name, 'Highly Paid Employee' as Label
from employee_salary
where salary > 70000
order by first_name, last_name
;



















