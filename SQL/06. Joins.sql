-- Joins: joins 2 tables that have a similar column; columns don't have to necessarily match names just have similar data

select *
from employee_demographics;

select *
from employee_salary; 

-- Innner join returns rows that are samein both columns from both tables
select *
from employee_demographics
inner join employee_salary
#join the 2 tables based on the employee_id; specifie from what tables  
	on employee_demographics.employee_id = employee_salary.employee_id
;
-- using aliases
select *
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id
;

-- pulling from different columns
select dem.employee_id, age, occupation
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id
;

-- Outer Joins (left and right)
-- left takes everything from the left table and only return thematches from the right table and vice cersa
select *
from employee_demographics as dem
left join employee_salary as sal
	on dem.employee_id = sal.employee_id
;
-- if it doesn't match it will populate with null like below
select *
from employee_demographics as dem
right join employee_salary as sal
	on dem.employee_id = sal.employee_id
;

-- self join: ties the table to itself
select emp1.employee_id as emp_santa,
emp1.first_name as first_name_santa,
emp1.last_name as last_name_santa,
emp2.employee_id as emp_name,
emp2.first_name as first_name_emp,
emp2.last_name as last_name_emp
from employee_salary emp1
join employee_salary emp2
#specify which table to pull from
	on emp1.employee_id + 1 = emp2.employee_id
;

-- joining multiple tables together

select *
from employee_demographics as dem
inner join employee_salary as sal
	on dem.first_name = sal.first_name
inner join parks_departments pd
	on sal.dept_id = pd.department_id
;
-- reference table
select *
from parks_departments;







