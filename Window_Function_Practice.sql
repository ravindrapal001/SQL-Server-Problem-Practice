USE RetailAnalyticsDB1;

SELECT TOP 1 * FROM Departments;
SELECT TOP 1 * FROM Sales;
SELECT TOP 1 * FROM Employees;

--Beginner Practice Questions
--1. Display every employee along with the total salary of their department.
SELECT A.EmployeeName,A.Salary,A.DepartmentID,
SUM(A.Salary) OVER(PARTITION BY A.DepartmentID) AS DepartmentSalary FROM Employees AS A;

--2. Find the average salary of each department beside every employee.
SELECT A.EmployeeName,A.Salary,A.DepartmentID,
AVG(A.Salary) OVER(PARTITION BY A.DepartmentID) AS DepartmentAvgSalary
FROM Employees AS A;

--3. Display highest salary of every department beside each employees.
SELECT A.EmployeeName,A.Salary,
MAX(A.Salary) OVER(PARTITION BY A.DepartmentID) AS DepartmentMaxSalary
FROM Employees AS A;

--4. Display minimum salary of every department.
SELECT A.EmployeeName,A.Salary,
MIN(A.Salary) OVER(PARTITION BY A.DepartmentID) AS DepartmentMinSalary
FROM Employees AS A;

--5. Count employees in each department.
SELECT A.EmployeeName,COUNT(*) OVER(PARTITION BY A.DepartmentID) AS NoOfEmployees
FROM Employees AS A;

--6.Display each employee along with a unique row number based on salary in descending order.
SELECT A.EmployeeName,A.DepartmentID,A.Salary,
ROW_NUMBER() OVER(ORDER BY A.Salary DESC) AS RowNum
FROM Employees AS A

--7. Assign salary ranks to employees.
SELECT A.EmployeeID,A.EmployeeName,A.Salary,
RANK() OVER(ORDER BY A.Salary DESC) AS Ranks
FROM Employees AS A

--8. Assign dense salary ranks
SELECT A.EmployeeName,A.Salary,
DENSE_RANK() OVER(ORDER BY A.Salary DESC) AS DenseSalaryRank
FROM Employees AS A

--9. Show each sales together with the previous sales amount of the same employees.
SELECT A.EmployeeID,A.SalesDate,A.SalesAmount,
LAG(A.SalesAmount) OVER(PARTITION BY A.EmployeeID ORDER BY A.SalesDate) AS PreviousSales
FROM Sales AS A

--10. Display the next sales amount for each employees.
SELECT A.EmployeeID,A.SalesDate,A.SalesAmount,
LEAD(A.SalesAmount) OVER(PARTITION BY A.EmployeeID ORDER BY A.SalesDate ) AS NextSales
FROM Sales AS A
--11. Divide employees into four salary groups.
SELECT A.EmployeeName,A.Salary,
NTILE(4) OVER(ORDER BY A.Salary DESC) AS SalaryQuartile
FROM Employees AS A

--12. Display departmental running salary total ordered by joining date.
SELECT A.EmployeeName,A.JoiningDate,A.Salary,
SUM(A.Salary) OVER(PARTITION BY A.DepartmentID ORDER BY A.JoiningDate) AS RunningSalary
FROM Employees AS A

--13. Calculate cummulative sales for each employee.
SELECT A.EmployeeID,A.SalesDate,A.SalesAmount,
SUM(A.SalesAmount) OVER(PARTITION BY A.EmployeeID ORDER BY A.SalesDate) AS RunningSales
FROM Sales AS A

--14. Display department maximum salary beside every employee using a window function.
SELECT A.EmployeeName,A.DepartmentID,A.Salary,
MAX(A.Salary) OVER(PARTITION BY A.DepartmentID) AS DepartmentMaximum
FROM Employees AS A

--15. Show salary difference each employee and the previous employee after sorting by salary.
SELECT A.EmployeeID,A.EmployeeName,A.DepartmentID,A.Salary,
A.Salary -
LAG(A.Salary) OVER( ORDER BY A.Salary ) AS SalaryDifference
FROM Employees AS A





