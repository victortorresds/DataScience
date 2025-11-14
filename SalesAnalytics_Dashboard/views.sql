-- ================================================
-- Sales Analytics Dashboard - Views
-- Author: Victor Torres
-- Description: Analytical views for dashboards
-- ================================================

USE SalesAnalyticsDW;
GO

-- ================================================
-- View: Daily Sales Summary
-- ================================================
CREATE OR ALTER VIEW vw_DailySalesSummary AS
SELECT 
    d.Date AS SalesDate,
    d.Year,
    d.Month,
    d.MonthName,
    d.DayName,
    d.IsWeekend,
    COUNT(DISTINCT f.OrderID) AS TotalOrders,
    SUM(f.Quantity) AS TotalUnits,
    SUM(f.TotalAmount) AS Revenue,
    SUM(f.Profit) AS Profit,
    CAST(AVG(f.TotalAmount) AS DECIMAL(10,2)) AS AvgOrderValue,
    COUNT(DISTINCT f.CustomerKey) AS UniqueCustomers
FROM FactSales f
INNER JOIN DimDate d ON f.DateKey = d.DateKey
GROUP BY d.Date, d.Year, d.Month, d.MonthName, d.DayName, d.IsWeekend;
GO

-- ================================================
-- View: Monthly Sales Trend
-- ================================================
CREATE OR ALTER VIEW vw_MonthlySalesTrend AS
SELECT 
    d.Year,
    d.Month,
    d.MonthName,
    d.Quarter,
    COUNT(DISTINCT f.OrderID) AS TotalOrders,
    SUM(f.TotalAmount) AS Revenue,
    SUM(f.Profit) AS Profit,
    CAST(SUM(f.Profit) * 100.0 / NULLIF(SUM(f.TotalAmount), 0) AS DECIMAL(5,2)) AS ProfitMargin,
    COUNT(DISTINCT f.CustomerKey) AS UniqueCustomers,
    CAST(AVG(f.TotalAmount) AS DECIMAL(10,2)) AS AvgOrderValue
FROM FactSales f
INNER JOIN DimDate d ON f.DateKey = d.DateKey
GROUP BY d.Year, d.Month, d.MonthName, d.Quarter;
GO

-- ================================================
-- View: Product Performance
-- ================================================
CREATE OR ALTER VIEW vw_ProductPerformance AS
SELECT 
    p.ProductKey,
    p.ProductName,
    c.CategoryName,
    p.Brand,
    COUNT(DISTINCT f.OrderID) AS TotalOrders,
    SUM(f.Quantity) AS UnitsSold,
    SUM(f.TotalAmount) AS Revenue,
    SUM(f.Profit) AS Profit,
    CAST(AVG(f.UnitPrice) AS DECIMAL(10,2)) AS AvgSellingPrice,
    CAST(SUM(f.Profit) * 100.0 / NULLIF(SUM(f.TotalAmount), 0) AS DECIMAL(5,2)) AS ProfitMargin
FROM FactSales f
INNER JOIN DimProduct p ON f.ProductKey = p.ProductKey
INNER JOIN DimCategory c ON p.CategoryKey = c.CategoryKey
WHERE p.IsCurrent = 1
GROUP BY p.ProductKey, p.ProductName, c.CategoryName, p.Brand;
GO

-- ================================================
-- View: Customer Analysis
-- ================================================
CREATE OR ALTER VIEW vw_CustomerAnalysis AS
SELECT 
    c.CustomerKey,
    c.CustomerName,
    c.CustomerSegment,
    c.City,
    c.State,
    COUNT(DISTINCT f.OrderID) AS TotalOrders,
    SUM(f.TotalAmount) AS LifetimeValue,
    CAST(AVG(f.TotalAmount) AS DECIMAL(10,2)) AS AvgOrderValue,
    MAX(d.Date) AS LastPurchaseDate,
    DATEDIFF(DAY, MAX(d.Date), GETDATE()) AS DaysSinceLastPurchase
FROM FactSales f
INNER JOIN DimCustomer c ON f.CustomerKey = c.CustomerKey
INNER JOIN DimDate d ON f.DateKey = d.DateKey
WHERE c.IsCurrent = 1
GROUP BY c.CustomerKey, c.CustomerName, c.CustomerSegment, c.City, c.State;
GO

