CREATE DATABASE RetailBusinessDB;

USE RetailBusinessDB;

--Create Table
--Departments
CREATE TABLE Departments
(
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(50),
Location VARCHAR(50)
);

--Employees
CREATE TABLE Employees
(
EmployeeID INT PRIMARY KEY,
EmployeeName VARCHAR(100),
DepartmentID INT,
ManagerID INT NULL,
Salary DECIMAL(10,2),
HireDate DATE,

FOREIGN KEY (DepartmentID)
REFERENCES Departments(DepartmentID)
);

--Customers
CREATE TABLE Customers
(
CustomerID INT PRIMARY KEY,
CustomerName VARCHAR(100),
City VARCHAR(50),
Phone VARCHAR(20)
);

--Categories
CREATE TABLE Categories
(
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR(50)
);

--Suppliers
CREATE TABLE Suppliers
(
SUpplierID INT PRIMARY KEY,
SupplierName VARCHAR(100),
City VARCHAR(50)
);

--Products
CREATE TABLE Products
(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(100),
CategoryID INT,
SupplierID INT,
Price DECIMAL(10,2),

FOREIGN KEY(CategoryID)
REFERENCES Categories(CategoryID),

FOREIGN KEY(SupplierID)
REFERENCES Suppliers(SupplierID)
);

--Orders
CREATE TABLE Orders
(
OrderID INT PRIMARY KEY,
CustomerID INT,
EmployeeID INT,
OrderDate DATE,

FOREIGN KEY(CustomerID)
REFERENCES Customers(CustomerID),

FOREIGN KEY(EmployeeID)
REFERENCES Employees(EmployeeID)
);

--OrderDetails
CREATE TABLE OrderDetails
(
OrderDetailID INT PRIMARY KEY,
OrderID INT,
ProductID INT,
Quantity INT,

FOREIGN KEY(OrderID)
REFERENCES Orders(OrderID),

FOREIGN KEY(ProductID)
REFERENCES Products(ProductID)
);

--Shipments
CREATE TABLE Shipments
(
ShipmentID INT PRIMARY KEY,
OrderID INT,
ShipmentDate DATE,
DeliveryStatus VARCHAR(30),

FOREIGN KEY(OrderID)
REFERENCES Orders(OrderID)
);

--Sample Data
--Departments
INSERT INTO Departments VALUES
(1,'Sales','Delhi'),
(2,'Finance','Mumbai'),
(3,'HR','Noida'),
(4,'IT','Pune'),
(5,'Logistics','Jaipur');

--Employees
INSERT INTO Employees VALUES
(101,'Rahul Sharma',1,NULL,60000,'2020-01-10'),
(102,'Priya Singh',1,101,45000,'2021-03-12'),
(103,'Amit Kumar',2,NULL,70000,'2019-08-15'),
(104,'Neha Verma',3,NULL,50000,'2022-01-20'),
(105,'Rohit Gupta',4,NULL,80000,'2018-06-25'),
(106,'Karan Mehta',5,NULL,55000,'2021-09-14');

--Customers
INSERT INTO Customers VALUES
(1,'ABC Stores','Delhi','9999991111'),
(2,'XYZ Mart','Mumbai','9999992222'),
(3,'Sun Retail','Noida','9999993333'),
(4,'Prime Traders','Lucknow','9999994444'),
(5,'Future Bazaar','Pune','9999995555'),
(6,'Elite Market','Jaipur','9999996666');

--Categories
INSERT INTO Categories VALUES
(1,'Electronics'),
(2,'Furniture'),
(3,'Stationery'),
(4,'Groceries');

--Suppliers
INSERT INTO Suppliers VALUES
(1,'Samsumg India', 'Noida'),
(2,'Godrej','Mumbai'),
(3,'Classmate','Chennai'),
(4,'ITC Foods','Kolkata');

--Products
INSERT INTO Products VALUES
(1,'Laptop',1,1,65000),
(2,'Printer',1,1,12000),
(3,'Office Chair',2,2,8000),
(4,'Notebook',3,3,60),
(5,'Rice Bag',4,4,1200),
(6,'Desk',2,2,15000);

