-- Stored Procedures ; save your sql code to simplify repetitive code and store complex queries
select *
from employee_salary
where salary >= 50000;

-- creating the procedure

create procedure large_salaries()
select *
from employee_salary
where salary >= 50000;	
-- calling it
call large_salaries();
-- putting these queries in the same procedure

-- we've changed it to $$ so that ; doesn't get read as the final marker
DELIMITER $$ #acts as a marker, indicating the boundaries between different data elements or fields

CREATE PROCEDURE large_salaries3()
BEGIN
    SELECT *
    FROM employee_salary
    WHERE salary >= 50000;

    SELECT *
    FROM employee_salary
    WHERE salary >= 10000;
END $$

DELIMITER ;  #then change it back to ;

call large_salaries3()

-- PARAMETER
DELIMITER $$ 
CREATE PROCEDURE large_salaries4(employee_id_param int) #pass thru an integer
BEGIN
    SELECT salary
    FROM employee_salary
    where employee_id = employee_id_param
    ;
END $$
DELIMITER ;  
call large_salaries4(1)



















































































































