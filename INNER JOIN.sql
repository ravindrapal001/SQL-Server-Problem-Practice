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
INNER JOIN: It returns only those rows where a matching value exists in both tables based on the specified join condition.
            If a row from one table has no corresponding match in the other table, it is excluded from the final result.
*/

--Intermediate Questions
--Q.1: Display every order along with the customer who placed it.
SELECT A.OrderID,A.OrderDate,B.CustomerID,B.CustomerName,B.City FROM Orders AS A
INNER JOIN Customers AS B
ON A.CustomerID=B.CustomerID
ORDER BY A.OrderID;

--Q.2: Display every employee along with the department in which they work.
SELECT A.EmployeeID,A.EmployeeName,A.HireDate,B.DepartmentID,B.DepartmentName,B.Location FROM Employees AS A
INNER JOIN Departments AS B
ON A.DepartmentID=B.DepartmentID
ORDER BY A.EmployeeID;

--3. Display every product along with its category and supplier.
SELECT A.ProductID,A.ProductName,A.CategoryID, A.SupplierID FROM Products AS A
INNER JOIN Categories AS B
ON A.CategoryID=B.CategoryID
INNER JOIN Suppliers AS C
ON A.SupplierID=C.SUpplierID 
ORDER BY A.ProductID;

--4.Display every order along with the employee who processed it and the customer who placed it.
SELECT A.OrderID,A.CustomerID,A.EmployeeID, A.OrderDate,B.EmployeeName,B.HireDate FROM Orders AS A
INNER JOIN Employees AS B
ON A.EmployeeID=B.EmployeeID 
INNER JOIN Customers AS C
ON A.CustomerID=C.CustomerID
ORDER BY A.OrderID;

--5.Display every order along with the ordered products and their quantities.
SELECT A.OrderID,A.CustomerID,A.EmployeeID,A.OrderDate,B.OrderDetailID,B.Quantity FROM Orders AS A
INNER JOIN OrderDetails AS B
ON A.OrderID=B.OrderID 
INNER JOIN Products AS C
ON B.ProductID=C.ProductID
ORDER BY A.OrderID;

--6.Display every customer along with the products they have purchased.
SELECT A.CustomerID,A.CustomerName,D.ProductID,D.ProductName FROM Customers AS A
INNER JOIN Orders AS B
ON A.CustomerID=B.CustomerID
INNER JOIN OrderDetails AS C
ON B.OrderID=C.OrderID
INNER JOIN Products AS D
ON C.ProductID=D.ProductID
ORDER BY A.CustomerID,A.CustomerName,D.ProductID,D.ProductName;

--7.Display every supplier along with the products they supply and the category of each product.
SELECT A.SUpplierID,A.SupplierName,B.ProductID,B.ProductName,C.CategoryID,C.CategoryName FROM Suppliers AS A
INNER JOIN Products AS B
ON A.SUpplierID=B.SupplierID
INNER JOIN Categories AS C
ON B.CategoryID=C.CategoryID
ORDER BY A.SUpplierID,A.SupplierName,B.ProductID,C.CategoryID;

--8.Display every employee together with the total number of orders they have processed.
SELECT a.EmployeeID,a.EmployeeName, count(b.OrderID) AS TotalOrders FROM Employees AS A
INNER JOIN Orders AS B
ON A.EmployeeID=B.EmployeeID
GROUP BY A.EmployeeID,A.EmployeeName
ORDER BY TotalOrders DESC;

--9. Display every category together with the total number of products availabe in that category.
SELECT A.CategoryID,A.CategoryName,COUNT(B.ProductID) AS TotalProducts FROM Categories AS A
INNER JOIN Products AS B
ON A.CategoryID=B.CategoryID
GROUP BY A.CategoryID,A.CategoryName
ORDER BY TotalProducts DESC , A.CategoryName;

--10. Display every customer together with the total amount they have spent on purchases.
SELECT A.CustomerID,A.CustomerName,COUNT(C.ProductID) AS TotalProduct,SUM(C.Quantity*D.Price) AS TotalPurchaeAmount FROM Customers AS A
INNER JOIN Orders AS B
ON A.CustomerID=B.CustomerID
INNER JOIN OrderDetails AS C
ON B.OrderID=C.OrderID 
INNER JOIN Products AS D
ON C.ProductID=D.ProductID
GROUP BY A.CustomerID ,A.CustomerName
ORDER BY TotalProduct DESC, TotalPurchaeAmount DESC;

--11. Display every order along with its shipment details.
SELECT A.OrderID,A.OrderDate,B.ShipmentID, B.ShipmentDate,B.DeliveryStatus FROM Orders AS A
INNER JOIN Shipments AS B
ON A.OrderID=B.OrderID
ORDER BY A.OrderID;

--12. Display every customer together with the products they purchased and the category of each product.
SELECT A.CustomerID,A.CustomerName,D.ProductID,D.ProductName,E.CategoryID,E.CategoryName FROM Customers AS A
INNER JOIN Orders AS B
ON A.CustomerID = B.CustomerID
INNER JOIN OrderDetails AS C
ON B.OrderID = C.OrderID
INNER JOIN Products AS D
ON C.ProductID = D.ProductID
INNER JOIN Categories AS E
ON D.CategoryID = E.CategoryID

ORDER BY A.CustomerID , ProductID;

--13. Display every employee together with their department and the total number of orders they have processsed.
SELECT A.EmployeeID,A.EmployeeName,B.DepartmentName, COUNT(C.OrderID) AS TotalOrders FROM Employees AS A
INNER JOIN Departments AS B
ON A.DepartmentID = B.DepartmentID
INNER JOIN Orders AS C
ON A.EmployeeID = C.EmployeeID
GROUP BY A.EmployeeID, A.EmployeeName, B.DepartmentName
ORDER BY TotalOrders DESC, A.EmployeeName;

--14. Display every order together with the customer, employee, and shipment information.
SELECT A.OrderID,C.CustomerID,C.CustomerName,D.EmployeeID,D.EmployeeName,B.ShipmentID,B.DeliveryStatus FROM Orders AS A
INNER JOIN Shipments AS B
ON A.OrderID = B.OrderID
INNER JOIN Customers AS C
ON A.CustomerID = C.CustomerID
INNER JOIN Employees AS D
ON A.EmployeeID = D.EmployeeID
ORDER BY A.OrderID;

--15. Generate a comprehensive sales report showing the following information for every product sold.
SELECT D.OrderID,C.SUpplierID,C.SupplierName,A.ProductID,A.ProductName,B.CategoryID,B.CategoryName FROM Products AS A
INNER JOIN Categories AS B
ON A.CategoryID= B.CategoryID
INNER JOIN Suppliers AS C
ON A.SupplierID = C.SUpplierID
INNER JOIN OrderDetails AS D
ON A.ProductID = D.ProductID
ORDER BY D.OrderID;