-- drop prior function if it exists
DROP FUNCTION cmaq_o3_pmij_stats_row(TEXT, INT);

-- populate statistical data for o3 and pmij
-- o3: o3_avg_24, o3_max_24, o3_avg_7day, o3_max_7day, o3_avg_14day, o3_max_14day
-- pmij: pmij_avg_24, pmij_max_24, pmij_avg_7day, pmij_max_7day, pmij_avg_14day, pmij_max_14day
CREATE OR REPLACE FUNCTION cmaq_o3_pmij_stats_row (
  IN _yr TEXT,
  IN _r INT
)
RETURNS VOID
AS $$
  DECLARE start_date TIMESTAMP;
  DECLARE end_date TIMESTAMP;
  DECLARE min_row INT;
  DECLARE max_row INT;
  DECLARE min_col INT;
  DECLARE max_col INT;
BEGIN
    start_date := format('%s-01-01 00:00:00', _yr);
    end_date := format('%s-12-31 23:00:00', _yr);
    -- find cmaq grid size for year being calculated
    min_row := 1;
    min_col := 1;
    IF _yr = '2010' THEN
      max_row := 112;
      max_col := 148;
    ELSE
      max_row := 299;
      max_col := 459;
    END IF;
    -- loop through all columns in row = _r
    --RAISE NOTICE 'Processing Row: %', _r;
    FOR c IN min_col..max_col LOOP
      -- update the statistical fields for o3 and pmij
      UPDATE cmaq_exposures_data
      SET
          o3_avg_24=subquery.o3_avg_24,
          o3_max_24=subquery.o3_max_24,
          o3_avg_7day=subquery.o3_avg_7day,
          o3_max_7day=subquery.o3_max_7day,
          o3_avg_14day=subquery.o3_avg_14day,
          o3_max_14day=subquery.o3_max_14day,
          pmij_avg_24=subquery.pmij_avg_24,
          pmij_max_24=subquery.pmij_max_24,
          pmij_avg_7day=subquery.pmij_avg_7day,
          pmij_max_7day=subquery.pmij_max_7day,
          pmij_avg_14day=subquery.pmij_avg_14day,
          pmij_max_14day=subquery.pmij_max_14day
      FROM (
            SELECT cd.utc_date_time,
              avg(cd.o3)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 23 PRECEDING AND CURRENT ROW) AS o3_avg_24,
              max(cd.o3)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 23 PRECEDING AND CURRENT ROW) AS o3_max_24,
              avg(cd.o3)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 167 PRECEDING AND CURRENT ROW) AS o3_avg_7day,
              max(cd.o3)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 167 PRECEDING AND CURRENT ROW) AS o3_max_7day,
              avg(cd.o3)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 335 PRECEDING AND CURRENT ROW) AS o3_avg_14day,
              max(cd.o3)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 335 PRECEDING AND CURRENT ROW) AS o3_max_14day,
              avg(cd.pmij)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 23 PRECEDING AND CURRENT ROW) AS pmij_avg_24,
              max(cd.pmij)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 23 PRECEDING AND CURRENT ROW) AS pmij_max_24,
              avg(cd.pmij)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 167 PRECEDING AND CURRENT ROW) AS pmij_avg_7day,
              max(cd.pmij)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 167 PRECEDING AND CURRENT ROW) AS pmij_max_7day,
              avg(cd.pmij)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 335 PRECEDING AND CURRENT ROW) AS pmij_avg_14day,
              max(cd.pmij)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 335 PRECEDING AND CURRENT ROW) AS pmij_max_14day
            FROM cmaq_exposures_data cd
            WHERE cd.row = _r AND cd.col = c
            AND cd.utc_date_time >= start_date
            AND cd.utc_date_time <= end_date
           ) AS subquery
      WHERE cmaq_exposures_data.utc_date_time=subquery.utc_date_time
        AND cmaq_exposures_data.row=_r
        AND cmaq_exposures_data.col=c
        AND cmaq_exposures_data.utc_date_time >= start_date
        AND cmaq_exposures_data.utc_date_time <= end_date;
    END LOOP;
END; $$
LANGUAGE plpgsql;