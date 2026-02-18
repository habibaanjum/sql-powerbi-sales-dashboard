--Insert into DimCustomer

INSERT INTO DimCustomer (CustomerID, CustomerName, CustomerSegment, Region)
SELECT DISTINCT
    CustomerID,
    CustomerName,
    CustomerSegment,
    Region
FROM Stg_Sales;


--Insert into DimProduct

INSERT INTO DimProduct (ProductID, ProductName, Category)
SELECT DISTINCT
    ProductID,
    ProductName,
    Category
FROM Stg_Sales;


--Insert into DimDate

INSERT INTO DimDate (DateKey, OrderDate, Year, Month, MonthName, Quarter)
SELECT DISTINCT
    CONVERT(INT, FORMAT(CONVERT(DATE, OrderDate), 'yyyyMMdd')) AS DateKey,
    CONVERT(DATE, OrderDate) AS OrderDate,
    YEAR(CONVERT(DATE, OrderDate)) AS Year,
    MONTH(CONVERT(DATE, OrderDate)) AS Month,
    DATENAME(MONTH, CONVERT(DATE, OrderDate)) AS MonthName,
    DATEPART(QUARTER, CONVERT(DATE, OrderDate)) AS Quarter
FROM Stg_Sales;


--Insert into FactSales

INSERT INTO FactSales (
    OrderID,
    CustomerKey,
    ProductKey,
    DateKey,
    Quantity,
    UnitPrice,
    Discount,
    Revenue,
    PaymentMethod
)
SELECT
    CAST(REPLACE(s.OrderID, '"', '') AS INT),
    c.CustomerKey,
    p.ProductKey,
    d.DateKey,
    CAST(REPLACE(s.Quantity, '"', '') AS INT),
    CAST(REPLACE(s.UnitPrice, '"', '') AS DECIMAL(10,2)),
    CAST(REPLACE(s.Discount, '"', '') AS DECIMAL(5,2)),
    
    CAST(REPLACE(s.Quantity, '"', '') AS INT) *
    CAST(REPLACE(s.UnitPrice, '"', '') AS DECIMAL(10,2)) *
    (1 - CAST(REPLACE(s.Discount, '"', '') AS DECIMAL(5,2))) AS Revenue,

    REPLACE(s.PaymentMethod, '"', '')
FROM Stg_Sales s
JOIN DimCustomer c 
    ON REPLACE(s.CustomerID, '"', '') = c.CustomerID
JOIN DimProduct p 
    ON REPLACE(s.ProductID, '"', '') = p.ProductID
JOIN DimDate d 
    ON CONVERT(DATE, REPLACE(s.OrderDate, '"', '')) = d.OrderDate;
