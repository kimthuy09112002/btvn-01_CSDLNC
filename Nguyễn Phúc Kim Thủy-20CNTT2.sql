CREATE DATABASE BTVN
--GO
USE BTVN
--GO
CREATE TABLE Employees (
 employeeNumber INT PRIMARY KEY ,
 lastname NVARCHAR(40) ,
 firstname NVARCHAR(100),
 extention NVARCHAR(100) ,
 email NVARCHAR(100),
 officeCode INT,
 reportsTo INT,
 jobTitle NVARCHAR(100)
 
);
INSERT INTO Employees VALUES
(1002 , 'Muphy', 'Diane' ,'x5800', 'dmuply@classicmodelcars.com', 1,null,'President'),
(1056,'Patterson',N'Mary','x4611','mpatterso@classicmodelcars.com',1,1002,'VP Sales'),
(1076,' Firrelli', 'Jeff', 'x9273', 'ffirrelli@classicmodelcars.com'  , 1, 1002, 'VP Marketing'),
(1088, 'Patterson', 'William', 'x4871', 'wpatterson@classicmodelcars.com' , 6, 1056, 'Sales Manager (APAC)'),
(1102, 'Bondur', 'Gerard'    , 'x5408', 'gbondur@classicmodelcars.com'    , 4, 1056, 'Sale Manager (EMEA)'),
(1143, 'Bow', 'Anthony'      , 'x5428', 'abow @classicmodelcars.com'      , 1, 1056, 'Sales Manager (NA)'),
(1165, 'Jennings', 'Leslie'  , 'x3291', 'iennings@classicmodelcars.com'   , 1, 1143, 'Sales Rep'),
(1166, 'Thompson', 'Leslie'  , 'x4065', 'Ithompson@classicmodelcars.com'  , 1, 1143, 'Sales Rep'),
(1188, 'Firrelii', 'Julie'   , 'x2173', 'ffirrelli@classicmodelcars.com'  , 2, 1143, 'Sales Rep'),
(1216, 'Patterson', 'Steve'  , 'x4334', 'spatterson@classicmodelcars.com' , 2, 1143, 'Sales Rep'),
(1286, 'Tseng Foon', 'Yue'   , 'x2248', 'ftseng@classicmodelcars.com'     , 3, 1143, 'Sales Rep'),
(1323, 'Vanauf', 'George'    , 'x4102', 'gvanauf@classicmodelcars.com'    , 3, 1143, 'Sales Rep'),
(1337, 'Bondur', 'Loui'      , 'x6493', 'Ibondur@classicmodelcars.com'    , 4, 1102, 'Sales Rep'),
(1370, 'Hemandez', 'Gerard'  , 'x2028', 'ghemande@classicmodelcars.com'   , 4, 1102, 'Sales Rep'),
(1401, 'Castillo', 'Pamela'  , 'x2759', 'pcastillo@classicmodelcars.com'  , 4, 1102, 'Sales Rep');

--A) Using the SQL SELECT statement to retrieve data from a single
--column example
SELECT lastName FROM Employees;

--B) Using the SQL SELECT statement to query data from multiple
--columns example
SELECT
 lastName,
 firstName,
 jobTitle FROM
 Employees;

--C) Using the SQL SELECT statement to retrieve data from all
--columns example
SELECT employeeNumber,
email,
officeCode,
reportsTo,
jobTitle FROM Employees;
-------
SELECT * FROM Employees;

--SQL INSERT examples
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='tasks' and xtype='U')
    CREATE TABLE tasks (
         task_id INT IDENTITY(1,1),
		 title VARCHAR(255) NOT NULL,
		 start_date DATE,
		 due_date DATE,
		 priority TINYINT NOT NULL DEFAULT 3,
		 description TEXT,
		 PRIMARY KEY (task_id)
    )
GO

SELECT * FROM tasks
--1) SQL INSERT – simple INSERT example
INSERT INTO tasks(title,priority)VALUES('Learn SQL INSERT Statement',1);

--
SELECT * FROM task;

--2) SQL INSERT – Inserting rows using default value example
INSERT INTO tasks(title,priority)VALUES('Understanding DEFAULT keyword in INSERT statement',DEFAULT);

--
SELECT * FROM tasks;

--3) SQL INSERT – Inserting dates into the table example
INSERT INTO tasks(title, start_date, due_date)VALUES('Insert date into table','2018-01-09','2018-09-15');
INSERT INTO tasks(title,start_date,due_date)VALUES('Use current date for the task',GETDATE(),GETDATE());

--4) SQL INSERT – Inserting multiple rows example
INSERT INTO tasks(title, priority)VALUES
('My first task', 1),
('It is the second task',2),
('This is the third task of the week',3);
--
SELECT * FROM tasks;

--SQL UPDATE examples
--1) Using SQL UPDATE to modify values in a single column example
SELECT
 firstname,
 lastname,
 email FROM
 Employees WHERE
 employeeNumber = 1056;
--
UPDATE Employees SET
 email = 'mary.patterson@classicmodelcars.com' WHERE
 employeeNumber = 1056;
--
SELECT
 firstname,
 lastname,
 email FROM
 Employees WHERE
 employeeNumber = 1056;

 --2) Using SQL UPDATE to modify values in multiple columns
 UPDATE employees SET
 lastname = 'Hill',
 email = 'mary.hill@classicmodelcars.com'WHERE
 employeeNumber = 1056;
--
SELECT
 firstname,
 lastname,
 email FROM
 employees WHERE
 employeeNumber = 1056;

--3) Using SQL UPDATE to replace string example
UPDATE employees SET email = REPLACE(email,'@classicmodelcars.com','@mysqltutorial.org') WHERE jobTitle = 'Sales Rep' AND officeCode = 1;

--4) Using SQL UPDATE to update rows returned by a SELECT statement
--example

SELECT
 lastname,
 firstname, reportsTo FROM
 employees WHERE
 reportsTo IS NULL;

 --Chọn 1 mã nhân viên ngẫu nhiên trong số các nhân viên có công việc là Sales Rep
 SELECT
 employeeNumber FROM
 employees WHERE
 jobtitle = 'Sales Rep' 
 ORDER BY NEWID()
 OFFSET 0 ROWS
 FETCH NEXT 1 ROWS ONLY;
 -- Cập nhật nhân viên có điều kiện reportTo là null thành reportTo của ngẫu nhiên 1 trong những nhân viên có công
 --việc là Sales Rep
 UPDATE Employees SET
 reportsTo = (SELECT
reportsTo
FROM
employees
WHERE
jobtitle = 'Sales Rep'
ORDER BY NEWID()
 OFFSET 0 ROWS
 FETCH NEXT 1 ROWS ONLY) 
 WHERE reportsTo IS NULL;

--
--Chọn mã nhân viên có điều kiện reportsTo là Null

SELECT
employeeNumber FROM
 Employees WHERE
 reportsTo IS NULL;

--
--Xóa nhân viên có officeCode là 6
DELETE FROM employees WHERE officeCode = 6;

--
DELETE FROM employees;

--SQL DELETE and LIMIT clause
--Xóa 4 nhân viên đầu tiên sau khi sắp xếp theo tên.

DELETE FROM Employees 
WHERE firstname IN 
(
	SELECT TOP(4) firstname FROM Employees ORDER BY firstname
);

--Xóa 4 nhân viên đầu tiên có công việc là 'Sales Rep' sau khi sắp xếp theo extension

DELETE FROM Employees 
WHERE extention IN
(
	SELECT TOP(4) extention FROM Employees WHERE jobTitle = 'Sales Rep' ORDER BY extention
)

