--Orders
INSERT INTO Orders VALUES
(1001,1,101,'2024-01-15'),
(1002,2,102,'2024-01-18'),
(1003,3,101,'2024-02-01'),
(1004,4,103,'2024-02-05'),
(1005,5,102,'2024-02-08'),
(1006,6,106,'2024-02-15');

--OrderDetails
INSERT INTO OrderDetails VALUES
(1,1001,1,2),
(2,1001,4,20),
(3,1002,2,1),
(4,1002,5,10),
(5,1003,3,5),
(6,1004,1,1),
(7,1005,6,2),
(8,1006,5,15);

--Shipments
INSERT INTO Shipments VALUES
(1,1001,'2024-01-17','Delivered'),
(2,1002,'2024-01-20','Delivered'),
(3,1003,'2024-02-04','In Transit'),
(4,1005,'2024-02-11','Pending');



SELECT TOP 1 * FROM Customers;
SELECT TOP 1 * FROM Employees;
SELECT TOP 1 * FROM Departments;
SELECT TOP 1 * FROM Products;
SELECT TOP 1 * FROM Categories;
SELECT TOP 1 * FROM Orders;
SELECT TOP 1 * FROM OrderDetails;
SELECT TOP 1 * FROM Suppliers;
SELECT TOP 1 * FROM Shipments;

/*
A FULL OUTER JOIN returns all matching rows from both tables as well as all unmatched rows from both the left table and the right table.
If a matching row exists in both tables, SQL Server combines the data into a single row.
If a row exists only in the left table, the columns from the right table contain NULL values.
If a row exists only in the right table, the columns from the left table contain NULL values.
Therefor, a FULL OUTER JOIN combines thr results of a LEFT JOIN and a RIGHT JOIN into a single operation.
Syntax: SELECT column1, column2, ...
        FROM TableA
        FULL OUTER JOIN TableB
        ON TableA.CommonColumn = TableB.CommonColumn;
*/

--Beginner Questions
--1. Display all employees together with their departments, including employees who are not assigned to any department and departments that currently have no employees.
SELECT B.EmployeeID,B.EmployeeName,A.DepartmentID,A.DepartmentName FROM Departments AS A
FULL OUTER JOIN Employees AS B
ON A.DepartmentID=B.DepartmentID
ORDER BY A.DepartmentName,B.EmployeeName;

--2.Display all products together with their categories, including products that are not assigned to any category and categories that currently do not contain any products.
SELECT A.ProductID,A.ProductName,B.CategoryID,B.CategoryName FROM Products AS A
FULL OUTER JOIN Categories AS B
ON A.CategoryID=B.CategoryID
ORDER BY A.ProductName,B.CategoryName;

--3. Display all suppliers together with their products, including suppliers that do not supply any products and products that are not assigned to any supplier.
SELECT A.SUpplierID,A.SupplierName,B.ProductID,B.ProductName FROM Suppliers AS A
FULL OUTER JOIN Products AS B
ON A.SUpplierID=B.SupplierID
ORDER BY A.SupplierName,B.ProductName;

--4. Display all customers together with their orders , including customers who have not placed any order and orders that do not have a matching customer.
SELECT A.CustomerID,A.CustomerName,B.OrderID,B.OrderDate FROM Customers AS A
FULL OUTER JOIN Orders AS B
ON A.CustomerID=B.CustomerID
ORDER BY A.CustomerName,B.OrderDate;

--5. Display all orders together with their shipment details, including orders that have not yet been shipped and shipment records taht do not have a matching order.
SELECT A.OrderID,A.OrderDate,B.ShipmentID,B.ShipmentDate FROM Orders AS A
FULL OUTER JOIN Shipments AS B
ON A.OrderID=B.OrderID
ORDER BY A.OrderID,B.ShipmentID;

--6. Display all categories together with the total number of products in each category, including categories without products and products that are not assigned to any category.
SELECT A.CategoryName,COUNT(B.ProductID)FROM Categories AS A
FULL OUTER JOIN Products AS B
ON A.CategoryID=B.CategoryID
GROUP BY A.CategoryName
ORDER BY A.CategoryName;

