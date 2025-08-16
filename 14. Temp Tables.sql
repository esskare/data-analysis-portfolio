-- Temporary Tables: are only visible to the session they are created in

create temporary table temp_table
(firstname varchar(50),
lastname varchar(50),
favmovie varchar(100)

);
select *
from temp_table;

-- insert values in the table
insert into temp_table
values('Esther','Kare','God of War');

select *
from temp_table;
select *
from employee_salary;

-- creating over an existing table
create temporary table salary_over_50k
select *
from employee_salary
where salary >= 50000;
select *
from salary_over_50k;
































































































