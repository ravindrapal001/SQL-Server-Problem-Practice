--Create Database
CREATE DATABASE RetailAnalyticsDB;

USE RetailAnalyticsDB;

--Table Design
-- Department Table
CREATE TABLE Departments
(
   DepartmentID INT PRIMARY KEY,
   DepartmentName VARCHAR(50)
);

--Employee Table
CREATE TABLE Employees
(
   EmployeeID INT PRIMARY KEY,
   FirstName VARCHAR(50),
   LastName VARCHAR(50),
   Gender Char(1),
   DepartmentID INT,
   DireDate DATE,
   Salary DECIMAL(10,2),

   FOREIGN KEY (DepartmentID)
   REFERENCES Departments(DepartmentID)
);

--Customer Table
CREATE TABLE Customers
(
   CustomerID INT PRIMARY KEY,
   CustomerName VARCHAR(100),
   City VARCHAR(50),
   StateName VARCHAR(50),
   CustomerType VARCHAR(20)
);

--Category Table
CREATE TABLE Categories
(
  CategoryID INT PRIMARY KEY,
  CategoryName VARCHAR(50)
);

-- Product Table
CREATE TABLE Products
(
   ProductID INT PRIMARY KEY,
   ProductName VARCHAR(100),
   CategoryID INT,
   UnitPrice DECIMAL(10,2),

   FOREIGN KEY(CategoryID)
   REFERENCES Categories(CategoryID)
);

--Order Table
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

--OrderDetails Table
CREATE TABLE OrderDetails
(
   OrderDetailID INT PRIMARY KEY,
   OrderID INT,
   ProductID INT,
   Quantity INT,
   UnitPrice DECIMAL(10,2),

   FOREIGN KEY(OrderID)
   REFERENCES Orders(OrderID),

   FOREIGN KEY(ProductID)
   REFERENCES Products(ProductID)
);
-- Inventory Table
CREATE TABLE Inventory
(
   ProductID INT PRIMARY KEY,
   QuantityAvailable INT,
   ReorderLevel INT,

   FOREIGN KEY(ProductID)
   REFERENCES Products(ProductID)
);
-- Shipment Table
CREATE TABLE Shipments
(
    ShipmentID INT PRIMARY KEY,
    OrderID INT,
    ShipmentDate DATE,
    ShipmentStatus VARCHAR(30),

    FOREIGN KEY(OrderID)
    REFERENCES Orders(OrderID)
);

--Sample Dataset
-- Departments
INSERT INTO Departments VALUES
(1,'Sales'),
(2,'Finance'),
(3,'HR'),
(4,'IT'),
(5,'Operations');

-- Employees
INSERT INTO Employees VALUES
(101,'Amit','Sharma','M',1,'2022-01-15',45000),
(102,'Priya','Singh','F',2,'2021-05-20',65000),
(103,'Rohit','Verma','M',1,'2020-08-18',52000),
(104,'Sneha','Kapoor','F',4,'2019-02-11',78000),
(105,'Karan','Mehta','M',5,'2023-04-01',430000);

--Customers
INSERT INTO Customers VALUES
(201,'ABC Retail','Delhi','Delhi','Premium'),
(202,'XYZ Traders','Mumbai','Maharashtra','Regular'),
(203,'Future Mart','Jaipur','Rajasthan','Premium'),
(204,'Daily Needs','Lucknow','Uttar Pradesh','Regular'),
(205,'Metro Shop','Bengaluru','Karnataka','Premium');

--Categories
INSERT INTO Categories VALUES
(1,'Electronics'),
(2,'Furniture'),
(3,'Office Supplies'),
(4,'Accessories');

--Products
INSERT INTO Products VALUES
(301,'Laptop',1,55000),
(302,'Printer',1,12000),
(303,'Office Chair',2,6500),
(304,'Desk',2,9000),
(305,'Mouse',4,700),
(306,'Keyboard',4,1200),
(307,'Notebook Pack',3,450),
(308,'Pen Set',3,250);

--Orders
INSERT INTO Orders VALUES
(401,201,101,'2024-01-10'),
(402,202,103,'2024-01-15'),
(403,203,101,'2024-02-05'),
(404,204,104,'2024-02-11'),
(405,205,105,'2024-03-01');

