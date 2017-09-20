
-- Find all date, row, col where o3_avg_24, o3_max_24, pmij_avg_24 or pmij_max_24 is currently null
SELECT DISTINCT utc_date_time::date, row, col FROM cmaq WHERE o3_avg_24 ISNULL OR o3_max_24 ISNULL OR pmij_avg_24 ISNULL OR pmij_max_24 ISNULL ORDER BY utc_date_time, row, col;

-- Get date and date-1 data to calculate rolling 24 hours values
SELECT * FROM cmaq WHERE utc_date_time::date = '2011-01-03' OR utc_date_time::date + 1 = '2011-01-03' ORDER BY utc_date_time;