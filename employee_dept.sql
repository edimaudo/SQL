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
