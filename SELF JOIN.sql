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

/*A SELF JOIN is a join where a table is joined with itself using table aliases. EAch alias represents a different logical copy of the same table.
Syntax: SELECT
           A.ColumnName,
           B.ColumnName,
        FROM TableName AS A
        JOIN TableName AS B
        ON A.Column = B.Column;
Types of SELF JOIN
1. INNER SLEF JOIN
2. LEFT SLEF JOIN
3. RIGHT SLEF JOIN
4. FULL OUTER SELF JOIN 
*/

-- Beginner Questions
--1. Display every employee together with their manager's name. Employees who do not have a manager should also appear in the report.
SELECT A.EmployeeID,A.EmployeeName,ISNULL(B.EmployeeName,'No Manager') AS ManagerName FROM Employees AS A
LEFT JOIN Employees AS B
ON A.EmployeeID=B.ManagerID
ORDER BY A.EmployeeID;

--2. Display all employees who don't have a manager.
SELECT A.EmployeeID,A.EmployeeName FROM Employees AS A
LEFT JOIN Employees AS B
ON A.EmployeeID=B.ManagerID
WHERE B.ManagerID IS NULL
ORDER BY A.EmployeeID;

--3. Display every manager together with the employees who directly report to them. Managers who do not supervise any employees should also appear in the report.
SELECT B.EmployeeID AS ManagerID,B.EmployeeName AS ManagerName,
ISNULL(A.EmployeeName, 'No Direct Employee') AS EmployeeName FROM Employees AS A
RIGHT JOIN Employees AS B
ON A.EmployeeID =B.ManagerID
ORDER BY B.EmployeeID,A.EmployeeName;

--4. Display every employee together with their manager's name, and sort the report first by manager name and then by employee name.
SELECT A.EmployeeID,A.EmployeeName,ISNULL(B.EmployeeName,'No Manager') AS ManagerName FROM Employees AS A
LEFT JOIN Employees AS B
ON A.ManagerID=B.EmployeeID
ORDER BY ManagerName,A.EmployeeName;

--5. Display pairs of employees who report to the same manager. The report should show the manager's name and the name of employees working under that manager. Each employee pari should appear only once.
SELECT C.EmployeeName AS ManagerName,
A.EmployeeName AS Employee1,
B.EmployeeName AS Employee2 FROM Employees AS A
INNER JOIN Employees AS B
ON A.ManagerID=B.ManagerID
INNER JOIN Employees AS C
ON A.ManagerID=C.EmployeeID
WHERE A.EmployeeID < B.EmployeeID
ORDER BY C.EmployeeName,A.EmployeeName,B.EmployeeName;

--7.Display each manager along with the total salary of employees directly reporting to them. The report should also include managers who currently do not supervise any employees.
SELECT A.EmployeeID AS ManagerID,A.EmployeeName AS ManagerName,
ISNULL(SUM(B.Salary),0) AS TotalTeamSalary FROM Employees AS A
LEFT JOIN Employees AS B
ON A.ManagerID=B.EmployeeID
GROUP BY A.EmployeeID,A.EmployeeName
ORDER BY TotalTeamSalary, A.EmployeeName;

--8. Display managers who supervise more than three employees. The report should include the manager's ID, manager's name, and the total number of direct employees reporting to them.
SELECT A.EmployeeID AS ManagerID,
A.EmployeeName AS ManagerName,
Count(B.EmployeeID) AS TotalEmployee FROM Employees AS A
INNER JOIN Employees AS B
ON A.ManagerID=B.EmployeeID
GROUP BY A.EmployeeID,A.EmployeeName
HAVING COUNT(B.EmployeeID)>3
ORDER BY TotalEmployee DESC, A.EmployeeName ;

--9. Display each employee along with their manager's name and the department of both the employee and the manager. The report should include employee's who do not have a manager.
SELECT A.EmployeeID, A.EmployeeName ,A.DepartmentID AS Emp_Dept, 
ISNULL(B.EmployeeName,'No Manager') AS ManagerName,
C.DepartmentName AS EmployeeDepartment,
ISNULL(D.DepartmentName,'No Department') AS ManagerDepartment FROM Employees AS A
LEFT JOIN Employees AS B
ON A.EmployeeID=B.ManagerID
LEFT JOIN Departments AS C
ON A.DepartmentID=C.DepartmentID
LEFT JOIN Departments AS D
ON B.DepartmentID=D.DepartmentID
ORDER BY C.DepartmentName,A.EmployeeName;

