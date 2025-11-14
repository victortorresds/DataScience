-- ================================================
-- Sales Analytics Dashboard - Sample Data
-- Author: Victor Torres
-- Description: Realistic sales data with trends
-- ================================================

USE SalesAnalyticsDW;
GO

PRINT 'Inserting sample data...';
GO

-- ================================================
-- Populate DimDate (Date Dimension)
-- Generate dates for 2 years
-- ================================================
DECLARE @StartDate DATE = '2023-01-01';
DECLARE @EndDate DATE = '2024-12-31';

WHILE @StartDate <= @EndDate
BEGIN
    INSERT INTO DimDate (DateKey, Date, Year, Quarter, Month, MonthName, Day, DayOfWeek, DayName, WeekOfYear, IsWeekend, IsHoliday, FiscalYear, FiscalQuarter)
    VALUES (
        CAST(FORMAT(@StartDate, 'yyyyMMdd') AS INT),
        @StartDate,
        YEAR(@StartDate),
        DATEPART(QUARTER, @StartDate),
        MONTH(@StartDate),
        DATENAME(MONTH, @StartDate),
        DAY(@StartDate),
        DATEPART(WEEKDAY, @StartDate),
        DATENAME(WEEKDAY, @StartDate),
        DATEPART(WEEK, @StartDate),
        CASE WHEN DATEPART(WEEKDAY, @StartDate) IN (1, 7) THEN 1 ELSE 0 END,
        CASE 
            WHEN @StartDate IN ('2023-01-01', '2023-07-04', '2023-11-23', '2023-12-25',
                               '2024-01-01', '2024-07-04', '2024-11-28', '2024-12-25') THEN 1 
            ELSE 0 
        END,
        CASE WHEN MONTH(@StartDate) >= 7 THEN YEAR(@StartDate) + 1 ELSE YEAR(@StartDate) END,
        CASE 
            WHEN MONTH(@StartDate) IN (7,8,9) THEN 1
            WHEN MONTH(@StartDate) IN (10,11,12) THEN 2
            WHEN MONTH(@StartDate) IN (1,2,3) THEN 3
            ELSE 4
        END
    );
    
    SET @StartDate = DATEADD(DAY, 1, @StartDate);
END
GO

PRINT 'Date dimension populated with ' + CAST((SELECT COUNT(*) FROM DimDate) AS VARCHAR) + ' rows';
GO

-- ================================================
-- Populate DimCategory
-- ================================================
INSERT INTO DimCategory (CategoryID, CategoryName, ParentCategoryKey, Description) VALUES
('CAT001', 'Electronics', NULL, 'Electronic devices and accessories'),
('CAT002', 'Computers', 1, 'Desktop and laptop computers'),
('CAT003', 'Smartphones', 1, 'Mobile phones and tablets'),
('CAT004', 'Audio', 1, 'Headphones and speakers'),
('CAT005', 'Home & Garden', NULL, 'Home improvement and garden supplies'),
('CAT006', 'Furniture', 5, 'Indoor and outdoor furniture'),
('CAT007', 'Appliances', 5, 'Kitchen and home appliances'),
('CAT008', 'Sports & Outdoors', NULL, 'Sports equipment and outdoor gear'),
('CAT009', 'Clothing', NULL, 'Apparel and fashion'),
('CAT010', 'Books', NULL, 'Books and magazines');
GO

-- ================================================
-- Populate DimProduct
-- ================================================
INSERT INTO DimProduct (ProductID, ProductName, CategoryKey, SKU, UnitPrice, Cost, Brand, IsCurrent) VALUES
-- Electronics - Computers
('PROD001', 'Dell XPS 15 Laptop', 2, 'COMP-001', 1499.99, 1050.00, 'Dell', 1),
('PROD002', 'MacBook Pro 14"', 2, 'COMP-002', 1999.99, 1400.00, 'Apple', 1),
('PROD003', 'HP Pavilion Desktop', 2, 'COMP-003', 799.99, 560.00, 'HP', 1),

