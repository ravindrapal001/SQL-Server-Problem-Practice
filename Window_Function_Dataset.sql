-- Window Functions perform calculations across a set of rows while keeping each individual row in the output.
-- Unlike GROUP BY, Window Functions do not collapse multiple rows into a single row.
-- General Syntax:
-- Function_Name() OVER
-- (
--   [PARTITION BY column]
--   [ORDER BY column]
-- )

-- Window Functions are mainly divided into three categories,
-- 1. Aggregate Window Functions
-- Aggregate Window Functions perform calculations over a  window.
-- Functions:
-- SUM(),AVG(),COUNT(),MIN(),MAX()

-- 2. Ranking Window Functins
-- Ranking Functions assign ranks to rows.
-- Functions:
-- ROW_NUMBER()
-- RANK()
-- DENSE_RANK()

-- 3. Value Window Functions 
-- These functions access values from another row.
-- Functions:
-- LAG(), LEAD(), NTILE()

-- Create Database
CREATE DATABASE RetailAnalyticsDB1;

USE RetailAnalyticsDB1;

-- Create Tables
-- Departments

CREATE TABLE Departments
(
  DepartmentID INT PRIMARY KEY,
  DepartmentName VARCHAR(50)
);

--Employees
CREATE TABLE Employees
(
  EmployeeID INT PRIMARY KEY,
  EmployeeName VARCHAR(50),
  DepartmentID INT,
  City VARCHAR(40),
  Salary DECIMAL(10,2),
  JoiningDate DATE,
  FOREIGN KEY (DepartmentID)
  REFERENCES Departments(DepartmentID)
);

-- Sales
CREATE TABLE Sales
(
  SalesID INT PRIMARY KEY,
  EmployeeID INT,
  SalesDate DATE,
  SalesAmount DECIMAL(12,2),
  FOREIGN KEY(EmployeeID)
  REFERENCES Employees(EmployeeID)
);

-- Insert Sample Data
-- Departments
INSERT INTO Departments
VALUES
(1,'Sales'),
(2,'Finance'),
(3,'HR'),
(4,'IT'),
(5,'Marketing');

--Employees
INSERT INTO Employees 
VALUES
(101,'Amit',1,'Delhi',65000,'2021-01-12'),
(102,'Neha',1,'Delhi',72000,'2022-07-21'),
(103,'Rahul',2,'Mumbai',80000,'2019-05-13'),
(104,'Priya',2,'Pune',76000,'2022-02-14'),
(105,'Karan',3,'Delhi',54000,'2021-09-11'),
(106,'Anjali',4,'Noida',98000,'2018-11-05'),
(107,'Vikas',4,'Noida',89000,'2019-08-20'),
(108,'Pooja',5,'Jaipur',62000,'2023-01-18'),
(109,'Rohit',5,'Lucknow',68000,'2022-06-15'),
(110,'Sneha',1,'Delhi',61000,'2023-04-20');

-- Sales
INSERT INTO Sales
VALUES
(1,101,'2024-01-01',45000),
(2,101,'2024-02-01',52000),
(3,102,'2024-01-01',61000),
(4,102,'2024-02-01',67000),
(5,103,'2024-01-01',74000),
(6,104,'2024-02-01',71000),
(7,105,'2024-01-01',39000),
(8,106,'2024-01-01',99000),
(9,107,'2024-02-01',95000),
(10,108,'2024-01-01',51000),
(11,109,'2024-02-01',56000),
(12,110,'2024-01-01',47000);

