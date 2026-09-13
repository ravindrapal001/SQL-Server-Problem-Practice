USE RetailAnalyticsDBs;

SELECT TOP 1 * FROM Departments;
SELECT TOP 1 * FROM Employees;
SELECT TOP 1 * FROM Customers;
SELECT TOP 1 * FROM Suppliers;
SELECT TOP 1 * FROM Products;
SELECT TOP 1 * FROM Orders;
SELECT TOP 1 * FROM OrderDetails;
SELECT TOP 1 * FROM Warehouses;
SELECT TOP 1 * FROM Inventory;
SELECT TOP 1 * FROM Payments;

-- Begineer Questions
--1. Find the employee(s) whose salary is greater than the average salary of all employees using a self-contained (scalar) sub-query.
SELECT * FROM Employees AS A
WHERE A.Salary>(SELECT AVG(B.Salary)  FROM Employees AS B);

--2. Display the products whose unit price is greater than the average product price using a slef-contained scalar sub-query.
SELECT * FROM Products AS A
WHERE A.UnitPrice>(SELECT AVG(B.UnitPrice) FROM Products AS B);

--3. Display all customers who have placed altleast one order using a multiple-row self-contained sub-query with the IN operator.
SELECT A.CustomerID,A.CustomerName,A.City,A.CustomerType FROM Customers AS A
WHERE A.CustomerID IN (SELECT B.CustomerID FROM Customers B);

--4. Display products supplied by suppliers located in Mumbai using a self-contained multiple-row sub-query.
SELECT * FROM Suppliers AS A
WHERE A.SupplierID IN (SELECT B.SupplierID FROM Suppliers AS B WHERE B.City='Mumbai');

--5. Display all employees who work in the department named 'IT' using a self-contained scalar sub-query.
SELECT * FROM Employees AS A
WHERE A.DepartmentID=(SELECT B.DepartmentID FROM Departments AS B WHERE B.DepartmentName='IT');

--6. Display the employee(s) who earn the highest salary in the company using a self-contained scalar sub-query.
SELECT * FROM Employees AS A
WHERE A.Salary=(SELECT MAX(B.Salary) FROM Employees AS B);

--7. Display all products whose UnitPrice is greater than the average price of products belonging to the Accessories category.
SELECT * FROM Products AS A
WHERE A.UnitPrice>(SELECT AVG(B.UnitPrice) FROM Products AS B WHERE B.Category='Accessories');

--8. Display all customers who have not placed any orders using a self-contained multiple-row sub-query.
SELECT * FROM Customers AS A
WHERE A.CustomerID NOT IN(SELECT B.CustomerID FROM Orders AS B);

--9. Display all suppliers who supply at least one product using a multiple-row slef-contained sub-query.
SELECT * FROM Suppliers AS A
WHERE A.SupplierID IN (SELECT B.SupplierID FROM Products AS B);

--10.Display all products that have been ordered at least once by customers using a self-contained multiple-row sub-query.
SELECT * FROM Products AS A
WHERE A.ProductID IN (SELECT B.ProductID FROM OrderDetails AS B);

--11. Display all employees whose salary is greater than the average salary of their respective department using a Correlated Sub-query.
SELECT * FROM Employees AS A
WHERE A.Salary>(SELECT AVG(B.Salary) FROM Employees AS B WHERE B.DepartmentID=A.DepartmentID);

--12. Display all customers whose payment amount is greater than the average payment amount of all customers using a Correlated sub-query.
SELECT * FROM Customers AS A
WHERE EXISTS (SELECT 1 FROM Orders AS B
INNER JOIN Payments AS C ON B.OrderID=C.OrderID WHERE B.CustomerID=A.CustomerID
AND C.PaymentAmount>(SELECT AVG(D.PaymentAmount) FROM Payments AS D));

