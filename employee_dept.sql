#create employee table
Create table EMPLOYEE (
empid int,
empname VARCHAR(50),
mangerid int,
deptid int,
salary FLOAT,
DOB date
);

#create department table
Create table DEPARTMENT(
deptid int,
deptname varchar(10)
);

#load employee table
insert into employee(empid,empname,mangerid,deptid,salary,DOB)
values
('1','emp 1','0','1','6000','1982-08-06'),
('2','emp 2','0','5','6000', '1982-07-11'), 
('13','emp 13','2','5','2000','1984-03-09'), 
('9','emp 9','1','5','3000','1990-09-11'), 
('8','emp 8','3','1','3500','1990-05-15'),
('7','emp 7','2','5',NULL,NULL),  
('3','emp 3','1','1','2000','1983-11-21');

#load department table
insert into department(deptid, deptname)
values
("1","IT"),("2","Admin");

#answer business questions
#Can you get employee details whose department id is not valid or department id not present in department table?

select 
from employee e i

#Can you get the list of employees with same salary?

#How can you find duplicate records in Employee table?

#Find the second highest salary. 

#Can you write a query to find employees with age greater than 30?

#Write an SQL Query to print the name of the distinct employees whose DOB is between 01/01/1960 to 31/12/1987

#Please write a query to get the maximum salary from each department. 
select max(e.salary) as max_salary, deptid
from employee e
group by deptid;