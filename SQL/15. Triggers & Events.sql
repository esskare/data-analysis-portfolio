--  Triggers & Events
-- trigger is an block of code that takes place automatically when event takes place

select *
from employee_demographics;

select *
from employee_salary;

delimiter $$
create trigger employee_insert #creating trigger
	after insert on employee_salary #after a row is inserted...
    for each row 
begin
	insert into employee_demographics(employee_id, first_name, last_name)
    values (new.employee_id, new.first_name, new.last_name ) ;#taking new rows that wereinsterted 
end $$
delimiter ;

insert into employee_salary (employee_id, first_name, last_name,occupation,salary, dept_id)
values(13, 'Kare', 'EssMcMahon','Data Analyst', 1500000, null)
;
    
-- EVENTS;SCHEDULED AUTOMATOR
select *
from employee_demographics;

delimiter $$
create event delete_retirees
on schedule every 30 second
do
begin
	delete
	from employee_demographics
    where age >=60
    ;
end $$
delimiter ;

show variables like 'event%';


