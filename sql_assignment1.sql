CREATE TABLE employees(
ID int auto_increment PRIMARY KEY,
last_name varchar(50),
first_name varchar(50),
age int,
job_title varchar(100),
date_of_birth date,
phone_number int,
insurance_id varchar(15)
);
ALTER table employees modify column phone_number varchar(10);
insert into employees values(01, 'Smith', 'John', 32, 'Manager', '1989-05-12', '5551234567', 'INS736');
insert into employees values(02, 'Johnson', 'Sarah', 28, 'Analyst', '1993-09-20', '5559876543', 'INS832');
insert into employees values(03, 'Davis' ,'David' ,45, 'HR', '1976-02-03', '5550555995','INS007');
insert into employees values(04, 'Brown','Emily' ,37 , 'Lawyer', '1984-11-15' ,'5551112022', 'INS035');
insert into employees values(05,'Wilson','Michael',41, 'Accountant' ,'1980-07-28' ,'5554403003','INS943');
insert into employees values(06,'Anderson' , 'Lisa', 22 ,'Intern','1999-03-10' ,'5556667777','INS332' );
insert into employees values(07 ,'Thompson','Alex',29,'Sales Representative','2011-05-21','5558889999','INS433');
select * from employees;


-- Explore unique job titles:
select distinct job_title from employees order by job_title;
-- Top 3 youngest employees:
select * from employees order by age asc limit 3;

-- Update date of birth for Alex Thompson as it is 1992-06-24
set sql_safe_updates = 0;
update employees set date_of_birth = '1992-06-24' where date_of_birth = '2011-05-21';

-- Delete the data of employees with age greater than 30
delete from employees where age > 30;
select * from employees;

-- Concatenating First name and Last name:
select concat(First_name, " " ,Last_name) from employees;

/*-- Create a table called employee_insurance with the following columns and datatypes:

insurance_id VARCHAR of size 15
insurance_info VARCHAR of size 100

Make insurance_id the primary key of this table
							
*/
create table employee_insurance(
insurance_id varchar(15) primary key,
insurance_info varchar(100)
);
/*
Insert the following values into employee_insurance:

"INS736", "unavailable"
"INS832", "unavailable"
"INS007", "unavailable"
"INS035", "unavailable"
"INS943", "unavailable"
"INS332", "unavailable"
"INS433", "unavailable"

*/
insert into employee_insurance values("INS736", "unavailable");
insert into employee_insurance values("INS832", "unavailable");
insert into employee_insurance values("INS007", "unavailable");
insert into employee_insurance values("INS035", "unavailable");
insert into employee_insurance values("INS943", "unavailable");
insert into employee_insurance values("INS332", "unavailable");
insert into employee_insurance values("INS433", "unavailable");
select * from employee_insurance;
-- Add a column called email to the employees table. Remember to set an appropriate datatype
Alter table employee_insurance add column email varchar(15);
select * from employee_insurance;

-- Add the value "unavailable" for all records in email in a SINGLE query
update employee_insurance set email = " unavailable";
select * from employee_insurance;