--10. Display every employee together with their manager's salary, compare both salaries, calculate the salary difference, and determine whether the employee earns more than, less than, or equal to their manager.
SELECT A.EmployeeID, A.EmployeeName, A.Salary AS EmployeeSalary ,
ISNULL(B.EmployeeName, 'No Manager') As ManagerName,
ISNULL(B.Salary,0) AS ManagerSalary,
ISNULL(A.Salary - B.Salary,0) AS SalaryDifference,
CASE
    WHEN B.EmployeeID IS NULL THEN 'No Manager'
    WHEN A.Salary> B.Salary THEN 'Higher Salary'
    WHEN A.Salary < B.Salary THEN 'Lower Salary'
    ELSE 'Equal Salary'
END AS SalaryComparison    FROM Employees AS A
LEFT JOIN Employees AS B
ON A.ManagerID=B.EmployeeID
ORDER BY A.EmployeeID;

--11. Generate an organizational hierarchy report showing every employee, their direct mananger, and their senior manager (manager's manager). The report should include the employee's ID, employee's name, direct manager's name, senior manager's name, and employee's department. Employees wihtout managers or senior managers should also be included.
SELECT A.EmployeeID, A.EmployeeName, D.DepartmentName,
ISNULL(B.EmployeeName,'No Manager') AS DirectManager,
ISNULL(C.EmployeeName, 'No Senior Manager') AS SeniorManager FROM Employees AS A
LEFT JOIN Employees AS B
ON A.ManagerID=B.EmployeeID
LEFT JOIN Employees AS C
ON B.ManagerID=C.EmployeeID
LEFT JOIN Departments AS D
ON A.DepartmentID=D.DepartmentID
ORDER BY
D.DepartmentName, A.EmployeeName;

--12. Generate an employee hierarchy report that displays every employee, their direct manager, the total number of direct employees reporting to that manager,and the average salary of the manager's team.
SELECT A.EmployeeID,A.EmployeeName,
ISNULL(B.EmployeeName, 'No Manager') AS ManagerName,
ISNULL(C.TeamSize,0) as TeamSize,
ISNULL(C.AverageSalary,0) AS AverageTeamSalary FROM Employees AS A
LEFT JOIN Employees AS B
ON A.ManagerID = B.EmployeeID
LEFT JOIN (SELECT ManagerID, COUNT(*) AS TeamSize, AVG(Salary) AS AverageSalary FROM Employees
WHERE ManagerID IS NOT NULL
GROUP BY ManagerID) AS C
ON A.EmployeeID=C.ManagerID
ORDER BY ManagerName, A.EmployeeName;

--13. Generate a complete organizational hierarchy report showing every employee together with:
-- Employee ID, Employee Name, Department, Direct Manager, Senior Manager, Total Team Members under the Direct Mangaer,
-- Total Salary of the Direct Manager's Team, Average Salary of the Direct Manager's Team, Employee Salary,
-- Salary Difference from the Direct Manager, Salary Status ( Higher, Lower, Equal or No Manager), Employees without managers hould also appear in the report.
SELECT A.EmployeeID,A.EmployeeName,D.DepartmentName,
ISNULL(B.EmployeeName, 'No Manager') AS DirectManager,
ISNULL(C.EmployeeName,'No Senior Manager') AS SeniorManager,
ISNULL(E.TeamSize,0) AS TeamSize,
ISNULL(E.TotalSalary,0) AS TeamSalary,
ISNULL(E.AverageSalary,0) AS AverageTeamSalary,
A.Salary AS EmployeeSalary,
ISNULL(A.Salary-B.Salary,0) AS SalaryDifference,
CASE
     WHEN B.EmployeeID IS NULL THEN 'No Manager'
     WHEN A.Salary > B.Salary THEN 'Higher Salary'
     WHEN A.Salary < b.Salary THEN 'Lower Salary'
     ELSE 'Equal Salary'
     
END AS SalaryStatus FROM Employees AS A
LEFT JOIN Employees AS B
ON A.ManagerID=B.EmployeeID 
LEFT JOIN Employees AS C
ON B.ManagerID=C.EmployeeID
LEFT JOIN Departments AS D
ON A.DepartmentID=D.DepartmentID
LEFT JOIN ( SELECT ManagerID, COUNT(*) AS TeamSize,
SUM(Salary) AS TotalSalary,AVG(Salary) AS AverageSalary FROM Employees
WHERE ManagerID IS NOT NULL
GROUP BY ManagerID) AS E 
ON B.EmployeeID=E.ManagerID
ORDER BY D.DepartmentName, A.EmployeeName;

--14. Generate an organizational reproting analysis that identifies every manager along with:
-- Manager ID, Manager Namae, Department Name, Total Direct Employees, Total Team Salary, Average Team Salary,
-- Highest Team Salary, Lowest Team Salary, Number of Employees Earning More Than their Manager,
-- Number of Employees Earning Less Than Their Manager, Number of Employees Having the Same Salary as Their Manager,
-- Only employees who supervise at least one employee should appear in the report.
SELECT A.EmployeeID AS ManagerID, A.EmployeeName AS ManagerName, C.DepartmentName,
COUNT(B.EmployeeID) AS TeamSize,
SUM(B.Salary) AS TotalTeamSalary,
AVG(B.Salary) AS AverageTeamSalary,
MAX(B.Salary) AS HighestTeamSalary,
MIN(B.Salary) as LowestTeamSalary,
SUM(CASE
         WHEN B.Salary > A.Salary THEN 1 ELSE 0 
    END) AS HigherSalaryEmployees,
SUM(CASE
         WHEN B.Salary < A.Salary THEN 1 ELSE 0 
    END) AS LowerSalaryEmployees,
SUM(CASE
         WHEN B.Salary=A.Salary THEN 1 ELSE 0
    END) AS EqualSalaryEmployees    
FROM Employees AS A
INNER JOIN Employees AS B
ON A.ManagerID=B.EmployeeID
LEFT JOIN Departments AS C
ON A.DepartmentID=C.DepartmentID
GROUP BY A.EmployeeID,A.EmployeeName,C.DepartmentName,A.Salary
HAVING COUNT(B.EmployeeID)>0
ORDER BY TeamSize DESC, ManagerName;

--15. Generate a comprehensive Enterprise HR Analytics Dashboard using the following tables:
-- Departments, Employees, Customers, Orders, Orderdetails, Products, Categories, Suppliers, Shipments.
-- This report should display one record for each manager and include:
-- Manager ID, Manager Name, Department Name, Senior Manager name, Team Size, Total Team Salary, Highest Team Salary,
-- Lowest Team Salary, Number of Customers Hnadled by the Team, Number of Orders Processed, Total Sales Amount,
-- Average Order Value, Number of Products Sold, Number of Categories Sold, Number of Suppliers Involved, Number of Shipments Delivered,Salary Comparison Status.
SELECT A.EmployeeID,A.EmployeeName AS ManagerName, D.DepartmentName,
ISNULL(C.EmployeeName, 'No Senior Manager') AS SeniorManager,
COUNT(DISTINCT B.EmployeeID) AS TeamSize,
ISNULL(AVG(B.Salary),0) AS TotalTeamSalary,
ISNULL(MAX(B.Salary),0) AS HighestSalary,
ISNULL(MIN(B.Salary),0) AS LowestSalary,
COUNT(DISTINCT F.CustomerID) AS CustomersHandled,
COUNT(DISTINCT E.OrderID) AS OrdersProcessed,
SUM(G.Quantity*H.Price) AS TotalSales,
AVG(G.Quantity*H.Price) AS AverageOrderValue,
COUNT(DISTINCT H.ProductID) AS ProductsSold,
COUNT(DISTINCT I.CategoryID) AS CategoriesSold,
COUNT(DISTINCT J.SUpplierID) AS SuppliersInvolved,
COUNT(DISTINCT K.ShipmentID) AS ShipmentsDelivered,

CASE
    WHEN AVG(B.Salary)>A.Salary THEN 'Team Avg Salary Higher'
    WHEN AVG(B.Salary)<A.Salary THEN 'Team Avg Salary Lower'
    ELSE 'Equal'
END AS SalaryComparison



FROM Employees AS A
LEFT JOIN Employees AS B
ON B.ManagerID=A.EmployeeID
LEFT JOIN Employees AS C
ON A.ManagerID=C.EmployeeID
LEFT JOIN Departments AS D
ON A.DepartmentID=D.DepartmentID
LEFT JOIN Orders AS E
ON E.EmployeeID=A.EmployeeID
LEFT JOIN Customers AS F
ON E.CustomerID=F.CustomerID
LEFT JOIN OrderDetails AS G
ON E.OrderID=G.OrderID
LEFT JOIN Products AS H
ON G.ProductID=H.ProductID
LEFT JOIN Categories AS I
ON H.CategoryID=I.CategoryID
LEFT JOIN Suppliers AS J
ON H.SupplierID=J.SUpplierID
LEFT JOIN Shipments AS K
ON K.OrderID=E.OrderID

GROUP BY A.EmployeeID,A.EmployeeName,A.Salary,C.EmployeeName,D.DepartmentName
HAVING COUNT(DISTINCT E.EmployeeID)>0
ORDER BY TotalSales DESC, TeamSize DESC, ManagerName;