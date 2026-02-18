--Create Staging Table

CREATE TABLE Stg_Sales (
    OrderID INT,
    OrderDate DATE,
    CustomerID VARCHAR(10),
    CustomerName VARCHAR(100),
    CustomerSegment VARCHAR(50),
    Region VARCHAR(50),
    ProductID VARCHAR(10),
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    Discount DECIMAL(5,2),
    PaymentMethod VARCHAR(50)
);

--Dimension Tables

CREATE TABLE DimCustomer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID VARCHAR(10),
    CustomerName VARCHAR(100),
    CustomerSegment VARCHAR(50),
    Region VARCHAR(50)
);

CREATE TABLE DimProduct (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,
    ProductID VARCHAR(10),
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);

CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY,
    OrderDate DATE,
    Year INT,
    Month INT,
    MonthName VARCHAR(20),
    Quarter INT
);


--Fact Table

CREATE TABLE FactSales (
    SalesKey INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    CustomerKey INT,
    ProductKey INT,
    DateKey INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    Discount DECIMAL(5,2),
    Revenue DECIMAL(12,2),
    PaymentMethod VARCHAR(50),

    FOREIGN KEY (CustomerKey) REFERENCES DimCustomer(CustomerKey),
    FOREIGN KEY (ProductKey) REFERENCES DimProduct(ProductKey),
    FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey)
);
