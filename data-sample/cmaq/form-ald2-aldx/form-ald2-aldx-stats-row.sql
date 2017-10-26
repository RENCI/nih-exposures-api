-- drop prior function if it exists
DROP FUNCTION IF EXISTS cmaq_form_ald2_aldx_stats_row(TEXT, INT);

-- populate statistical data for o3 and pmij
-- o3: o3_avg_24, o3_max_24, o3_avg_7day, o3_max_7day, o3_avg_14day, o3_max_14day
-- pmij: pmij_avg_24, pmij_max_24, pmij_avg_7day, pmij_max_7day, pmij_avg_14day, pmij_max_14day
CREATE OR REPLACE FUNCTION cmaq_form_ald2_aldx_stats_row (
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
          form_avg_24=subquery.form_avg_24,
          form_max_24=subquery.form_max_24,
          form_avg_7day=subquery.form_avg_7day,
          form_max_7day=subquery.form_max_7day,
          form_avg_14day=subquery.form_avg_14day,
          form_max_14day=subquery.form_max_14day,
          ald2_avg_24=subquery.ald2_avg_24,
          ald2_max_24=subquery.ald2_max_24,
          ald2_avg_7day=subquery.ald2_avg_7day,
          ald2_max_7day=subquery.ald2_max_7day,
          ald2_avg_14day=subquery.ald2_avg_14day,
          ald2_max_14day=subquery.ald2_max_14day,
          aldx_avg_24=subquery.aldx_avg_24,
          aldx_max_24=subquery.aldx_max_24,
          aldx_avg_7day=subquery.aldx_avg_7day,
          aldx_max_7day=subquery.aldx_max_7day,
          aldx_avg_14day=subquery.aldx_avg_14day,
          aldx_max_14day=subquery.aldx_max_14day
      FROM (
            SELECT cd.utc_date_time,
              avg(cd.form)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 23 PRECEDING AND CURRENT ROW) AS form_avg_24,
              max(cd.form)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 23 PRECEDING AND CURRENT ROW) AS form_max_24,
              avg(cd.form)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 167 PRECEDING AND CURRENT ROW) AS form_avg_7day,
              max(cd.form)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 167 PRECEDING AND CURRENT ROW) AS form_max_7day,
              avg(cd.form)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 335 PRECEDING AND CURRENT ROW) AS form_avg_14day,
              max(cd.form)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 335 PRECEDING AND CURRENT ROW) AS form_max_14day,
              avg(cd.ald2)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 23 PRECEDING AND CURRENT ROW) AS ald2_avg_24,
              max(cd.ald2)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 23 PRECEDING AND CURRENT ROW) AS ald2_max_24,
              avg(cd.ald2)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 167 PRECEDING AND CURRENT ROW) AS ald2_avg_7day,
              max(cd.ald2)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 167 PRECEDING AND CURRENT ROW) AS ald2_max_7day,
              avg(cd.ald2)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 335 PRECEDING AND CURRENT ROW) AS ald2_avg_14day,
              max(cd.ald2)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 335 PRECEDING AND CURRENT ROW) AS ald2_max_14day,
              avg(cd.aldx)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 23 PRECEDING AND CURRENT ROW) AS aldx_avg_24,
              max(cd.aldx)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 23 PRECEDING AND CURRENT ROW) AS aldx_max_24,
              avg(cd.aldx)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 167 PRECEDING AND CURRENT ROW) AS aldx_avg_7day,
              max(cd.aldx)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 167 PRECEDING AND CURRENT ROW) AS aldx_max_7day,
              avg(cd.aldx)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 335 PRECEDING AND CURRENT ROW) AS aldx_avg_14day,
              max(cd.aldx)
                OVER (ORDER BY cd.utc_date_time ROWS BETWEEN 335 PRECEDING AND CURRENT ROW) AS aldx_max_14day
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