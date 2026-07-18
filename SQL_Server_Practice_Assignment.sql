CREATE DATABASE BusinessAnalyticsDB;
USE BusinessAnalyticsDB;
--Departments Table
CREATE TABLE Departments
(
DepartmentID INT PRIMARY KEY IDENTITY(1,1),
DepartmentName VARCHAR(100) NOT NULL, 
Location VARCHAR(100)
);
--Employees Table
CREATE TABLE Employees
(
EmployeeID INT PRIMARY KEY IDENTITY(1001,1),
FirstName VARCHAR(50),
LastName VARCHAR(50),
Gender CHAR(1),
HireDate DATE,
Salary DECIMAL(12,2),
DepartmentID INT,
ManagerID INT NULL,
CONSTRAINT FK_Employee_Department
FOREIGN KEY (DepartmentID)
REFERENCES Departments(DepartmentID),

CONSTRAINT FK_Manager
FOREIGN KEY (ManagerID)
REFERENCES Employees(EmployeeID)
);

--Customers
CREATE TABLE Customers
(
CustomerID INT PRIMARY KEY IDENTITY(1,1),
CustomerName VARCHAR(100),
Email VARCHAR(100),
Phone VARCHAR(20),
City VARCHAR(100),
StateName VARCHAR(100),
RegistrationDate DATE
);

--Categories
CREATE TABLE Categories
(
CategoryID INT PRIMARY KEY IDENTITY(1,1),
CategoryName VARCHAR(100)
);
--Suppliers
CREATE TABLE Suppliers
(
SupplierID INT PRIMARY KEY IDENTITY(1,1),
SupplierName VARCHAR(100),
ContactPerson VARCHAR(100),
City VARCHAR(100)
);
--Products
CREATE TABLE Products
(
ProductID INT PRIMARY KEY IDENTITY(1,1),
ProductName VARCHAR(150),
CategoryID INT,
SupplierID INT,
UnitPrice DECIMAL(10,2),
StockQuantity INT,

CONSTRAINT FK_Product_Category
FOREIGN KEY(CategoryID)
REFERENCES Categories(CategoryID),

CONSTRAINT FK_Product_Supplier
FOREIGN KEY(SupplierID)
REFERENCES Suppliers(SupplierID)
);

--Orders
CREATE TABLE Orders
(
OrderID INT PRIMARY KEY IDENTITY(10001,1),
CustomerID INT,
DemployeeID INT,
OrderDate DATE,
Status VARCHAR(30),

FOREIGN KEY(CustomerID)
REFERENCES Customers(CustomerID),

FOREIGN KEY(CustomerID)
REFERENCES Employees(EmployeeID)
);

--OrderDetails
CREATE TABLE OrderDetails
(
OrderDatailID INT PRIMARY KEY IDENTITY(1,1),
OrderID INT,
ProductID INT,
Quantity INT,
UnitPrice DECIMAL(10,2),

FOREIGN KEY(OrderID)
REFERENCES Orders(OrderID),

FOREIGN KEY(ProductID)
REFERENCES Products(ProductID)
);

--Payments
CREATE TABLE Payments
(
PaymentID INT PRIMARY KEY IDENTITY(1,1),
OrderID INT,
PaymentDate DATE,
Amount DECIMAL(12,2),
PaymentMethod VARCHAR(30),

FOREIGN KEY(OrderID)
REFERENCES Orders(OrderID)
);

--Warehouses
CREATE TABLE Warehouses
(
WarehouseID INT PRIMARY KEY IDENTITY(1,1),
WarehouseName VARCHAR(100),
City VARCHAR(100)
);

--Inventory
CREATE TABLE Inventory
(
InventoryID INT PRIMARY KEY IDENTITY(1,1),
WarehouseID INT,
ProductID INT,
Quantity INT,

FOREIGN KEY(WarehouseID)
REFERENCES Warehouses(WarehouseID),

FOREIGN KEY(ProductID)
REFERENCES Products(ProductID)
);

--Shipments
CREATE TABLE Shipments
(
ShipmentID INT PRIMARY KEY IDENTITY(1,1),
OrderID INT,
ShipmentDate DATE,
Courier VARCHAR(100),
DeliveryStatus VARCHAR(30),

FOREIGN KEY(OrderID)
REFERENCES Orders(OrderID)
);

--Students
CREATE TABLE Students
(
StudentID INT PRIMARY KEY IDENTITY(1,1),
StudentName VARCHAR(100),
City VARCHAR(100)
);

--Courses
CREATE TABLE Courses
(
CourseID INT PRIMARY KEY IDENTITY(1,1),
CourseName VARCHAR(100),
Fees DECIMAL(10,2)
);

--ENrollments
CREATE TABLE Enrollments
(
EnrollmentID INT PRIMARY KEY IDENTITY(1,1),
StudentID INT,
CourseID INT,

FOREIGN KEY(StudentID)
REFERENCES Students(StudentID),

FOREIGN KEY(CourseID)
REFERENCES Courses(CourseID)
);

--Doctors
CREATE TABLE Doctors
(
DoctorID INT PRIMARY KEY IDENTITY(1,1),
DoctorName VARCHAR(100),
Specilization VARCHAR(100)
);

--Patients
CREATE TABLE Patients
(
PatientID INT PRIMARY KEY IDENTITY(1,1),
PatientName VARCHAR(100),
Gender CHAR(1)
);

--Appointments
CREATE TABLE Appointments
(
AppointmentID INT PRIMARY KEY IDENTITY(1,1),
PatientID INT,
DoctorID INT,
AppointmentDate DATE,

FOREIGN KEY(PatientID)
REFERENCES Patients(PatientID),

FOREIGN KEY(DoctorID)
REFERENCES Doctors(DoctorID)
);

--Bank Accounts
CREATE TABLE BankAccounts
(
AccountID INT PRIMARY KEY IDENTITY(10001,1),
CustomerID INT,
Balance MONEY,

FOREIGN KEY(CustomerID)
REFERENCES Customers(CustomerID)
);

--Transactions
CREATE TABLE Transactions
(
TransactionID INT PRIMARY KEY IDENTITY(1,1),
AccountID INT,
TransactionDate DATE,
TransactionType VARCHAR(20),
Amount MONEY,

FOREIGN KEY(AccountID)
REFERENCES BankAccounts(AccountID)
);
