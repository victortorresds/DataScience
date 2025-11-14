-- ================================================
-- Sales Analytics Dashboard - Data Warehouse Schema
-- Author: Victor Torres
-- Description: Star schema design for sales analytics
-- ================================================

USE master;
GO

-- Drop database if exists
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'SalesAnalyticsDW')
BEGIN
    ALTER DATABASE SalesAnalyticsDW SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE SalesAnalyticsDW;
END
GO

-- Create database
CREATE DATABASE SalesAnalyticsDW;
GO

USE SalesAnalyticsDW;
GO

PRINT 'Creating Sales Analytics Data Warehouse schema...';
GO

-- ================================================
-- DIMENSION TABLES
-- ================================================

-- ================================================
-- DimDate - Date Dimension (Type 1 SCD)
-- ================================================
CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY,  -- Format: YYYYMMDD
    Date DATE NOT NULL UNIQUE,
    Year INT NOT NULL,
    Quarter INT NOT NULL CHECK (Quarter BETWEEN 1 AND 4),
    Month INT NOT NULL CHECK (Month BETWEEN 1 AND 12),
    MonthName NVARCHAR(20) NOT NULL,
    Day INT NOT NULL CHECK (Day BETWEEN 1 AND 31),
    DayOfWeek INT NOT NULL CHECK (DayOfWeek BETWEEN 1 AND 7),
    DayName NVARCHAR(20) NOT NULL,
    WeekOfYear INT NOT NULL,
    IsWeekend BIT NOT NULL DEFAULT 0,
    IsHoliday BIT NOT NULL DEFAULT 0,
    FiscalYear INT NOT NULL,
    FiscalQuarter INT NOT NULL
);
GO

-- ================================================
-- DimCustomer - Customer Dimension (Type 2 SCD)
-- ================================================
CREATE TABLE DimCustomer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,  -- Surrogate key
    CustomerID NVARCHAR(50) NOT NULL,           -- Natural key
    CustomerName NVARCHAR(200) NOT NULL,
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    Address NVARCHAR(200),
    City NVARCHAR(100),
    State NVARCHAR(50),
    ZipCode NVARCHAR(20),
    Country NVARCHAR(50) DEFAULT 'USA',
    CustomerSegment NVARCHAR(50),  -- Individual, SMB, Enterprise
    -- SCD Type 2 fields
    EffectiveDate DATE NOT NULL DEFAULT GETDATE(),
    EndDate DATE NULL,
    IsCurrent BIT NOT NULL DEFAULT 1,
    -- Metadata
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE()
);
GO

CREATE INDEX IX_DimCustomer_CustomerID ON DimCustomer(CustomerID);
CREATE INDEX IX_DimCustomer_IsCurrent ON DimCustomer(IsCurrent);
GO

-- ================================================
-- DimCategory - Product Category Dimension
-- ================================================
CREATE TABLE DimCategory (
    CategoryKey INT IDENTITY(1,1) PRIMARY KEY,
    CategoryID NVARCHAR(50) NOT NULL UNIQUE,
    CategoryName NVARCHAR(100) NOT NULL,
    ParentCategoryKey INT NULL,
    Description NVARCHAR(500),
    CONSTRAINT FK_Category_Parent FOREIGN KEY (ParentCategoryKey) 
        REFERENCES DimCategory(CategoryKey)
);
GO

-- ================================================
-- DimProduct - Product Dimension (Type 2 SCD)
-- ================================================
CREATE TABLE DimProduct (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,   -- Surrogate key
    ProductID NVARCHAR(50) NOT NULL,            -- Natural key
    ProductName NVARCHAR(200) NOT NULL,
    CategoryKey INT NOT NULL,
    SKU NVARCHAR(50),
    UnitPrice DECIMAL(10,2) NOT NULL,
    Cost DECIMAL(10,2) NOT NULL,
    Brand NVARCHAR(100),
    Size NVARCHAR(50),
    Color NVARCHAR(50),
    Weight DECIMAL(10,2),
    -- SCD Type 2 fields
    EffectiveDate DATE NOT NULL DEFAULT GETDATE(),
    EndDate DATE NULL,
    IsCurrent BIT NOT NULL DEFAULT 1,
    -- Metadata
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Product_Category FOREIGN KEY (CategoryKey) 
        REFERENCES DimCategory(CategoryKey)
);
GO

CREATE INDEX IX_DimProduct_ProductID ON DimProduct(ProductID);
CREATE INDEX IX_DimProduct_Category ON DimProduct(CategoryKey);
CREATE INDEX IX_DimProduct_IsCurrent ON DimProduct(IsCurrent);
GO

-- ================================================
-- DimTerritory - Sales Territory Dimension
-- ================================================
CREATE TABLE DimTerritory (
    TerritoryKey INT IDENTITY(1,1) PRIMARY KEY,
    TerritoryID NVARCHAR(50) NOT NULL UNIQUE,
    TerritoryName NVARCHAR(100) NOT NULL,
    Region NVARCHAR(100) NOT NULL,
    Country NVARCHAR(50) NOT NULL,
    Manager NVARCHAR(100)
);
GO

-- ================================================
-- DimSalesRep - Sales Representative Dimension
-- ================================================
CREATE TABLE DimSalesRep (
    SalesRepKey INT IDENTITY(1,1) PRIMARY KEY,
    SalesRepID NVARCHAR(50) NOT NULL UNIQUE,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    TerritoryKey INT,
    HireDate DATE,
    IsActive BIT DEFAULT 1,
    CONSTRAINT FK_SalesRep_Territory FOREIGN KEY (TerritoryKey) 
        REFERENCES DimTerritory(TerritoryKey)
);
GO

