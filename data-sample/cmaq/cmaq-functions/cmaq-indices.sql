-- index over col, row and utc_date_time
DROP INDEX cmaq_col_row_date;
CREATE UNIQUE INDEX CONCURRENTLY cmaq_col_row_date
  ON cmaq_exposures_data(col, row, utc_date_time);

-- index over utc_date_time
DROP INDEX cmaq_datetime;
CREATE INDEX CONCURRENTLY cmaq_datetime
  ON cmaq_exposures_data(utc_date_time);
