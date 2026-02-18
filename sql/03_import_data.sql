BULK INSERT Stg_Sales
FROM 'C:\YourPath\sales_data_sample.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);


