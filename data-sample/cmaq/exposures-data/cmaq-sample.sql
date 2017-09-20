-- Format
-- COL,LAY,ROW,TSTEP,O3,PMIJ
-- 1,0,1,2011-01-01 00:00:00,33.74245834350586,2.024115562438965
DROP TABLE IF EXISTS cmaq_exposures_data;

-- create a temporary table for holding the raw data
CREATE TEMP TABLE tmp (
  COL TEXT,
  LAY TEXT,
  ROW TEXT,
  TSTEP TEXT,
  O3 TEXT,
  PMIJ TEXT
);

-- copy the raw data from sample csv file
COPY tmp FROM '/cmaq-sample.csv' DELIMITER ',' CSV HEADER ;

-- create a table to load data into named cmaq
CREATE TABLE IF NOT EXISTS cmaq_exposures_data (
  ID              SERIAL UNIQUE PRIMARY KEY,
  COL             INT,
  ROW             INT,
  UTC_DATE_TIME   TIMESTAMP,
  O3              FLOAT,
  O3_AVG_24       FLOAT,
  O3_MAX_24       FLOAT,
  O3_AVG_7DAY     FLOAT,
  O3_MAX_7DAY     FLOAT,
  O3_AVG_14DAY    FLOAT,
  O3_MAX_14DAY    FLOAT,
  PMIJ            FLOAT,
  PMIJ_AVG_24     FLOAT,
  PMIJ_MAX_24     FLOAT,
  PMIJ_AVG_7DAY   FLOAT,
  PMIJ_MAX_7DAY   FLOAT,
  PMIJ_AVG_14DAY  FLOAT,
  PMIJ_MAX_14DAY  FLOAT
);

-- load the cmaq table with properly formatted data
INSERT INTO cmaq_exposures_data (COL, ROW, UTC_DATE_TIME, O3, PMIJ)
  SELECT
    cast(COL as INT),
    cast(ROW as INT),
    cast(TSTEP as TIMESTAMP),
    cast(O3 as FLOAT),
    cast(PMIJ as FLOAT)
  FROM tmp;

CREATE UNIQUE INDEX col_row_date
  ON cmaq_exposures_data(COL, ROW, UTC_DATE_TIME);

-- drop the temporary table
DROP TABLE tmp;

-- set owner to datatrans user
ALTER TABLE cmaq_exposures_data OWNER TO datatrans;

-- display a sample of contents to user
SELECT * FROM cmaq_exposures_data ORDER BY UTC_DATE_TIME ASC LIMIT 10;
