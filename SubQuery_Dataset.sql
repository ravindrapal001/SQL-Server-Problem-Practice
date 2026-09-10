--Create Database
CREATE DATABASE RetailAnalyticsDBs;

USE RetailAnalyticsDBs;

-- Table Structure
-- Departments
CREATE TABLE Departments
(
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(50),
Location VARCHAR(50)
);

-- Employees
CREATE TABLE Employees
(
EmployeeID INT PRIMARY KEY,
EmployeeName VARCHAR(100),
DepartmentID INT,
Designation VARCHAR(50),
Salary DECIMAL(10,2),
HireDate DATE,

FOREIGN KEY (DepartmentID)
REFERENCES Departments(DepartmentID)
);

-- Customers
CREATE TABLE Customers
(
CustomerID INT PRIMARY KEY,
CustomerName VARCHAR(100),
City VARCHAR(50),
CustomerType VARCHAR(30)
);

--Suppliers
CREATE TABLE Suppliers
(
SupplierID INT PRIMARY KEY,
SupplierName VARCHAR(100),
City VARCHAR(50)
);

-- Products
CREATE TABLE Products
(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(100),
Category VARCHAR(50),
UnitPrice DECIMAL(10,2),
SupplierID INT,

FOREIGN KEY (SupplierID)
REFERENCES Suppliers(SupplierID)
);

-- Orders
CREATE TABLE Orders
(
OrderID INT PRIMARY KEY,
CustomerID INT,
OrderDate DATE,

FOREIGN KEY(CustomerID)
REFERENCES Customers(CustomerID)
);

-- OrderDetails
CREATE TABLE OrderDetails
(
OrderDetailsID INT PRIMARY KEY,
OrderID INT,
ProductID INT,
Quantity INT,
UintPrice DECIMAL(10,2)

FOREIGN KEY(OrderID)
REFERENCES Orders(OrderID),

FOREIGN KEY(ProductID)
REFERENCES Products(ProductID),
);

-- Warehouses
CREATE TABLE Warehouses
(
WarehousesID INT PRIMARY KEY,
WarehouseName VARCHAR(50),
City VARCHAR(50)
);

--Inventory
CREATE TABLE Inventory
(
InventoryID INT PRIMARY KEY,
WarehouseID INT,
ProductID INT,
Stock INT,

FOREIGN KEY(WarehouseID)
REFERENCES Warehouses(WarehousesID),

FOREIGN KEY(ProductID)
REFERENCES Products(ProductID)
);

--Payments
CREATE TABLE Payments
(
PaymentID INT PRIMARY KEY,
OrderID INT,
PaymentMode VARCHAR(30),
PaymentAmount DECIMAL(10,2),

FOREIGN KEY(OrderID)
REFERENCES Orders(OrderID)
);

-- Practice Dataset
-- Departments
INSERT INTO Departments VALUES
(1,'Sales','Delhi'),
(2,'Finance','Mumbai'),
(3,'IT','Bangalore'),
(4,'HR','Nodia'),
(5,'Operations','Hyderabad');

-- Employees
INSERT INTO Employees VALUES
(101,'Amit',1,'Sales Executive',42000,'2021-02-12'),
(102,'Neha',2,'Accountant',58000,'2020-03-21'),
(103,'Rahul',3,'Developer',72000,'2022-01-15'),
(104,'Priya',3,'Data Analyst',68000,'2023-04-11'),
(105,'Rohit',1,'Sales Manager',85000,'2019-08-09'),
(106,'Sneha',4,'HR Executive',45000,'2022-06-18'),
(107,'Vikas',5,'Operations Manager',76000,'2021-09-10'),
(108,'Anjali',2,'Finance Manager',91000,'2018-11-22');

--Customers
INSERT INTO Customers VALUES
(201,'ABC Traders','Delhi','Wholesale'),
(202,'Riya Sharma','Noida','Retails'),
(203,'Sunil Kumar','Delhi','Retails'),
(204,'Tech Solutions','Bangalore','Corporate'),
(205,'XYZ Mart','Mumbai','Wholesale'),
(206,'Karan Singh','Hyderabad','Retail');

-- Suppliers
INSERT INTO Suppliers VALUES
(1,'Dell','Bangalore'),
(2,'HP','Pune'),
(3,'Samsung','Noida'),
(4,'Logitech','Mumbai');

-- Products
INSERT INTO Products VALUES
(1001,'Laptop','Electronics',55000,1),
(1002,'Keyboard','Accessories',1200,4),
(1003,'Mouse','Accessories',700,4),
(1004,'Monitor','Electronics',14500,2),
(1005,'Printer','Electronics',9800,2),
(1006,'SDD','Storage',5200,3),
(1007,'RAW','Storage',3400,3),
(1008,'Webcam','Accessories',2400,4);

-- Orders
INSERT INTO Orders VALUES
(5001,201,'2024-01-03'),
(5002,202,'2024-01-08'),
(5003,203,'2024-01-12'),
(5004,204,'2024-01-18'),
(5005,205,'2024-02-02'),
(5006,206,'2024-02-10');

-- OrderDetails
INSERT INTO OrderDetails VALUES
(1,5001,1001,2,55000),
(2,5001,1002,5,1200),
(3,5002,1003,2,700),
(4,5003,1006,3,5200),
(5,5003,1007,2,3400),
(6,5004,1004,5,14500),
(7,5005,1005,3,9800),
(8,5006,1008,4,2400);

-- Warehouses
INSERT INTO Warehouses VALUES
(1,'North Warehouse','Delhi'),
(2,'South Warehouse','Hyderabad'),
(3,'West Warehouse','Mumbai');

-- Inventory
INSERT INTO Inventory VALUES
(1,1,1001,15),
(2,1,1002,120),
(3,1,1003,140),
(4,2,1006,60),
(5,2,1007,70),
(6,3,1004,35),
(7,3,1005,28),
(8,2,1008,80);

-- Payments
INSERT INTO Payments VALUES
(1,5001,'Credit Card',116000),
(2,5002,'UPI',1400),
(3,5003,'Net Bankind',22400),
(4,5004,'Credit Card', 72500),
(5,5005,'NEFT',294000),
(6,5006,'UPI',9600);



