-- ================================================
-- Sales Analytics Dashboard - Stored Procedures
-- Author: Victor Torres
-- Description: Business logic for analytics operations
-- ================================================

USE SalesAnalyticsDW;
GO

-- ================================================
-- SP: Load Daily Sales Summary
-- Description: Aggregates daily sales for performance
-- ================================================
CREATE OR ALTER PROCEDURE sp_LoadDailySalesSummary
    @Date DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @Date IS NULL
        SET @Date = CAST(GETDATE() AS DATE);
    
    DECLARE @DateKey INT = CAST(FORMAT(@Date, 'yyyyMMdd') AS INT);
    
    -- Delete existing summary for the date
    DELETE FROM FactSalesSummary WHERE DateKey = @DateKey;
    
    -- Insert aggregated data
    INSERT INTO FactSalesSummary (DateKey, TotalOrders, TotalLineItems, TotalRevenue, TotalCost, 
                                  TotalProfit, AvgOrderValue, AvgProfitMargin, UniqueCustomers)
    SELECT 
        @DateKey,
        COUNT(DISTINCT OrderID),
        COUNT(*),
        SUM(TotalAmount),
        SUM(TotalCost),
        SUM(Profit),
        AVG(TotalAmount),
        CASE 
            WHEN SUM(TotalAmount) > 0 THEN CAST(SUM(Profit) * 100.0 / SUM(TotalAmount) AS DECIMAL(5,2))
            ELSE 0 
        END,
        COUNT(DISTINCT CustomerKey)
    FROM FactSales
    WHERE DateKey = @DateKey;
    
    SELECT 'Daily summary loaded for ' + CAST(@Date AS VARCHAR(10)) AS Message;
END;
GO

-- ================================================
-- SP: Calculate Customer Lifetime Value
-- Description: Calculates CLV for a customer
-- ================================================
CREATE OR ALTER PROCEDURE sp_CalculateCustomerLTV
    @CustomerKey INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        c.CustomerName,
        c.CustomerSegment,
        COUNT(DISTINCT f.OrderID) AS TotalOrders,
        SUM(f.TotalAmount) AS LifetimeValue,
        AVG(f.TotalAmount) AS AvgOrderValue,
        SUM(f.Profit) AS TotalProfit,
        MIN(d.Date) AS FirstPurchase,
        MAX(d.Date) AS LastPurchase,
        DATEDIFF(DAY, MIN(d.Date), MAX(d.Date)) AS CustomerLifespanDays,
        CASE 
            WHEN DATEDIFF(DAY, MIN(d.Date), MAX(d.Date)) > 0 
            THEN CAST(SUM(f.TotalAmount) / DATEDIFF(DAY, MIN(d.Date), MAX(d.Date)) AS DECIMAL(10,2))
            ELSE 0 
        END AS AvgDailyRevenue
    FROM FactSales f
    INNER JOIN DimCustomer c ON f.CustomerKey = c.CustomerKey
    INNER JOIN DimDate d ON f.DateKey = d.DateKey
    WHERE f.CustomerKey = @CustomerKey
    GROUP BY c.CustomerKey, c.CustomerName, c.CustomerSegment;
END;
GO

-- ================================================
-- SP: Get Sales Performance
-- Description: Returns KPIs for date range
-- ================================================
CREATE OR ALTER PROCEDURE sp_GetSalesPerformance
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        COUNT(DISTINCT OrderID) AS TotalOrders,
        COUNT(*) AS TotalLineItems,
        SUM(Quantity) AS TotalUnits,
        SUM(TotalAmount) AS TotalRevenue,
        SUM(TotalCost) AS TotalCost,
        SUM(Profit) AS TotalProfit,
        CAST(AVG(TotalAmount) AS DECIMAL(10,2)) AS AvgOrderValue,
        CASE 
            WHEN SUM(TotalAmount) > 0 
            THEN CAST(SUM(Profit) * 100.0 / SUM(TotalAmount) AS DECIMAL(5,2))
            ELSE 0 
        END AS ProfitMarginPercent,
        COUNT(DISTINCT CustomerKey) AS UniqueCustomers,
        COUNT(DISTINCT ProductKey) AS UniqueProducts
    FROM FactSales f
    INNER JOIN DimDate d ON f.DateKey = d.DateKey
    WHERE d.Date BETWEEN @StartDate AND @EndDate;