--7. Display all suppliers together with the total number of products they supply, including suppliers who currently do not supply any products and products that are not assigned to any supplier.
SELECT ISNULL(A.SupplierName,'Unassigned Supplier') AS SupplierName,COUNT(B.ProductID) AS No_product FROM Suppliers AS A
FULL OUTER JOIN Products AS B
ON A.SUpplierID=B.SupplierID
GROUP BY A.SupplierName
ORDER BY A.SupplierName;

--8. Display all customers together with the total number of orders they ahve placed, including customers who have never placed an order and orders that do not have a matching customer.
SELECT ISNULL(A.CustomerName,'Unknown Customer') AS CustomerName
,COUNT(B.OrderID) AS No_Orders FROM Customers AS A
FULL OUTER JOIN Orders AS B
ON A.CustomerID=B.CustomerID
GROUP BY A.CustomerName
ORDER BY A.CustomerName;

--9. Display all employees together with their department and the total number of orders they have processed, including employees wihtout departments, departments with employees, and employees who have not processed any orders.
SELECT ISNULL(A.EmployeeName,'No Employee') AS EmployeeName,
ISNULL(B.DepartmentName, 'No Department') AS DepartmentName,
COUNT(C.OrderID) AS TotalOrders FROM Employees AS A
FULL OUTER JOIN Departments AS B
ON A.DepartmentID=B.DepartmentID
FULL OUTER JOIN Orders AS C
ON A.EmployeeID=C.EmployeeID
GROUP BY A.EmployeeName,B.DepartmentName
ORDER BY B.DepartmentName,A.EmployeeName;

--10. Display all products together with their category and supplier details, including products without categories, pruducts without suppliers, categories without products and suppliers without products.
SELECT ISNULL(A.ProductName,'No Product') AS ProductName,
ISNULL(B.CategoryName, 'No Category') AS CategoryName,
ISNULL(C.SupplierName, 'No Supplier') AS SupplierName FROM Products AS A
FULL OUTER JOIN Categories AS B
ON A.CategoryID=B.CategoryID
FULL OUTER JOIN Suppliers AS C
ON A.SupplierID=C.SUpplierID
order by A.ProductName,B.CategoryName,C.SupplierName;

--11. Generate a complete employee sales performance reprot showing every employee their department, the total number of orders they have processed, and the total sales amount.
-- The report must also include employees without departments, departments without employees,and employees who have not processed any orders.
SELECT ISNULL(A.EmployeeName,'No Employee') AS EmployeeName,
ISNULL(B.DepartmentName,'No Department') AS DepartmentName,
COUNT(DISTINCT C.OrderID) AS TotalCount, 
ISNULL(SUM(D.Quantity*E.Price),0)  AS TotalSalesAmount FROM Employees AS A
FULL OUTER JOIN Departments AS B
ON A.DepartmentID=B.DepartmentID
FULL OUTER JOIN Orders AS C
ON A.EmployeeID=C.EmployeeID
FULL OUTER JOIN OrderDetails AS D
ON C.OrderID=D.OrderID
FULL OUTER JOIN Products AS E
ON D.ProductID=E.ProductID
GROUP BY A.EmployeeName,B.DepartmentName
ORDER BY B.DepartmentName,A.EmployeeName;

--12.Generate a complete customer pruchase summary showing every customer, the total number of orders placed, the total purchase amount, and the average order value.
--The report must also include customers who have never placed an order and orders that donot have a matching customer.
SELECT ISNULL(A.CustomerName,'Unknown Customer') AS CustomerName,
COUNT(DISTINCT B.OrderID) AS TotalOrders,
ISNULL(SUM(D.Price*C.Quantity),0)  AS TotalPurchaseAmount,
ISNULL(AVG(B.OrderID),0) AS AverageOrderValue FROM Customers AS A
FULL OUTER JOIN Orders AS B
ON A.CustomerID=B.CustomerID
FULL OUTER JOIN OrderDetails AS C
ON B.OrderID=C.OrderID
FULL OUTER JOIN Products AS D
ON C.ProductID=D.ProductID
GROUP BY A.CustomerName
ORDER BY A.CustomerName;

