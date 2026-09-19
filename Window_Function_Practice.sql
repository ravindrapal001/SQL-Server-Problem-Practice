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

--Intermediate Pratice Questions
--1. The HR department wants to rank employees within each department based on salary, with the highest-paid employee receieving Rank 1.
SELECT A.EmployeeName,A.DepartmentID,A.Salary,
RANK() OVER(PARTITION BY A.DepartmentID ORDER BY A.Salary DESC) AS EmpRank
FROM Employees AS A

--2. Management wants to monitor cumulative sales over time.
SELECT A.SalesID,A.SalesDate,A.SalesAmount,
SUM(A.SalesAmount) OVER(ORDER BY A.SalesDate, SalesID) AS RunningTotal
FROM Sales AS A

--3. The sales manager wants to compare every employee's current sales with their previous sale.
SELECT A.EmployeeID,A.SalesDate,A.SalesAmount,
LAG(A.SalesAmount) OVER(PARTITION BY A.EmployeeID ORDER BY A.SalesDate) AS PreviousSale,
SalesAmount-LAG(A.SalesAmount) OVER(PARTITION BY A.EmployeeID ORDER BY A.SalesDate) AS Differenc
FROM Sales AS A;

--4. Calculate each employee's salary contribution as a percentage of their department's total salary.
SELECT A.EmployeeName,A.DepartmentID,A.Salary,
ROUND(A.Salary*100/SUM(A.Salary) OVER(PARTITION BY A.DepartmentID),2) AS SalaryContributionPercent
FROM Employees AS A

--5. Management wants to identify the top two highest-paid employees in every department.
;WITH SalaryRank AS
(
SELECT A.EmployeeID,A.EmployeeName,A.DepartmentID,A.Salary,
ROW_NUMBER() OVER(PARTITION BY A.DepartmentID ORDER BY A.Salary DESC) AS RN
FROM Employees AS A
)
SELECT * FROM SalaryRank AS B 
WHERE B.RN<=2;

--6. The Sales Director wants to compare each employee's current month's sales with their previous month's sales and calculate the monthly growth.
SELECT A.EmployeeID,A.SalesDate,A.SalesAmount,
LAG(A.SalesAmount) OVER(PARTITION BY A.EmployeeID ORDER BY A.SalesDate) AS PreviousMonthSales,
A.SalesAmount-LAG(A.SalesAmount) OVER(PARTITION BY A.EmployeeID ORDER BY A.SalesDate) AS GrowthAmount,
CASE
    WHEN LAG(A.SalesAmount) OVER(PARTITION BY A.EmployeeID ORDER BY A.SalesDate) IS NULL THEN NULL
    ELSE ROUND((A.SalesAmount-LAG(A.SalesAmount) OVER(PARTITION BY A.EmployeeID ORDER BY A.SalesDate))*
    100.0/LAG(A.SalesAmount) OVER(PARTITION BY A.EmployeeID ORDER BY A.SalesDate),2)
END AS GrowthPercent
FROM Sales AS A

--7.The HR department wants employees divided into four salary bands.
SELECT A.EmployeeID,A.EmployeeName,A.Salary,
NTILE(4) OVER(ORDER BY A.Salary DESC) AS SalaryQuartile
FROM Employees AS A

--8. The Sales manager wants to compare every sales with the employee's next recorded sale.
SELECT A.EmployeeID,A.SalesDate,A.SalesAmount,
LEAD(A.SalesAmount) OVER(PARTITION BY A.EmployeeID ORDER BY A.SalesDate) AS NextSale,
LEAD(A.SalesAmount) OVER(PARTITION BY A.EmployeeID ORDER BY A.SalesDate)-A.SalesAmount AS ExpectedIncrease
FROM Sales AS A

--9. Calculate the running average salary within each department according to employee joining date.
SELECT A.EmployeeName,A.DepartmentID,A.JoiningDate,A.Salary,
AVG(A.Salary) OVER(PARTITION BY A.DepartmentID ORDER BY A.JoiningDate) AS RunningAverageSalary
FROM Employees AS A

--10. Generate a report showing every employees together with department salary statistics.
SELECT A.EmployeeName,A.DepartmentID,A.Salary,

SUM(A.Salary) OVER(PARTITION BY A.DepartmentID) AS TotalSalary,
AVG(A.Salary) OVER(PARTITION BY A.DepartmentID) AS AverageSalary,
MIN(A.Salary) OVER(PARTITION BY A.DepartmentID) AS MinimumSalary,
MAX(A.Salary) OVER(PARTITION BY A.DepartmentID) AS MaximumSalary,
COUNT(*) OVER(PARTITION BY A.DepartmentID) AS EmployeeCount

FROM Employees AS A

--11. The HR department wants to identify employees whose salary is greater than the average salary of their respective department.
;WITH EmployeeSalary AS
(
SELECT A.EmployeeID,A.EmployeeName,A.DepartmentID,A.Salary,
AVG(A.Salary) OVER(PARTITION BY A.DepartmentID) AS AvgSalary
FROM Employees AS A
)
SELECT * FROM EmployeeSalary AS B
WHERE B.Salary>AvgSalary;

--12. Find the highest sales transaction made by each employee.
WITH RankedSales AS
(
SELECT A.SalesID,A.EmployeeID,A.SalesDate,A.SalesAmount,
ROW_NUMBER() OVER(PARTITION BY A.EmployeeID ORDER BY A.SalesAmount DESC) AS RN
FROM Sales AS A
)
SELECT * FROM RankedSales
WHERE RN=1;

--13. Divide employees into three salary groups within each department.
SELECT A.EmployeeID,A.EmployeeName,A.DepartmentID,A.Salary,
NTILE(3) OVER(PARTITION BY A.DepartmentID ORDER BY A.Salary DESC) AS SalaryGroup
FROM Employees AS A