END;
GO

-- ================================================
-- SP: Get Top Products
-- Description: Returns top N products by revenue
-- ================================================
CREATE OR ALTER PROCEDURE sp_GetTopProducts
    @TopN INT = 10,
    @StartDate DATE = NULL,
    @EndDate DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @StartDate IS NULL
        SET @StartDate = DATEADD(MONTH, -1, GETDATE());
    IF @EndDate IS NULL
        SET @EndDate = GETDATE();
    
    SELECT TOP (@TopN)
        p.ProductName,
        c.CategoryName,
        COUNT(DISTINCT f.OrderID) AS Orders,
        SUM(f.Quantity) AS UnitsSold,
        SUM(f.TotalAmount) AS Revenue,
        SUM(f.Profit) AS Profit,
        CAST(SUM(f.Profit) * 100.0 / NULLIF(SUM(f.TotalAmount), 0) AS DECIMAL(5,2)) AS ProfitMargin
    FROM FactSales f
    INNER JOIN DimProduct p ON f.ProductKey = p.ProductKey
    INNER JOIN DimCategory c ON p.CategoryKey = c.CategoryKey
    INNER JOIN DimDate d ON f.DateKey = d.DateKey
    WHERE d.Date BETWEEN @StartDate AND @EndDate
    GROUP BY p.ProductKey, p.ProductName, c.CategoryName
    ORDER BY Revenue DESC;
END;
GO

-- ================================================
-- SP: Get Customer Segmentation (RFM)
-- Description: RFM analysis for all customers
-- ================================================
CREATE OR ALTER PROCEDURE sp_GetCustomerSegmentation
AS
BEGIN
    SET NOCOUNT ON;
    
    WITH CustomerRFM AS (
        SELECT 
            f.CustomerKey,
            c.CustomerName,
            DATEDIFF(DAY, MAX(d.Date), GETDATE()) AS Recency,
            COUNT(DISTINCT f.OrderID) AS Frequency,
            SUM(f.TotalAmount) AS MonetaryValue
        FROM FactSales f
        INNER JOIN DimCustomer c ON f.CustomerKey = c.CustomerKey
        INNER JOIN DimDate d ON f.DateKey = d.DateKey
        GROUP BY f.CustomerKey, c.CustomerName
    ),
    RFMScores AS (
        SELECT *,
            NTILE(5) OVER (ORDER BY Recency DESC) AS R_Score,
            NTILE(5) OVER (ORDER BY Frequency ASC) AS F_Score,
            NTILE(5) OVER (ORDER BY MonetaryValue ASC) AS M_Score
        FROM CustomerRFM
    )
    SELECT 
        CustomerKey,
        CustomerName,
        Recency AS DaysSinceLastPurchase,
        Frequency AS TotalOrders,
        CAST(MonetaryValue AS DECIMAL(10,2)) AS TotalSpent,
        R_Score,
        F_Score,
        M_Score,
        (R_Score + F_Score + M_Score) AS RFM_Total,
        CASE 
            WHEN R_Score >= 4 AND F_Score >= 4 THEN 'Champion'
            WHEN R_Score >= 3 AND F_Score >= 3 THEN 'Loyal'
            WHEN R_Score >= 4 AND F_Score <= 2 THEN 'New Customer'
            WHEN R_Score <= 2 AND F_Score >= 3 THEN 'At Risk'
            WHEN R_Score <= 2 AND F_Score <= 2 THEN 'Lost'
            ELSE 'Regular'
        END AS Segment
    FROM RFMScores
    ORDER BY RFM_Total DESC;
END;
GO

PRINT 'Stored procedures created successfully!';
GO
