--TotalRevenue

SELECT SUM(Revenue) AS TotalRevenue
FROM FactSales;


--Monthly Sales

SELECT 
    d.Year,
    d.MonthName,
    SUM(f.Revenue) AS MonthlyRevenue
FROM FactSales f
JOIN DimDate d ON f.DateKey = d.DateKey
GROUP BY d.Year, d.MonthName
ORDER BY d.Year, MIN(d.Month);


--Top 5 Products by Revenue

SELECT TOP 5
    p.ProductName,
    SUM(f.Revenue) AS Revenue
FROM FactSales f
JOIN DimProduct p ON f.ProductKey = p.ProductKey
GROUP BY p.ProductName
ORDER BY Revenue DESC;


--Revenue by Region

SELECT
    c.Region,
    SUM(f.Revenue) AS Revenue
FROM FactSales f
JOIN DimCustomer c ON f.CustomerKey = c.CustomerKey
GROUP BY c.Region;