-- Electronics - Smartphones
('PROD004', 'iPhone 14 Pro', 3, 'PHONE-001', 999.99, 700.00, 'Apple', 1),
('PROD005', 'Samsung Galaxy S23', 3, 'PHONE-002', 899.99, 630.00, 'Samsung', 1),
('PROD006', 'Google Pixel 7', 3, 'PHONE-003', 599.99, 420.00, 'Google', 1),

-- Electronics - Audio
('PROD007', 'Sony WH-1000XM5 Headphones', 4, 'AUDIO-001', 399.99, 240.00, 'Sony', 1),
('PROD008', 'Bose SoundLink Speaker', 4, 'AUDIO-002', 129.99, 78.00, 'Bose', 1),
('PROD009', 'AirPods Pro', 4, 'AUDIO-003', 249.99, 150.00, 'Apple', 1),

-- Home & Garden - Furniture
('PROD010', 'Modern Coffee Table', 6, 'FURN-001', 299.99, 180.00, 'IKEA', 1),
('PROD011', 'Ergonomic Office Chair', 6, 'FURN-002', 349.99, 210.00, 'Herman Miller', 1),
('PROD012', 'Queen Size Bed Frame', 6, 'FURN-003', 599.99, 360.00, 'Ashley', 1),

-- Home & Garden - Appliances
('PROD013', 'KitchenAid Stand Mixer', 7, 'APPL-001', 379.99, 228.00, 'KitchenAid', 1),
('PROD014', 'Dyson Vacuum Cleaner', 7, 'APPL-002', 499.99, 300.00, 'Dyson', 1),
('PROD015', 'Ninja Blender', 7, 'APPL-003', 99.99, 60.00, 'Ninja', 1),

-- Sports & Outdoors
('PROD016', 'Yoga Mat Premium', 8, 'SPORT-001', 49.99, 20.00, 'Manduka', 1),
('PROD017', 'Running Shoes', 8, 'SPORT-002', 129.99, 65.00, 'Nike', 1),
('PROD018', 'Camping Tent 4-Person', 8, 'SPORT-003', 199.99, 100.00, 'Coleman', 1),

-- Clothing
('PROD019', 'Men''s T-Shirt', 9, 'CLOTH-001', 24.99, 10.00, 'H&M', 1),
('PROD020', 'Women''s Jeans', 9, 'CLOTH-002', 79.99, 35.00, 'Levi''s', 1);
GO

-- ================================================
-- Populate DimTerritory
-- ================================================
INSERT INTO DimTerritory (TerritoryID, TerritoryName, Region, Country, Manager) VALUES
('TERR001', 'Northeast', 'East', 'USA', 'John Smith'),
('TERR002', 'Southeast', 'East', 'USA', 'Sarah Johnson'),
('TERR003', 'Midwest', 'Central', 'USA', 'Michael Brown'),
('TERR004', 'Southwest', 'West', 'USA', 'Emily Davis'),
('TERR005', 'West Coast', 'West', 'USA', 'David Wilson');
GO

-- ================================================
-- Populate DimSalesRep
-- ================================================
INSERT INTO DimSalesRep (SalesRepID, FirstName, LastName, Email, Phone, TerritoryKey, HireDate, IsActive) VALUES
('REP001', 'Alice', 'Anderson', 'alice.a@company.com', '555-1001', 1, '2021-03-15', 1),
('REP002', 'Bob', 'Baker', 'bob.b@company.com', '555-1002', 1, '2021-06-20', 1),
('REP003', 'Carol', 'Clark', 'carol.c@company.com', '555-1003', 2, '2022-01-10', 1),
('REP004', 'David', 'Davis', 'david.d@company.com', '555-1004', 3, '2022-04-05', 1),
('REP005', 'Eve', 'Evans', 'eve.e@company.com', '555-1005', 4, '2022-07-12', 1),
('REP006', 'Frank', 'Foster', 'frank.f@company.com', '555-1006', 5, '2023-02-18', 1);
GO

