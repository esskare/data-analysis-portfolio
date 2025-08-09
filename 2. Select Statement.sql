SELECT * -- * means get everything
FROM parks_and_recreation.employee_demographics; -- from db.table &; mean end of this query

SELECT first_name,
last_name, 
birth_date, -- * select from the following columns
age,
(age + 10) *10  #calculation
FROM parks_and_recreation.employee_demographics; -- from db.table &; mean end of this query
# PEMDAS paranthesis, exponention, mult, add, sub


SELECT distinct gender, first_name #distinct only highlights unique data
FROM parks_and_recreation.employee_demographics;