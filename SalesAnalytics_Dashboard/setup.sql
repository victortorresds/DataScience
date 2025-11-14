-- ================================================
-- Sales Analytics Dashboard - Master Setup Script
-- Author: Victor Torres
-- Description: Complete data warehouse setup
-- ================================================

PRINT '================================================';
PRINT 'Sales Analytics Dashboard Data Warehouse Setup';
PRINT 'Author: Victor Torres';
PRINT '================================================';
PRINT '';

-- Execute Schema Creation
PRINT 'Step 1: Creating data warehouse schema...';
:r schema.sql
PRINT 'Schema created successfully!';
PRINT '';

-- Execute Sample Data
PRINT 'Step 2: Loading sample data...';
PRINT 'This may take a minute - generating realistic sales data...';
:r sample-data.sql
PRINT 'Sample data loaded successfully!';
PRINT '';

-- Execute Stored Procedures
PRINT 'Step 3: Creating stored procedures...';
:r stored-procedures.sql
PRINT 'Stored procedures created successfully!';
PRINT '';

-- Execute Views
PRINT 'Step 4: Creating analytical views...';
:r views.sql
PRINT 'Views created successfully!';
PRINT '';

PRINT '================================================';
PRINT 'Data warehouse setup completed successfully!';
PRINT '================================================';
PRINT '';
PRINT 'You can now:';
PRINT '1. Query analytical views (SELECT * FROM vw_DailySalesSummary)';
PRINT '2. Execute analytics procedures (EXEC sp_GetTopProducts @TopN = 10)';
PRINT '3. Perform time-series analysis';
PRINT '';
PRINT 'Sample queries to try:';
PRINT '  - SELECT * FROM vw_MonthlySalesTrend ORDER BY Year DESC, Month DESC;';
PRINT '  - SELECT * FROM vw_ProductPerformance ORDER BY Revenue DESC;';
PRINT '  - EXEC sp_GetCustomerSegmentation;';
PRINT '  - SELECT * FROM vw_YoYGrowth WHERE Year >= 2024;';
PRINT '';
PRINT 'For daily summaries, run:';
PRINT '  - EXEC sp_LoadDailySalesSummary;';
PRINT '';
