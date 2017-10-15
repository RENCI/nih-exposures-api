-- drop prior function if it exists
DROP FUNCTION cmaq_grid_size(TEXT);

-- find grid size in CMAQ for a particular year
CREATE OR REPLACE FUNCTION cmaq_grid_size (
  IN  _yr TEXT,
  OUT min_row INT,
  OUT max_row INT,
  OUT min_col INT,
  OUT max_col INT
)
AS $$
  DECLARE cmaq_year TIMESTAMP;
BEGIN
    cmaq_year = format('%s-01-01 12:00:00', _yr);
    RAISE NOTICE 'Check grid using date: %', cmaq_year;
    SELECT
      min(cd.row), max(cd.row), min(cd.col), max(cd.col)
    INTO
      min_row, max_row, min_col, max_col
    FROM cmaq_exposures_data cd
    WHERE cd.utc_date_time = cmaq_year;
END; $$
LANGUAGE plpgsql;

