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
RIFGT JOIN : A RIGHT JOIN returns:
             1.Every row from the right table
             2.Matching rows from the left table.
             3.NULL values for the left table columns whenever no matching row exists.
Syntax: 
       SELECT column_list
       FROM Lefttable 
       RIGHT JOIN RightTable
       ON LeftTable.ColumnName = RightTable.ColumnName;
 */
 
 -- Beginner Questions
 --1.Display all departments together with their employees.
 SELECT B.DepartmentID,B.DepartmentName,A.EmployeeID,A.EmployeeName,A.HireDate FROM Employees AS A
 RIGHT JOIN Departments AS B
 ON A.DepartmentID=B.DepartmentID
 ORDER BY B.DepartmentID,B.DepartmentName;

 --2.Display all categories together with their products.
 SELECT B.CategoryID,B.CategoryName,A.ProductID,A.ProductName FROM Products AS A
 RIGHT JOIN Categories AS B
 ON A.CategoryID=B.CategoryID
 ORDER BY B.CategoryID,B.CategoryName;

 --3. Display all suppliers together with the products they supply.
 SELECT B.SUpplierID,B.SupplierName,A.ProductID,A.ProductName FROM Products AS A
 RIGHT JOIN Suppliers AS B
 ON A.SupplierID= B.SUpplierID
 ORDER BY B.SUpplierID, A.ProductName;

 --4. Display all customers together with their orders.
 SELECT B.CustomerID,B.CustomerName,A.OrderID,A.EmployeeID FROM Orders AS A
 RIGHT JOIN Customers AS B
 ON A.CustomerID=B.CustomerID
 ORDER BY B.CustomerID,A.OrderID;

 --5. Display all orders together with their shipment details.
 SELECT B.OrderID,B.CustomerID,B.EmployeeID,A.ShipmentID,A.DeliveryStatus FROM Shipments AS A
 RIGHT JOIN Orders AS B
 ON A.OrderID=B.OrderID
 ORDER BY B.OrderID,B.EmployeeID;