BULK INSERT Stg_Sales
FROM 'C:\Users\Habiba Anjum\OneDrive\Documents\PowerBI_reports\sales_data_sample1.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