--13. Display all products whose total ordered quantity is greater than the average ordered quantity of all products using an Inline (Derived Table) Sub-query.
SELECT ProductID,ProductName,TotalQuantity FROM (SELECT A.ProductID,A.ProductName,
SUM(B.Quantity) AS TotalQuantity FROM Products AS A
INNER JOIN OrderDetails AS B ON A.ProductID=B.ProductID 
GROUP BY A.ProductID, A.ProductName) AS ProductSales
WHERE TotalQuantity>(SELECT AVG(TotalQty) FROM (SELECT SUM(C.Quantity) AS TotalQty
FROM OrderDetails AS C GROUP BY C.ProductID) AS AvgTable); 

--14. Display departments having more employees than the average number of employees per department using an Inline(Derived Table) Sub-query.
SELECT A.DepartmentID,A.DepartmentName,DeptSummary.EmployeeCount FROM Departments AS A
INNER JOIN (SELECT DepartmentID,COUNT(*) AS EmployeeCount FROM Employees AS B  GROUP BY DepartmentID) AS DeptSummary
ON A.DepartmentID=DeptSummary.DepartmentID WHERE DeptSummary.EmployeeCount>(SELECT AVG(EmployeeCount) FROM
(SELECT COUNT(*) AS EmployeeCount FROM Employees GROUP BY DepartmentID) AS AvgDept) ;

--15. Display all products that have never been ordered by any customer using a Correlated Sub-query with the NOT EXISTS operator.
SELECT * FROM Products AS A
WHERE NOT EXISTS (SELECT 1 FROM OrderDetails AS B WHERE B.ProductID=A.ProductID);

-- Intermediate Practice Questions
--1. Display all employees who
-- earn more than the company's average salary, and
-- were hired before the average hiring data. Use only SQL Server (T-SQL) sub-queries.
SELECT * FROM Employees AS A
WHERE A.Salary>(SELECT AVG(B.Salary) FROM Employees AS B)
AND A.HireDate<(SELECT AVG(C.HireDate) FROM Employees AS C);

--2. Display all products whose price is greater than the average price of their own category using a Correlated Sub-query.
SELECT * FROM Products AS A
WHERE A.UnitPrice>(SELECT AVG(B.UnitPrice) FROM Products AS B WHERE A.ProductID=B.ProductID)

--3.Display all customers whose total payment amount is greater the average total payment made by all customers.
SELECT A.CustomerID,A.CustomerName,(SELECT SUM(F.PaymentAmount) FROM Orders AS D INNER JOIN Payments AS F ON 
D.OrderID=F.OrderID WHERE D.CustomerID=A.CustomerID) AS TotalPayment FROM Customers AS A
WHERE (SELECT SUM(C.PaymentAmount) FROM Orders AS B INNER JOIN Payments AS C ON B.CustomerID=A.CustomerID)>
(SELECT AVG(CustomerTotal) FROM (SELECT SUM(H.PaymentAmount) AS CustomerTotal FROM Orders AS G INNER JOIN Payments H
ON G.OrderID=H.OrderID GROUP BY G.CustomerID)AS AvgPayments); 

--4. Display all departments whose total salary expenditure is greater than the average departmental salary expenditure.
SELECT A.DepartmentID,A.DepartmentName,DeptSalary.TotalSalary FROM Departments AS A
INNER JOIN (SELECT B.DepartmentID,SUM(B.Salary) AS TotalSalary FROM Employees AS B GROUP BY B.DepartmentID ) AS DeptSalary
ON A.DepartmentID=DeptSalary.DepartmentID
WHERE DeptSalary.TotalSalary>(SELECT AVG(TotalSalary) FROM (SELECT SUM(G.Salary) AS TotalSalary FROM Employees G GROUP BY G.DepartmentID)
AS AvgDeptSalary);

--5.Display all suppliers whose average product price is greater than the overall average product price of the company.
SELECT A.SupplierID,A.SupplierName,A.City FROM Suppliers AS A
WHERE (SELECT AVG(B.UnitPrice) FROM Products AS B WHERE B.SupplierID=A.SupplierID)>
(SELECT AVG(C.UnitPrice) FROM Products AS C);