CREATE INDEX IX_DimSalesRep_Territory ON DimSalesRep(TerritoryKey);
GO

-- ================================================
-- DimPaymentMethod - Payment Method Dimension
-- ================================================
CREATE TABLE DimPaymentMethod (
    PaymentMethodKey INT IDENTITY(1,1) PRIMARY KEY,
    PaymentMethodID NVARCHAR(50) NOT NULL UNIQUE,
    PaymentType NVARCHAR(50) NOT NULL,  -- Credit Card, Cash, Check, etc.
    Description NVARCHAR(200)
);
GO

-- ================================================
-- FACT TABLES
-- ================================================

-- ================================================
-- FactSales - Sales Transactions (Grain: Order Line Item)
-- ================================================
CREATE TABLE FactSales (
    SalesKey BIGINT IDENTITY(1,1) PRIMARY KEY,
    
    -- Dimension foreign keys
    DateKey INT NOT NULL,
    CustomerKey INT NOT NULL,
    ProductKey INT NOT NULL,
    TerritoryKey INT NOT NULL,
    SalesRepKey INT NOT NULL,
    PaymentMethodKey INT NOT NULL,
    
    -- Degenerate dimensions (not in dimension tables)
    OrderID NVARCHAR(50) NOT NULL,
    OrderLineNumber INT NOT NULL,
    
    -- Measures (facts)
    Quantity INT NOT NULL CHECK (Quantity > 0),
    UnitPrice DECIMAL(10,2) NOT NULL,
    Discount DECIMAL(5,2) DEFAULT 0 CHECK (Discount BETWEEN 0 AND 100),
    TotalAmount AS (Quantity * UnitPrice * (1 - Discount/100)) PERSISTED,
    Cost DECIMAL(10,2) NOT NULL,
    TotalCost AS (Quantity * Cost) PERSISTED,
    Profit AS (Quantity * UnitPrice * (1 - Discount/100) - Quantity * Cost) PERSISTED,
    
    -- Metadata
    CreatedDate DATETIME DEFAULT GETDATE(),
    
    -- Constraints
    CONSTRAINT FK_FactSales_Date FOREIGN KEY (DateKey) 
        REFERENCES DimDate(DateKey),
    CONSTRAINT FK_FactSales_Customer FOREIGN KEY (CustomerKey) 
        REFERENCES DimCustomer(CustomerKey),
    CONSTRAINT FK_FactSales_Product FOREIGN KEY (ProductKey) 
        REFERENCES DimProduct(ProductKey),
    CONSTRAINT FK_FactSales_Territory FOREIGN KEY (TerritoryKey) 
        REFERENCES DimTerritory(TerritoryKey),
    CONSTRAINT FK_FactSales_SalesRep FOREIGN KEY (SalesRepKey) 
        REFERENCES DimSalesRep(SalesRepKey),
    CONSTRAINT FK_FactSales_PaymentMethod FOREIGN KEY (PaymentMethodKey) 
        REFERENCES DimPaymentMethod(PaymentMethodKey)
);
GO

-- Indexes for FactSales
CREATE INDEX IX_FactSales_Date ON FactSales(DateKey);
CREATE INDEX IX_FactSales_Customer ON FactSales(CustomerKey);
CREATE INDEX IX_FactSales_Product ON FactSales(ProductKey);
CREATE INDEX IX_FactSales_Territory ON FactSales(TerritoryKey);
CREATE INDEX IX_FactSales_SalesRep ON FactSales(SalesRepKey);
CREATE INDEX IX_FactSales_OrderID ON FactSales(OrderID);

-- Composite indexes for common query patterns
CREATE INDEX IX_FactSales_Date_Customer ON FactSales(DateKey, CustomerKey);
CREATE INDEX IX_FactSales_Date_Product ON FactSales(DateKey, ProductKey);
GO

-- ================================================
-- FactSalesSummary - Daily Aggregated Sales
-- Purpose: Pre-aggregated for dashboard performance
-- ================================================
CREATE TABLE FactSalesSummary (
    SummaryKey BIGINT IDENTITY(1,1) PRIMARY KEY,
    DateKey INT NOT NULL,
    
    -- Aggregated measures
    TotalOrders INT NOT NULL DEFAULT 0,
    TotalLineItems INT NOT NULL DEFAULT 0,
    TotalRevenue DECIMAL(18,2) NOT NULL DEFAULT 0,
    TotalCost DECIMAL(18,2) NOT NULL DEFAULT 0,
    TotalProfit DECIMAL(18,2) NOT NULL DEFAULT 0,
    AvgOrderValue DECIMAL(10,2) NOT NULL DEFAULT 0,
    AvgProfitMargin DECIMAL(5,2) NOT NULL DEFAULT 0,
    UniqueCustomers INT NOT NULL DEFAULT 0,
    
    -- Metadata
    CreatedDate DATETIME DEFAULT GETDATE(),
    LastUpdated DATETIME DEFAULT GETDATE(),
    
    CONSTRAINT FK_FactSummary_Date FOREIGN KEY (DateKey) 
        REFERENCES DimDate(DateKey),
    CONSTRAINT UQ_Summary_Date UNIQUE (DateKey)
);
GO

CREATE INDEX IX_FactSummary_Date ON FactSalesSummary(DateKey);
GO

PRINT 'Schema created successfully!';
PRINT 'Star schema with 7 dimension tables and 2 fact tables ready.';
GO
