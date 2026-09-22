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

--6. Create a View showing Employee Name and Department Name.
CREATE VIEW vw_EmployeeDepartment
AS
SELECT A.EmployeeName,B.DepartmentName FROM Employees AS A
INNER JOIN Departments AS B
ON A.DepartmentID=B.DepartmentID;
SELECT * FROM vw_EmployeeDepartment;

--7. Create a View displaying Product Name and Supplier Name
CREATE VIEW vw_ProductSupplier
AS
SELECT A.ProductName,B.SupplierName FROM Products AS A
INNER JOIN Suppliers AS B
ON A.SupplierID=B.SupplierID;
SELECT * FROM vw_ProductSupplier;

--8.Create a View displaying Product Name and Category Name.
CREATE VIEW vw_ProductCategoryName
AS
SELECT A.ProductName,B.CategoryName FROM Products AS A
INNER JOIN Categories AS B
ON A.CategoryID=B.CategoryID;
SELECT * FROM vw_ProductCategoryName;

--9. Create a View displaying Store Name and Quantity available.
CREATE VIEW vw_StoreQuantity
AS
SELECT A.StoreName,B.Quantity FROM Stores AS A
INNER JOIN Inventory AS B
ON A.StoreID=B.StoreID;
SELECT * FROM vw_StoreQuantity;

--10. Create a View displaying Customer Name and Order Date.
CREATE VIEW vw_CustomerOrder
AS
SELECT A.CustomerName,B.OrderDate FROM Customers AS A
INNER JOIN Orders AS B
ON A.CustomerID=B.CustomerID;
SELECT * FROM vw_CustomerOrder;

--Intermediate Questions
--11. Create a View showing total Salary paid by every department.
CREATE VIEW vw_SalaryDepartment
AS
SELECT A.DepartmentName,SUM(B.Salary) AS TotalSalary FROM Departments AS A
INNER JOIN Employees AS B
ON A.DepartmentID=B.DepartmentID
GROUP BY A.DepartmentName;
SELECT * FROM vw_SalaryDepartment;

--12. Create a View showing total orders placed by each customer.
CREATE VIEW vw_OrderCustomer
AS
SELECT B.CustomerName, COUNT(A.OrderID) AS TotalOrders FROM Orders AS A
INNER JOIN Customers AS B
ON A.CustomerID=B.CustomerID
GROUP BY B.CustomerName;
SELECT * FROM vw_OrderCustomer;

--13. Create a View showing average product price by category.
CREATE VIEW vw_AverageCategory
AS
SELECT B.CategoryName,AVG(A.UnitPrice) AS AveragePrice FROM Products AS A
INNER JOIN Categories AS B
ON A.CategoryID=B.CategoryID
GROUP BY B.CategoryName;
SELECT * FROM vw_AverageCategory;

--14. Create a View showing total inventory available in each store.
CREATE VIEW vw_InventoryStore
AS
SELECT B.StoreName,COUNT(A.InventoryID) AS TotalInventory FROM Inventory AS A
INNER JOIN Stores AS B
ON A.StoreID=B.StoreID
GROUP BY B.StoreName;
SELECT * FROM vw_InventoryStore;

--15.Create a View showing payment received through each payment mode.
CREATE VIEW vw_PaymentMode
AS
SELECT A.PaymentMode,SUM(A.Amount) AS TotalAmount FROM Payments AS A
GROUP BY A.PaymentMode;
SELECT * FROM vw_PaymentMode;
