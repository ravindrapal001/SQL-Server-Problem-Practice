-- Create Database
CREATE DATABASE RetailBusinessDB2;

USE RetailBusinessDB2;

-- Create Tables
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
    Gender CHAR(1),
    DepartmentID INT,
    JobTitle VARCHAR(50),
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
State VARCHAR(50),
Phone VARCHAR(20)
);

-- Suppliers
CREATE TABLE Suppliers
(
SupplierID INT PRIMARY KEY,
SupplierName VARCHAR(100),
City VARCHAR(50)
);

--Categories
CREATE TABLE Categories
(
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR(50)
);

--Products
CREATE TABLE Products
(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(100),
CategoryID INT,
SupplierID INT,
UnitPrice DECIMAL(10,2),

FOREIGN KEY(CategoryID)
REFERENCES Categories(CategoryID),

FOREIGN KEY(SupplierID)
REFERENCES Suppliers(SupplierID)
);

--Stores
CREATE TABLE Stores
(
StoreID INT PRIMARY KEY,
StoreName VARCHAR(100),
City VARCHAR(50)
);

-- Inventory
CREATE TABLE Inventory
(
InventoryID INT PRIMARY KEY,
StoreID INT,
ProductID INT,
Quantity INT,

FOREIGN KEY (StoreID)
REFERENCES Stores(StoreID),

FOREIGN KEY (ProductID)
REFERENCES Products(ProductID)
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
UnitPrice DECIMAL(10,2),

FOREIGN KEY (OrderID)
REFERENCES Orders(OrderID),

FOREIGN KEY (ProductID)
REFERENCES Products(ProductID)
);

--Payments
CREATE TABLE Payments
(
PaymentID INT PRIMARY KEY,
OrderID INT,
PaymentDate DATE,
PaymentMode VARCHAR(30),
Amount DECIMAL(10,2),

FOREIGN KEY(OrderID)
REFERENCES Orders(OrderID)
);

--Shippers
CREATE TABLE Shippers
(
ShipperID INT PRIMARY KEY,
CampanyName VARCHAR(100)
);

--Shipments
CREATE TABLE Shipments
(
ShipmentID INT PRIMARY KEY,
OrderID INT,
ShipperID INT,
DispatchDate DATE,
DeliveryDate DATE,

FOREIGN KEY(OrderID)
REFERENCES Orders(OrderID),

FOREIGN KEY(ShipperID)
REFERENCES Shippers(ShipperID)
);

--Practice Dataset
-- Departments
INSERT INTO Departments VALUES
(1,'Sales','Delhi'),
(2,'HR','Mumbai'),
(3,'Finance','Bengaluru'),
(4,'IT','Hyderabad'),
(5,'Logistics','Pune');

-- Employees
INSERT INTO Employees VALUES
(101,'Amit Sharma','M',1,'Sales Executive',45000,'2022-02-10'),
(102,'Priya Singh','F',2,'HR Manager',70000,'2020-01-15'),
(103,'Rahul Verma','M',3,'Accountant',55000,'2021-04-12'),
(104,'Neha Kapoor','F',4,'Developer',82000,'2023-06-20'),
(105,'Rohit Gupta','M',1,'Sales Manager',90000,'2019-07-15'),
(106,'Anjali Mehta','F',5,'Logistics Officer',50000,'2022-11-05'),
(107,'Karan Joshi','M',4,'DBA',95000,'2018-03-18'),
(108,'Pooja Arora','F',3,'Finance Analyst',65000,'2021-08-25');

--Customers
INSERT INTO Customers VALUES
(201,'Raj Malhotra','Delhi','Delhi','9876543210'),
(202,'Sneha Jain','Jaipur','Rajasthan','9876543211'),
(203,'Vivek Gupta','Lucknow','Uttar Pradesh','9876543212'),
(204,'Aarav Patel','Ahmedabad','Gujarat','9876543213'),
(205,'Ravita Rao','Bengaluru','Karnatka','9876543214'),
(206,'Simran Kaur','Chandigarh','Punjab','9876543215'),
(207,'Mohit Bansal','Nodia','Uttar Pradesh','9876543216'),
(208,'Riya Sharma','Gurugram','Haryana','9876543217');