--OrderDetails
INSERT INTO OrderDetails VALUES
(1,401,301,2,55000),
(2,401,305,5,700),
(3,402,302,1,12000),
(4,402,306,3,1200),
(5,403,303,4,6500),
(6,403,308,10,250),
(7,404,304,2,9000),
(8,405,307,15,450);

-- Inventory
INSERT INTO Inventory VALUES
(301,25,10),
(302,18,5),
(303,40,10),
(304,12,5),
(305,150,50),
(306,120,40),
(307,300,100),
(308,500,150);

--Shipments
INSERT INTO Shipments VALUES
(501,401,'2024-01-12','Delivered'),
(502,402,'2024-01-17','Delivered'),
(503,403,'2024-02-08','Delivered'),
(504,404,'2024-02-14','In Transit'),
(505,405,'2024-03-03','Pending');

SELECT TOP 1 * FROM Departments;
SELECT TOP 1 * FROM Employees;
SELECT TOP 1 * FROM Customers;
SELECT TOP 1 * FROM Categories;
SELECT TOP 1 * FROM Products;
SELECT TOP 1 * FROM Orders;
SELECT TOP 1 * FROM OrderDetails;
SELECT TOP 1 * FROM Inventory;
SELECT TOP 1 * FROM Shipments;

--Begineer Practice Questions
--1. The Human Resources department wants to classify employees into salary grades based on their monthly salary. 
-- Use a CASE statement to display the following salary categories:
-- a. Salary<45000 then Low Salary
-- b. Salary between 45000 and 60000 then Medium Salary
-- c. Salary>60000 then High Salary
SELECT A.EmployeeID,A.FirstName,A.Salary,
CASE 
    WHEN Salary<45000 THEN 'Low Salary'
    WHEN Salary BETWEEN 45000 AND 60000 THEN 'Medium Salary'
    WHEN Salary>60000 THEN 'High Salary'
END AS SalaryGrade
FROM Employees AS A;

--2. The Sales department wants to classify  based on their customer type. Display: CustomerID, CustomerName, CustomerType, CustomerCategory
-- Rules: Premium then VIP Customer
--        Regular then Standard Customer
--        Otherwise then New Customer
SELECT A.CustomerID,A.CustomerName,A.CustomerType,
CASE
    WHEN CustomerType='Premium' THEN 'VIP Customer'
    WHEN CustomerType='Regular' THEN 'Standard Customer'
    WHEN CustomerType='Otherwise' THEN 'New Customer'
END AS CustomerCategory
FROM Customers A;

--3. The Product Managerment team wants to classify products into different price categories fro reporting purpose.
-- Display the following columns: ProductID, ProductName, UnitPrice, PriceCategory
--  Classification Rules:
-- Unit Price < 1000 then Budget
-- Unit Price between 1000 and 10000 then Standard
-- Unit Price >10000 then Premium
SELECT A.ProductID,A.ProductName,A.UnitPrice,
CASE 
     WHEN A.UnitPrice<1000 THEN 'Budget'
     WHEN A.UnitPrice BETWEEN 1000 AND 10000 THEN 'Standard'
     WHEN A.UnitPrice>10000 THEN 'Premium'
END AS PriceCategory
FROM Products AS A

--4. The Inventory department wants to determine whether products require replenishment.
-- Display: ProductID, QuantityAvailable, Reordered Level, InventoryStatus
-- Rules:
-- QuantityAvailable < ReorderedLevel then Reorder Required
-- QuantityAvailable = ReorderedLevel then At Reorder Level
-- QuantityAvailable > ReorderedLevel then Sufficient Stock
SELECT A.ProductID,A.QuantityAvailable,A.ReorderLevel,
CASE 
    WHEN A.QuantityAvailable<A.ReorderLevel THEN 'Reorder Required'
    WHEN A.QuantityAvailable=A.ReorderLevel THEN 'Reorder Level'
    WHEN A.QuantityAvailable>A.ReorderLevel THEN 'Sufficient Stock'
END AS InventoryStatus
FROM Inventory AS A