-- ================================================
-- Populate DimCustomer
-- ================================================
INSERT INTO DimCustomer (CustomerID, CustomerName, Email, Phone, Address, City, State, ZipCode, Country, CustomerSegment, IsCurrent) VALUES
('CUST001', 'Acme Corporation', 'contact@acme.com', '555-2001', '123 Business St', 'New York', 'NY', '10001', 'USA', 'Enterprise', 1),
('CUST002', 'Tech Solutions Inc', 'info@techsol.com', '555-2002', '456 Tech Ave', 'San Francisco', 'CA', '94105', 'USA', 'SMB', 1),
('CUST003', 'Global Retail Co', 'sales@globalretail.com', '555-2003', '789 Commerce Blvd', 'Chicago', 'IL', '60601', 'USA', 'Enterprise', 1),
('CUST004', 'John Doe', 'john.doe@email.com', '555-2004', '321 Main St', 'Boston', 'MA', '02101', 'USA', 'Individual', 1),
('CUST005', 'Jane Smith', 'jane.smith@email.com', '555-2005', '654 Oak Ave', 'Los Angeles', 'CA', '90001', 'USA', 'Individual', 1),
('CUST006', 'ABC Manufacturing', 'orders@abcmfg.com', '555-2006', '987 Industry Dr', 'Detroit', 'MI', '48201', 'USA', 'Enterprise', 1),
('CUST007', 'Small Business LLC', 'contact@smallbiz.com', '555-2007', '147 Local St', 'Austin', 'TX', '78701', 'USA', 'SMB', 1),
('CUST008', 'Mary Johnson', 'mary.j@email.com', '555-2008', '258 Elm St', 'Seattle', 'WA', '98101', 'USA', 'Individual', 1),
('CUST009', 'Retail Partners Inc', 'partners@retailinc.com', '555-2009', '369 Store Ln', 'Miami', 'FL', '33101', 'USA', 'SMB', 1),
('CUST010', 'Enterprise Solutions', 'info@entsol.com', '555-2010', '741 Corporate Pkwy', 'Dallas', 'TX', '75201', 'USA', 'Enterprise', 1);
GO

-- ================================================
-- Populate DimPaymentMethod
-- ================================================
INSERT INTO DimPaymentMethod (PaymentMethodID, PaymentType, Description) VALUES
('PAY001', 'Credit Card', 'Credit card payment'),
('PAY002', 'Debit Card', 'Debit card payment'),
('PAY003', 'PayPal', 'PayPal online payment'),
('PAY004', 'Bank Transfer', 'Direct bank transfer'),
('PAY005', 'Check', 'Check payment'),
('PAY006', 'Cash', 'Cash payment');
GO

-- ================================================
-- Populate FactSales with realistic transaction data
-- Generate sales for the past year with growth trend
-- ================================================
DECLARE @OrderCounter INT = 1;
DECLARE @SalesDate DATE = '2023-01-01';
DECLARE @MaxDate DATE = '2024-11-14';

