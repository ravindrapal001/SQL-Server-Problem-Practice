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


--Beginner Questions
SELECT TOP 1 * FROM Customers;
SELECT TOP 1 * FROM Employees;
SELECT TOP 1 * FROM Departments;
SELECT TOP 1 * FROM Products;
SELECT TOP 1 * FROM Categories;
SELECT TOP 1 * FROM Orders;
SELECT TOP 1 * FROM OrderDetails;
SELECT TOP 1 * FROM Suppliers;
SELECT TOP 1 * FROM Shipments;

--LEFT JOIN(Begineer Question 15)

--1.Display every customer along with their Order ID. Customers who have never placed an order should also appear.
SELECT A.*,B.OrderID FROM Customers AS A
LEFT JOIN Orders AS B
ON A.CustomerID=B.CustomerID;

--2.Display every order together with the customer name. Even if customer information  is missing, the order should still appear.
SELECT A.*,B.CustomerName FROM Orders AS A
LEFT JOIN Customers AS B
ON A.CustomerID=B.CustomerID;

--3.Display every product along with its category name. Even if a product does not belong to any  category, if should still appear in the result set.
SELECT A.*,B.CategoryName FROM Products AS A
LEFT JOIN Categories AS B
ON A.CategoryID=B.CategoryID;

--4.Display every employee along with the department in which they work. Employees who are not assigned to any department should also appear in the result.
SELECT A.*,B.DepartmentName FROM Employees AS A
LEFT JOIN Departments AS B
ON A.DepartmentID=B.DepartmentID;

--5.Display every order along with its shipment information. Orders that have not yet been shipped should also be displayed.
SELECT A.*,B.ShipmentID ,B.ShipmentDate,B.DeliveryStatus FROM  Orders AS A
LEFT JOIN Shipments AS B
ON A.OrderID=B.OrderID;

--6.Display every supplier along with the products they supply. Suppliers who do not supply any products should also appear in the result.
SELECT A.SUpplierID,A.SupplierName,A.City,B.ProductID,B.ProductName,B.CategoryID,B.Price FROM Suppliers AS A
LEFT JOIN Products AS B
ON A.SUpplierID=B.SupplierID;

--7.Display every product category along with the products that belong to each category. Categories that don not contain any products should also appear in the result.
SELECT A.CategoryID,A.CategoryName,B.ProductID,B.ProductName,B.SupplierID,B.Price FROM Categories AS A
LEFT JOIN Products AS B
ON A.CategoryID=B.CategoryID
ORDER BY A.CategoryID,B.ProductName;

--8.Display every department along with the employees working in that department. Departments that do not have any employees should also appear in the result.
SELECT A.DepartmentID,A.DepartmentName,A.Location,B.EmployeeID,B.EmployeeName,B.Salary,B.HireDate FROM Departments AS A
LEFT JOIN Employees AS B
ON A.DepartmentID=B.DepartmentID
ORDER BY A.DepartmentID,B.EmployeeName;

--9.Display every customer along with the total number of orders  placed by that customer. Customers who have never placed an order should alos appear in the result with an order count of zero.
SELECT A.CustomerID,A.CustomerName,COUNT(B.OrderID) AS TotalOrders FROM Customers AS A
LEFT JOIN  Orders AS B
ON A.CustomerID=B.CustomerID
GROUP BY A.CustomerID,A.CustomerName
ORDER BY A.CustomerID;

--10.Display every product along with the total quantity sold.Pruducts taht have never been sold should also appear in the result with a total quantity of zero.
SELECT A.ProductID,A.ProductName,SUM(B.Quantity) AS Total_Quantity FROM Products AS A
LEFT JOIN OrderDetails AS B
ON A.ProductID=B.ProductID
GROUP BY A.ProductID,A.ProductName
ORDER BY A.ProductID;

--11.Display every employee along with the orders handled by them. Employees who have not handled any orders should also appear in the result.
SELECT A.EmployeeID,A.EmployeeName,A.Salary,B.OrderID,B.CustomerID, b.OrderDate FROM Employees As A
LEFT JOIN Orders AS B
ON A.EmployeeID=B.EmployeeID
ORDER BY A.EmployeeID,B.OrderDate;

--12.Display every customer along with the shipment status of their orders. Customers who have never placed an order should alos appear in the result.
WITH Customer_Order AS
(SELECT A.CustomerID,A.CustomerName,A.City,B.OrderID,B.EmployeeID,B.OrderDate FROM Customers AS A
LEFT JOIN Orders AS B
ON A.CustomerID=B.CustomerID)
SELECT * FROM Customer_Order AS C
LEFT JOIN Shipments AS D
ON C.OrderID=D.OrderID
ORDER BY C.CustomerID,C.OrderDate;

--13.Display every supplier along with the categories of the products they supply. Suppliers who do not supply and products should also appear in the result.
WITH Supplier_Product AS (SELECT A.SUpplierID,A.SupplierName,A.City,B.ProductID,B.ProductName,B.CategoryID,B.Price FROM Suppliers AS A
LEFT JOIN Products AS B
ON A.SUpplierID=B.SupplierID)
SELECT * FROM Supplier_Product AS C
LEFT JOIN Categories AS D
ON C.CategoryID=D.CategoryID
ORDER BY C.SUpplierID,C.ProductName;

--14.Display every order along with the employee who processed it. Orders that are not assigned to any employee should also appear in the result.
SELECT A.OrderID,A.EmployeeID,B.EmployeeName,B.Salary,B.HireDate FROM Orders AS A
LEFT JOIN Employees AS B
ON A.EmployeeID=B.EmployeeID
ORDER BY A.OrderID;

--15.Display every department along with the total number of employees working in that department. Departments with no employees should also appear in the result.
SELECT A.DepartmentID,A.DepartmentName,COUNT(B.EmployeeID) AS TotalEmployee FROM Departments AS A
LEFT JOIN Employees AS B
ON A.DepartmentID=B.DepartmentID
GROUP BY A.DepartmentID,A.DepartmentName
ORDER BY A.DepartmentID;