-- ================================================
-- View: Territory Performance
-- ================================================
CREATE OR ALTER VIEW vw_TerritoryPerformance AS
SELECT 
    t.TerritoryName,
    t.Region,
    t.Country,
    COUNT(DISTINCT f.OrderID) AS TotalOrders,
    SUM(f.TotalAmount) AS Revenue,
    SUM(f.Profit) AS Profit,
    COUNT(DISTINCT f.CustomerKey) AS UniqueCustomers,
    CAST(AVG(f.TotalAmount) AS DECIMAL(10,2)) AS AvgOrderValue
FROM FactSales f
INNER JOIN DimTerritory t ON f.TerritoryKey = t.TerritoryKey
GROUP BY t.TerritoryKey, t.TerritoryName, t.Region, t.Country;
GO

-- ================================================
-- View: Sales Rep Performance
-- ================================================
CREATE OR ALTER VIEW vw_SalesRepPerformance AS
SELECT 
    sr.SalesRepKey,
    sr.FirstName + ' ' + sr.LastName AS SalesRepName,
    t.TerritoryName,
    COUNT(DISTINCT f.OrderID) AS TotalOrders,
    SUM(f.TotalAmount) AS Revenue,
    SUM(f.Profit) AS Profit,
    COUNT(DISTINCT f.CustomerKey) AS UniqueCustomers,
    CAST(AVG(f.TotalAmount) AS DECIMAL(10,2)) AS AvgOrderValue
FROM FactSales f
INNER JOIN DimSalesRep sr ON f.SalesRepKey = sr.SalesRepKey
INNER JOIN DimTerritory t ON sr.TerritoryKey = t.TerritoryKey
WHERE sr.IsActive = 1
GROUP BY sr.SalesRepKey, sr.FirstName, sr.LastName, t.TerritoryName;
GO

-- ================================================
-- View: Category Performance
-- ================================================
CREATE OR ALTER VIEW vw_CategoryPerformance AS
SELECT 
    c.CategoryName,
    COUNT(DISTINCT p.ProductKey) AS TotalProducts,
    COUNT(DISTINCT f.OrderID) AS TotalOrders,
    SUM(f.Quantity) AS UnitsSold,
    SUM(f.TotalAmount) AS Revenue,
    SUM(f.Profit) AS Profit,
    CAST(SUM(f.Profit) * 100.0 / NULLIF(SUM(f.TotalAmount), 0) AS DECIMAL(5,2)) AS ProfitMargin
FROM FactSales f
INNER JOIN DimProduct p ON f.ProductKey = p.ProductKey
INNER JOIN DimCategory c ON p.CategoryKey = c.CategoryKey
GROUP BY c.CategoryKey, c.CategoryName;
GO

-- ================================================
-- View: Year-over-Year Growth
-- ================================================
CREATE OR ALTER VIEW vw_YoYGrowth AS
WITH MonthlySales AS (
    SELECT 
        d.Year,
        d.Month,
        d.MonthName,
        SUM(f.TotalAmount) AS Revenue,
        SUM(f.Profit) AS Profit
    FROM FactSales f
    INNER JOIN DimDate d ON f.DateKey = d.DateKey
    GROUP BY d.Year, d.Month, d.MonthName
)
SELECT 
    curr.Year,
    curr.Month,
    curr.MonthName,
    CAST(curr.Revenue AS DECIMAL(10,2)) AS CurrentYearRevenue,
    CAST(ISNULL(prev.Revenue, 0) AS DECIMAL(10,2)) AS PriorYearRevenue,
    CAST(curr.Revenue - ISNULL(prev.Revenue, 0) AS DECIMAL(10,2)) AS GrowthAmount,
    CASE 
        WHEN prev.Revenue IS NULL OR prev.Revenue = 0 THEN NULL
        ELSE CAST((curr.Revenue - prev.Revenue) * 100.0 / prev.Revenue AS DECIMAL(10,2))
    END AS GrowthPercent
FROM MonthlySales curr
LEFT JOIN MonthlySales prev 
    ON curr.Month = prev.Month 
    AND curr.Year = prev.Year + 1;
GO

PRINT 'Views created successfully!';
GO
