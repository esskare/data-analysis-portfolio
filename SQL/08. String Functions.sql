-- String Function
-- length
select length('skyfall'); #displays the number of characters in a name

select first_name, length(first_name)
from employee_demographics
order by 2 #sorted by columns
;
-- uppercase and lowercase
select upper('sky');
select lower('sky');
select first_name, upper(first_name)
from employee_demographics
;
-- trim: gets rid of white space
select trim('         sky            ');
select ltrim('            sky      ');
select rtrim('              sky      ');

-- sub string
select first_name, 
left(first_name, 3),
right(first_name, 3),
substring(first_name, 3, 2), #start at 3rd position and take the next 2 ch
birth_date,
substring(birth_date, 6, 2) as birth_month
from employee_demographics;

-- replace ; case sensitive
select first_name, replace(first_name, 'a', 'z') #replace a ch with z ch in first name column
from employee_demographics;

-- locate; locates the index of the character
select locate('s','Esther');

select first_name, locate('a', first_name)
from employee_demographics;

-- concatenation combines 2 columns into a single one
select first_name, last_name,
concat(first_name, '  ', last_name) as full_name
from employee_demographics;