--Categories
INSERT INTO Categories VALUES
(1,'Electronics'),
(2,'Furniture'),
(3,'Grocery'),
(4,'Stationary'),
(5,'Clothing');

--Suppliers
INSERT INTO Suppliers VALUES
(1,'Tech India','Delhi'),
(2,'Fresh Foods','Mumbai'),
(3,'Office Hub','Pune'),
(4,'Fashion World','Jaipur'),
(5,'Wood Craft', 'Bengaluru');

-- Products
INSERT INTO Products VALUES
(1,'Laptop',1,1,65000),
(2,'Desktop',1,1,55000),
(3,'Chair',2,5,4500),
(4,'Rice Bag',3,2,1200),
(5,'Notebook',4,3,120),
(6,'Pen',4,3,20),
(7,'T-Shirt',5,4,900),
(8,'Dining Table',2,5,12000);

--Stores
INSERT INTO Stores VALUES
(1,'Delhi Store','Delhi'),
(2,'Mumbai Store','Mumbai'),
(3,'Bengaluru Store','Bengaluru'),
(4,'Lucknow Store','Lucknow');

--Inventory Table
INSERT INTO Inventory VALUES
(1,1,1,20),
(2,1,2,15),
(3,1,3,40),
(4,2,1,18),
(5,2,4,100),
(6,2,6,300),
(7,3,5,250),
(8,3,7,90),
(9,3,8,12),
(10,4,3,35),
(11,4,4,120),
(12,4,5,170);

--Orders Table
INSERT INTO Orders VALUES
(1001,201,101,'2025-01-05'),
(1002,202,105,'2025-01-08'),
(1003,203,101,'2025-01-10'),
(1004,204,105,'2025-01-12'),
(1005,205,101,'2025-01-15'),
(1006,206,105,'2025-01-18'),
(1007,207,101,'2025-01-20'),
(1008,208,105,'2025-01-22');

--OrderDetails Table
INSERT INTO OrderDetails VALUES
(1,1001,1,1,65000),
(2,1001,6,10,20),
(3,1002,3,2,4500),
(4,1003,5,20,120),
(5,1004,8,1,12000),
(6,1005,7,4,900),
(7,1006,4,5,1200),
(8,1007,2,1,55000),
(9,1008,5,12,120),
(10,1008,6,25,20);

-- Payments Table
INSERT INTO Payments VALUES
(1,1001,'2025-01-05','UPI',65200),
(2,1002,'2025-01-08','Credit Card',9000),
(3,1003,'2025-01-10','Cash',2400),
(4,1004,'2025-01-12','Net Banking',12000),
(5,1005,'2025-01-15','UPI',3600),
(6,1006,'2025-01-18','Debit Card',6000),
(7,1007,'2025-01-20','Credit Card',55000),
(8,1008,'2025-01-22','Cash',1940);

--Shippers Table
INSERT INTO Shippers VALUES
(1,'Blue Dart'),
(2,'Delhivery'),
(3,'DTDC'),
(4,'India Post');

--Shipments Table
INSERT INTO Shipments VALUES
(1,1001,1,'2025-01-06','2025-01-08'),
(2,1002,2,'2025-01-09','2025-01-11'),
(3,1003,3,'2025-01-11','2025-01-13'),
(4,1004,1,'2025-01-13','2025-01-15'),
(5,1005,4,'2025-01-16','2025-01-18'),
(6,1006,2,'2025-01-19','2025-01-21'),
(7,1007,3,'2025-01-21','2025-01-23'),
(8,1008,1,'2025-01-23','2025-01-25');

