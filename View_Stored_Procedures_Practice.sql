USE RetailBusinessDB2;



-- Views
-- A Views is a virtual table whose contents are generated from one or more underlying tables using a SELECT statement. 
-- Unlike a physical table, a View does not normally store data. Whenever a View is queried. SQL Server executes the stored SELECT statement and returns the latest data.

--Advantages of Views
--Simplify complex queries
--Hide unnecessary columns
--Improve database security
--Reuse frequently executed queries
--Make reporting easier
--Reduce duplicate SQL code
--Provide logical abstraction over physical tables

--Syntax
--CREATE VIEW ViewName
--AS
--SELECT...
--FROM TableName;

--Beginner Questions
--1. Create a View that display all employee information.

CREATE VIEW vw_AllEmployees
AS
SELECT * FROM Employees AS A;
SELECT * FROM vw_AllEmployees;
GO

--2. Create a View that displays only EmployeeID, EmployeeName, and Salary.
CREATE VIEW vw_EmployeeSalary
AS
SELECT A.EmployeeID,A.EmployeeName,A.Salary FROM Employees AS A
GO
SELECT * FROM vw_EmployeeSalary;

--3. Create a View showing all products costing more than 5000;
CREATE VIEW vw_ExpensiveProdcuts
AS
SELECT A.OrderID,A.ProductID,A.UnitPrice FROM OrderDetails AS A
WHERE A.UnitPrice>5000;
GO
SELECT * FROM vw_ExpensiveProdcuts;

--4.Create a View that lists cusotmer names along with their cities.
CREATE VIEW vw_CustomerCity
AS
SELECT A.CustomerName,A.City FROM Customers AS A
SELECT * FROM vw_CustomerCity;

--5.Create a View showing products names and category IDs.
CREATE VIEW vw_ProductCategory
AS
SELECT A.ProductName,A.CategoryID FROM Products AS A;
SELECT * FROM vw_ProductCategory;