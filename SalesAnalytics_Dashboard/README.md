# 📊 Sales Analytics Dashboard Data

> A comprehensive sales data warehouse for business intelligence and analytics

[![SQL Server](https://img.shields.io/badge/SQL_Server-CC2927?logo=microsoftsqlserver&logoColor=white)](https://www.microsoft.com/sql-server)
[![Data Warehouse](https://img.shields.io/badge/Data_Warehouse-Design-blue)](https://github.com/vitugo23/Sales-Analytics-Dashboard)
[![Analytics](https://img.shields.io/badge/Domain-Sales_Analytics-orange)](https://github.com/vitugo23/Sales-Analytics-Dashboard)

## Table of Contents

- [Overview](#overview)
- [My Contributions](#my-contributions)
- [Features](#features)
- [Database Schema](#database-schema)
- [Entity Relationship Diagram](#entity-relationship-diagram)
- [Setup Instructions](#setup-instructions)
- [Sample Queries](#sample-queries)
- [Stored Procedures](#stored-procedures)
- [Views](#views)
- [Technologies Used](#technologies-used)

## Overview

The Sales Analytics Dashboard Data system is a dimensional data warehouse designed for sales performance analysis, trend identification, and business intelligence reporting. It implements a star schema design optimized for analytical queries and supports complex time-series analysis, customer segmentation, and product performance metrics.

This project demonstrates expertise in data warehousing concepts, dimensional modeling, and advanced analytical SQL techniques essential for business intelligence roles.

### Key Highlights

- **Star Schema Design** - Optimized for analytical queries
- **Time-Series Analysis** - Historical sales trends and forecasting
- **Customer Analytics** - RFM analysis, segmentation, lifetime value
- **Product Performance** - Sales metrics, profitability analysis
- **Sales Territory Management** - Regional performance tracking
- **KPI Calculations** - Revenue, growth, margins, conversion rates
- **Year-over-Year Comparisons** - Trend analysis with historical data
- **Rolling Aggregations** - Moving averages, cumulative totals

## My Contributions

**Role**: Data Warehouse Architect & BI Developer

### Core Responsibilities

#### Dimensional Modeling & Star Schema Design
- Designed **star schema** with fact and dimension tables
- Created **date dimension** with full calendar attributes
- Implemented **slowly changing dimensions (SCD Type 2)** for historical tracking
- Optimized schema for **OLAP workloads** and reporting
- Established **grain definition** for fact tables
- Designed **surrogate keys** for dimension management

#### Complex Analytical Queries
- **Time-Series Analysis**: Year-over-year, month-over-month comparisons
- **Window Functions**: Running totals, moving averages, rankings
- **Customer Analytics**: RFM segmentation, cohort analysis
- **Sales Funnel Analysis**: Conversion rates, pipeline metrics
- **Product Mix Analysis**: Cross-selling, basket analysis
- **Territory Performance**: Regional sales comparison

#### Business Intelligence Logic
- **KPI Calculations**: Revenue, margin, growth rates
- **Trend Analysis**: Seasonal patterns, forecasting
- **Cohort Analysis**: Customer retention, lifetime value
- **ABC Analysis**: Product categorization by revenue
- **Pareto Analysis**: 80/20 rule implementation
- **Sales Variance**: Budget vs actual analysis

#### Performance Optimization
- Created **columnstore indexes** for analytical queries
- Implemented **partitioning** on fact tables by date
- Built **aggregate tables** for common reports
- Optimized **query execution plans**
- Designed **materialized views** for dashboards
- Established **indexing strategy** for dimensions

#### Data Quality & Integration
- Implemented **data validation** rules
- Created **ETL stored procedures** for data loading
- Built **incremental load patterns**
- Designed **error handling** and logging
- Established **referential integrity**

### Technical Skills Demonstrated

```
✓ Star Schema Design               ✓ Window Functions (Advanced)
✓ Dimensional Modeling             ✓ Common Table Expressions (CTEs)
✓ Data Warehousing Concepts        ✓ Recursive Queries
✓ Time-Series Analysis             ✓ Pivoting & Unpivoting
✓ Customer Segmentation            ✓ Date/Time Calculations
✓ KPI Development                  ✓ Statistical Functions
✓ OLAP Query Optimization          ✓ Aggregate Functions
✓ Columnstore Indexes              ✓ Table Partitioning
```

### Code Samples

**Year-over-Year Sales Growth**:
```sql
WITH YearlySales AS (
    SELECT 
        YEAR(OrderDate) AS Year,
        MONTH(OrderDate) AS Month,
        SUM(TotalAmount) AS Revenue
    FROM FactSales
    GROUP BY YEAR(OrderDate), MONTH(OrderDate)
)
SELECT 
    curr.Year,
    curr.Month,
    curr.Revenue AS CurrentRevenue,
    prev.Revenue AS PreviousYearRevenue,
    curr.Revenue - prev.Revenue AS GrowthAmount,
    CAST((curr.Revenue - prev.Revenue) * 100.0 / prev.Revenue AS DECIMAL(10,2)) AS GrowthPercent
FROM YearlySales curr
LEFT JOIN YearlySales prev 
    ON curr.Month = prev.Month 
    AND curr.Year = prev.Year + 1
ORDER BY curr.Year, curr.Month;
```

**Customer RFM Segmentation**:
```sql
WITH CustomerRFM AS (
    SELECT 
        CustomerID,
        DATEDIFF(DAY, MAX(OrderDate), GETDATE()) AS Recency,
        COUNT(DISTINCT OrderID) AS Frequency,
        SUM(TotalAmount) AS MonetaryValue
    FROM FactSales
    GROUP BY CustomerID
),
RFMScores AS (
    SELECT *,
        NTILE(5) OVER (ORDER BY Recency DESC) AS R_Score,
        NTILE(5) OVER (ORDER BY Frequency ASC) AS F_Score,
        NTILE(5) OVER (ORDER BY MonetaryValue ASC) AS M_Score
    FROM CustomerRFM
)
SELECT 
    CustomerID,
    R_Score, F_Score, M_Score,
    (R_Score + F_Score + M_Score) AS RFM_Total,
    CASE 
        WHEN R_Score >= 4 AND F_Score >= 4 THEN 'Champion'
        WHEN R_Score >= 3 AND F_Score >= 3 THEN 'Loyal'
        WHEN R_Score >= 4 AND F_Score <= 2 THEN 'New'
        WHEN R_Score <= 2 THEN 'At Risk'
        ELSE 'Regular'
    END AS CustomerSegment
FROM RFMScores;
```

**Moving Average with Window Functions**:
```sql
SELECT 
    OrderDate,
    DailyRevenue,
    AVG(DailyRevenue) OVER (
        ORDER BY OrderDate 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS SevenDayMovingAvg,
    AVG(DailyRevenue) OVER (
        ORDER BY OrderDate 
        ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
    ) AS ThirtyDayMovingAvg
FROM DailySalesAggregate
ORDER BY OrderDate;
```

---

## Features

### Sales Analytics
- Daily, weekly, monthly sales summaries
- Revenue and margin analysis
- Sales by product, category, region
- Sales rep performance tracking
- Order value analysis (AOV, total orders)
- Sales trend identification

### Customer Intelligence
- Customer lifetime value (CLV)
- RFM segmentation
- Customer acquisition analysis
- Repeat purchase rate
- Customer churn prediction
- Cohort analysis

### Product Analytics
- Product performance metrics
- Category sales analysis
- Product profitability
- Inventory turnover simulation
- Cross-sell analysis
- ABC classification

### Time-Based Analysis
- Year-over-year comparisons
- Month-over-month growth
- Seasonal pattern detection
- Day-of-week analysis
- Rolling period calculations
- Cumulative totals

### Territory Management
- Regional sales comparison
- Territory performance rankings
- Geographic analysis
- Sales rep assignments
- Market penetration metrics

## 🗄️ Database Schema

### Dimension Tables

1. **DimDate** - Complete date dimension with calendar attributes
2. **DimCustomer** - Customer master data
3. **DimProduct** - Product catalog information
4. **DimCategory** - Product categories hierarchy
5. **DimSalesRep** - Sales representative information
6. **DimTerritory** - Sales territories and regions
7. **DimPaymentMethod** - Payment types

### Fact Tables

1. **FactSales** - Sales transactions (grain: one row per order line item)
2. **FactSalesSummary** - Daily aggregated sales (for performance)

### Database Statistics

- **7 Dimension Tables** with slowly changing dimension support
- **2 Fact Tables** with millions of potential rows
- **200+ Sample Records** demonstrating realistic patterns
- **25+ Complex Analytical Queries**
- **10 Stored Procedures** for ETL and calculations
- **12 Views** for dashboards and reporting
- **Columnstore Indexes** for analytics performance

## Entity Relationship Diagram

```
                    ┌─────────────────┐
                    │     DimDate     │
                    ├─────────────────┤
                    │ DateKey PK      │
                    │ Date            │
                    │ Year            │
                    │ Quarter         │
                    │ Month           │
                    │ DayOfWeek       │
                    │ IsWeekend       │
                    │ IsHoliday       │
                    └─────────────────┘
                            │
                            │ 1:N
                            ▼
┌──────────────┐    ┌─────────────────┐    ┌──────────────┐
│ DimCustomer  │    │   FactSales     │    │  DimProduct  │
├──────────────┤    ├─────────────────┤    ├──────────────┤
│ CustomerKey  │◄───│ SalesKey PK     │───►│ ProductKey   │
│ CustomerID   │ N:1│ DateKey FK      │1:N │ ProductID    │
│ CustomerName │    │ CustomerKey FK  │    │ ProductName  │
│ Segment      │    │ ProductKey FK   │    │ CategoryKey  │
└──────────────┘    │ TerritoryKey FK │    │ UnitPrice    │
                    │ SalesRepKey FK  │    │ Cost         │
┌──────────────┐    │ Quantity        │    └──────────────┘
│DimSalesRep   │    │ UnitPrice       │            │
├──────────────┤    │ Discount        │            │ N:1
│ SalesRepKey  │◄───│ TotalAmount     │            ▼
│ RepName      │ N:1│ Cost            │    ┌──────────────┐
│ Region       │    │ Profit          │    │ DimCategory  │
└──────────────┘    └─────────────────┘    ├──────────────┤
                            │               │ CategoryKey  │
┌──────────────┐            │               │ CategoryName │
│DimTerritory  │            │ N:1           └──────────────┘
├──────────────┤            │
│TerritoryKey  │◄───────────┘
│ TerritoryName│
│ Region       │
│ Country      │
└──────────────┘

        ┌──────────────────────┐
        │  FactSalesSummary    │
        ├──────────────────────┤
        │ SummaryKey PK        │
        │ DateKey FK           │
        │ TotalOrders          │
        │ TotalRevenue         │
        │ TotalCost            │
        │ TotalProfit          │
        │ AvgOrderValue        │
        └──────────────────────┘
```

## Setup Instructions

### Prerequisites

- **SQL Server** 2019 or later
- **SQL Server Management Studio (SSMS)** or **Azure Data Studio**
- At least 500MB free disk space

### Installation Steps

#### 1. Clone or Download Repository

```bash
git clone https://github.com/vitugo23/Sales-Analytics-Dashboard.git
cd Sales-Analytics-Dashboard
```

#### 2. Execute SQL Scripts

**Option A: Master Setup Script**
```sql
-- Open SSMS or Azure Data Studio
-- Connect to SQL Server
-- Open and execute setup.sql
```

**Option B: Individual Scripts**
```sql
-- 1. Create schema
:r schema.sql

-- 2. Insert sample data
:r sample-data.sql

-- 3. Create stored procedures
:r stored-procedures.sql

-- 4. Create views
:r views.sql

-- 5. Create indexes
:r indexes.sql
```

#### 3. Verify Installation

```sql
USE SalesAnalyticsDW;
GO

-- Check tables
SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;

-- Verify data
SELECT 
    (SELECT COUNT(*) FROM DimCustomer) AS Customers,
    (SELECT COUNT(*) FROM DimProduct) AS Products,
    (SELECT COUNT(*) FROM FactSales) AS SalesTransactions;

-- Test a view
SELECT TOP 10 * FROM vw_DailySalesSummary 
ORDER BY SalesDate DESC;
```

## Sample Queries

### Sales Performance

#### Monthly Sales Trend
```sql
SELECT 
    d.Year,
    d.MonthName,
    COUNT(DISTINCT f.SalesKey) AS TotalOrders,
    SUM(f.TotalAmount) AS Revenue,
    SUM(f.Profit) AS Profit,
    CAST(AVG(f.TotalAmount) AS DECIMAL(10,2)) AS AvgOrderValue
FROM FactSales f
INNER JOIN DimDate d ON f.DateKey = d.DateKey
GROUP BY d.Year, d.Month, d.MonthName
ORDER BY d.Year, d.Month;
```

#### Top 10 Products by Revenue
```sql
SELECT TOP 10
    p.ProductName,
    c.CategoryName,
    COUNT(*) AS UnitsSold,
    SUM(f.TotalAmount) AS Revenue,
    SUM(f.Profit) AS Profit,
    CAST(SUM(f.Profit) * 100.0 / SUM(f.TotalAmount) AS DECIMAL(5,2)) AS ProfitMargin
FROM FactSales f
INNER JOIN DimProduct p ON f.ProductKey = p.ProductKey
INNER JOIN DimCategory c ON p.CategoryKey = c.CategoryKey
GROUP BY p.ProductKey, p.ProductName, c.CategoryName
ORDER BY Revenue DESC;
```

### Customer Analytics

#### Customer Lifetime Value
```sql
SELECT 
    c.CustomerName,
    c.Segment,
    COUNT(DISTINCT f.SalesKey) AS TotalOrders,
    SUM(f.TotalAmount) AS LifetimeValue,
    AVG(f.TotalAmount) AS AvgOrderValue,
    MAX(d.Date) AS LastPurchaseDate,
    DATEDIFF(DAY, MAX(d.Date), GETDATE()) AS DaysSinceLastPurchase
FROM FactSales f
INNER JOIN DimCustomer c ON f.CustomerKey = c.CustomerKey
INNER JOIN DimDate d ON f.DateKey = d.DateKey
GROUP BY c.CustomerKey, c.CustomerName, c.Segment
ORDER BY LifetimeValue DESC;
```

### Advanced Analytics

#### Year-over-Year Growth Analysis
```sql
WITH MonthlySales AS (
    SELECT 
        d.Year,
        d.Month,
        d.MonthName,
        SUM(f.TotalAmount) AS Revenue
    FROM FactSales f
    INNER JOIN DimDate d ON f.DateKey = d.DateKey
    GROUP BY d.Year, d.Month, d.MonthName
)
SELECT 
    curr.Year,
    curr.MonthName,
    curr.Revenue AS CurrentYearRevenue,
    prev.Revenue AS PriorYearRevenue,
    curr.Revenue - ISNULL(prev.Revenue, 0) AS GrowthAmount,
    CASE 
        WHEN prev.Revenue IS NULL OR prev.Revenue = 0 THEN NULL
        ELSE CAST((curr.Revenue - prev.Revenue) * 100.0 / prev.Revenue AS DECIMAL(10,2))
    END AS GrowthPercent
FROM MonthlySales curr
LEFT JOIN MonthlySales prev 
    ON curr.Month = prev.Month 
    AND curr.Year = prev.Year + 1
ORDER BY curr.Year DESC, curr.Month;
```

## Stored Procedures

### sp_LoadDailySalesSummary
Aggregates daily sales for performance

```sql
EXEC sp_LoadDailySalesSummary @Date = '2024-11-14';
```

### sp_CalculateCustomerLTV
Calculates customer lifetime value

```sql
EXEC sp_CalculateCustomerLTV @CustomerKey = 1;
```

### sp_GetSalesPerformance
Returns sales KPIs for date range

```sql
EXEC sp_GetSalesPerformance 
    @StartDate = '2024-01-01', 
    @EndDate = '2024-12-31';
```

## Views

### vw_DailySalesSummary
Daily sales aggregates for dashboards

### vw_CustomerSegmentation
RFM-based customer segments

### vw_ProductPerformance
Product sales metrics

### vw_TerritorySalesRanking
Regional performance comparison

### vw_SalesGrowthTrend
Month-over-month growth rates

## Technologies Used

- **SQL Server** - Data warehouse platform
- **T-SQL** - Query language
- **Star Schema** - Dimensional modeling
- **Columnstore Indexes** - Analytics optimization
- **Window Functions** - Advanced analytics
- **CTEs** - Complex query organization

## Skills Demonstrated

```
✓ Data Warehouse Design           ✓ Time-Series Analysis
✓ Star Schema Modeling            ✓ Customer Analytics
✓ Dimensional Modeling            ✓ Sales Forecasting
✓ OLAP Query Development          ✓ KPI Calculations
✓ Business Intelligence           ✓ Performance Tuning
✓ ETL Concepts                    ✓ Aggregate Tables
```
---
