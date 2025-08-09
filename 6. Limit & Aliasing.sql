-- Limit : show specified number of people based on the criteria below
select *
from employee_demographics
order by age desc
limit 4
;
select *
from employee_demographics
order by age desc
limit 2, 1 # start at position 2 then look at the next row
;

-- Aliasing : changes the name of a column
select gender, avg(age) avg_age
from employee_demographics
group by gender
having avg_age > 40
;