-- Remove duplicate customers
WITH CTE AS (
    SELECT *,
    ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY CustomerKey) AS rn
    FROM DimCustomer
)
DELETE FROM CTE WHERE rn > 1;


-- Check for NULL values
SELECT * FROM Stg_Sales
WHERE CustomerID IS NULL
   OR ProductID IS NULL
   OR OrderDate IS NULL;
