-- WHERE CLAUSE and OPERATORS
-- comparison operators
select *
from employee_salary
where first_name = 'Leslie' #looking into Leslie's data
;

select *
from employee_salary
where salary >= 50000 # employees with a >= sal of 50000
;

select *
from employee_demographics
where gender != 'Female'
;

select *
from employee_demographics
where birth_date > '1985-01-01' #employees born after this date
;

-- LOGICAL OPERATORS (AND, OR, NOT)
select *
from employee_demographics
where birth_date > '1985-01-01' #employees born after this date
and gender = 'female'  #both statements have to be true
;
select *
from employee_demographics
where birth_date > '1985-01-01' #employees born after this date
or gender = 'male'  #either statements have to be true
;

select *
from employee_demographics
where birth_date > '1985-01-01' #employees born after this date
or not gender = 'male'  #either statements have to be true
;

select *
from employee_demographics
where (first_name = 'Leslie' and age = 44) or age > 55 #isolated conditional statement and output the other conditional statement
;

-- LIKE STATEMENTS
-- %(anything) _(specific)
select *
from employee_demographics
WHERE first_name like '%a%' #as long as it has a in the name anything else that comes from it should be returned
;

select *
from employee_demographics
WHERE first_name like 'a__%' #specifies the characters of the name if you add % it can have the no of ch and anything after it
;

select *
from employee_demographics
WHERE birth_date like '1989%' 
;