WHILE @SalesDate <= @MaxDate
BEGIN
    -- Generate 5-15 orders per day (more on weekdays)
    DECLARE @OrdersToday INT = CASE 
        WHEN DATEPART(WEEKDAY, @SalesDate) IN (1, 7) THEN 5 + ABS(CHECKSUM(NEWID())) % 6  -- Weekend: 5-10 orders
        ELSE 10 + ABS(CHECKSUM(NEWID())) % 6  -- Weekday: 10-15 orders
    END;
    
    DECLARE @OrderNum INT = 1;
    WHILE @OrderNum <= @OrdersToday
    BEGIN
        DECLARE @OrderID NVARCHAR(50) = 'ORD' + FORMAT(@OrderCounter, '000000');
        DECLARE @DateKey INT = CAST(FORMAT(@SalesDate, 'yyyyMMdd') AS INT);
        
        -- Random customer, territory, sales rep
        DECLARE @CustomerKey INT = 1 + ABS(CHECKSUM(NEWID())) % 10;
        DECLARE @TerritoryKey INT = 1 + ABS(CHECKSUM(NEWID())) % 5;
        DECLARE @SalesRepKey INT = 1 + ABS(CHECKSUM(NEWID())) % 6;
        DECLARE @PaymentKey INT = 1 + ABS(CHECKSUM(NEWID())) % 6;
        
        -- Each order has 1-4 line items
        DECLARE @LineItems INT = 1 + ABS(CHECKSUM(NEWID())) % 4;
        DECLARE @LineNum INT = 1;
        
        WHILE @LineNum <= @LineItems
        BEGIN
            DECLARE @ProductKey INT = 1 + ABS(CHECKSUM(NEWID())) % 20;
            DECLARE @Quantity INT = 1 + ABS(CHECKSUM(NEWID())) % 5;
            DECLARE @Discount DECIMAL(5,2) = CASE 
                WHEN ABS(CHECKSUM(NEWID())) % 10 < 3 THEN 5 + ABS(CHECKSUM(NEWID())) % 16  -- 30% chance of 5-20% discount
                ELSE 0 
            END;
            
            -- Get product price and cost
            DECLARE @UnitPrice DECIMAL(10,2), @Cost DECIMAL(10,2);
            SELECT @UnitPrice = UnitPrice, @Cost = Cost 
            FROM DimProduct 
            WHERE ProductKey = @ProductKey;
            
            INSERT INTO FactSales (DateKey, CustomerKey, ProductKey, TerritoryKey, SalesRepKey, PaymentMethodKey, 
                                   OrderID, OrderLineNumber, Quantity, UnitPrice, Discount, Cost)
            VALUES (@DateKey, @CustomerKey, @ProductKey, @TerritoryKey, @SalesRepKey, @PaymentKey,
                    @OrderID, @LineNum, @Quantity, @UnitPrice, @Discount, @Cost);
            
            SET @LineNum = @LineNum + 1;
        END
        
        SET @OrderNum = @OrderNum + 1;
        SET @OrderCounter = @OrderCounter + 1;
    END
    
    SET @SalesDate = DATEADD(DAY, 1, @SalesDate);
END
GO

PRINT 'Sample data inserted successfully!';
PRINT '';
PRINT 'Database Statistics:';

DECLARE @Stats NVARCHAR(MAX);

SELECT @Stats = '- Date Records: ' + CAST(COUNT(*) AS VARCHAR(10)) FROM DimDate;
PRINT @Stats;

SELECT @Stats = '- Categories: ' + CAST(COUNT(*) AS VARCHAR(10)) FROM DimCategory;
PRINT @Stats;

SELECT @Stats = '- Products: ' + CAST(COUNT(*) AS VARCHAR(10)) FROM DimProduct;
PRINT @Stats;

SELECT @Stats = '- Customers: ' + CAST(COUNT(*) AS VARCHAR(10)) FROM DimCustomer;
PRINT @Stats;

SELECT @Stats = '- Territories: ' + CAST(COUNT(*) AS VARCHAR(10)) FROM DimTerritory;
PRINT @Stats;

SELECT @Stats = '- Sales Reps: ' + CAST(COUNT(*) AS VARCHAR(10)) FROM DimSalesRep;
PRINT @Stats;

SELECT @Stats = '- Sales Transactions: ' + CAST(COUNT(*) AS VARCHAR(10)) FROM FactSales;
PRINT @Stats;

SELECT @Stats = '- Total Revenue: $' + FORMAT(SUM(TotalAmount), 'N2') FROM FactSales;
PRINT @Stats;

SELECT @Stats = '- Total Profit: $' + FORMAT(SUM(Profit), 'N2') FROM FactSales;
PRINT @Stats;

GO