--13. Generate a complete supplier inventory report showing every supplier., the total number of products supplied, the total inventory quantity, and the total inventory value.
-- The report must also include suppliers who currently do not supply any prouducts and products that are not assigned to any suppliers.
SELECT ISNULL(A.SupplierName,'Unassigned Supplier') AS SupplierName,
COUNT(B.ProductID ) AS TotalProduct, 
ISNULL(SUM(C.Quantity),0) AS TotalQuantity,
ISNULL(SUM(B.Price*C.Quantity),0) AS TotalValue FROM Suppliers AS A
FULL OUTER JOIN Products AS B
ON A.SUpplierID = B.SupplierID
FULL OUTER JOIN OrderDetails AS C
ON B.ProductID=C.ProductID
GROUP BY A.SupplierName
ORDER BY A.SupplierName;

--14. Generate a complete category sales report showing every product category, the total number of products. the total quantity sold, and the total sales amount.
-- The report must also include categories that currently have no products and products that are not assigned to any category.
SELECT ISNULL(A.CategoryName,'Unknown') AS CategoryName,COUNT(DISTINCT B.ProductID) AS TotalProducts,
ISNULL(SUM(C.Quantity),0) AS TotalQuantity, 
ISNULL(SUM(B.Price*C.Quantity),0) AS TotalAmount FROM Categories AS A
FULL OUTER JOIN Products AS B
ON A.CategoryID=B.CategoryID
FULL OUTER JOIN OrderDetails AS C
ON B.CategoryID=C.ProductID
GROUP BY A.CategoryName 
ORDER BY A.CategoryName;

--15.Generate a comprehensive ERP business report using all major business tables. The report should display department information, employee details,
-- customer details, order information, shipment status, product details, category information, supplier details, total quantity sold,
-- and total sales amount. The report must include unmatched reocrds from every table, such as departments without employees, employees without orders,
-- customers without orders, orders without customers, products without categories, prouducts without suppliers, suppliers wihtout products, and order without shipments.
SELECT ISNULL(A.DepartmentName,'No Department') AS DepartmentName,
ISNULL(B.EmployeeName,'No Employee') AS EmployeeName,
ISNULL(D.CustomerName,'No Customer') AS CustomerName,
ISNULL(G.ProductName,'No Product') AS ProductName,
ISNULL(I.CategoryName,'No Category') AS CategoryName,
ISNULL(H.SupplierName,'No Supplier') AS SupplierName,
ISNULL(F.DeliveryStatus,'No Shipment') As ShipmentStatus,
COUNT(DISTINCT C.OrderID) AS TotalOrders,
ISNULL(SUM(E.Quantity),0) AS TotalQuantitySold,
ISNULL(SUM(E.Quantity*G.Price),0) AS TotalSalesAmount
FROM Departments AS A
FULL OUTER JOIN Employees AS B
ON A.DepartmentID = B.DepartmentID
FULL OUTER JOIN Orders AS C
ON B.EmployeeID=C.EmployeeID
FULL OUTER JOIN Customers AS D
ON C.CustomerID=D.CustomerID
FULL OUTER JOIN OrderDetails AS E
ON C.OrderID=E.OrderID
FULL OUTER JOIN Shipments AS F
ON E.OrderID=F.OrderID
FULL OUTER JOIN Products AS G
ON E.ProductID=G.ProductID
FULL OUTER JOIN Suppliers AS H
ON G.SupplierID=H.SUpplierID
FULL OUTER JOIN Categories AS I
ON G.CategoryID=I.CategoryID
GROUP BY A.DepartmentName,B.EmployeeName,D.CustomerName, G.ProductName,I.CategoryName,H.SupplierName,F.DeliveryStatus
ORDER BY A.DepartmentName,B.EmployeeName,D.CustomerName;