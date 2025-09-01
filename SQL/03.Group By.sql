-- GROUP BY
select *
from employee_demographics;

select gender #select and group by have to match if we are not perfroming an aggregate function
from employee_demographics
group by gender
;

select gender, avg(age) #this will return the avg ages fro the genders grouped e.g male-41.3
from employee_demographics
group by gender
;

select gender, avg(age), max(age), min(age), count(age)
from employee_demographics
group by gender
;

-- ORDERY BY
select *
from employee_demographics
order by first_name desc #descending
;
select *
from employee_demographics
order by gender, age desc #order by gender first then age is in descending order
;
select *
from employee_demographics
order by 5, 4 #using positions of the field PS: NOT RECOMMENDED
;
