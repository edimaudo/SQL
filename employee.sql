--postgressql

Create table employees(
firstname varchar(20),
lastname varchar(20), 
title varchar(20) , 
age int, 
salary int 
);

Insert into employees(firstname, lastname, title, age, salary)
values
('Jonie', 'Weber', 'Secretary', '28', '19500'),
('Potsy', 'Weber', 'Programmer', '32', '45300'),
('Dirk', 'Smith', 'Programmer II', '45', '75020');


--Modify the columns firstname to fname and lastname to lname
ALTER table employees RENAME firstname TO fname;
ALTER table employees RENAME lastname TO lname;

--Add a new column name it commission
ALTER TABLE employees ADD COLUMN commission int;

--Add a new column name it EmployeeID
ALTER TABLE employees ADD COLUMN employeeID int;

--Remove the column age
ALTER TABLE employees DROP COLUMN age RESTRICT;

--Rename the table Employees to newEmployees
ALTER TABLE employees RENAME TO newEmployees;