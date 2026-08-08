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