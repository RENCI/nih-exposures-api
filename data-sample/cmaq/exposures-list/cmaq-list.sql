-- Format
-- exposureType,exposureUnit,startDate,endDate,resolution,aggregation
-- pm25,ugm3,2011-01-01,2011-12-31,hour;day,max;avg
DROP TABLE IF EXISTS cmaq_exposures_list;

-- create a temporary table for holding the raw data
CREATE TEMP TABLE tmp (
  exposure_type TEXT,
  exposure_unit TEXT,
  start_date TEXT,
  end_date TEXT,
  resolution TEXT,
  aggregation TEXT
);

-- copy the raw data from sample csv file
COPY tmp FROM '/cmaq-list.csv' DELIMITER ',' CSV HEADER ;

-- create a table to load data into named cmaq
CREATE TABLE IF NOT EXISTS cmaq_exposures_list (
  ID SERIAL UNIQUE PRIMARY KEY,
  EXPOSURE_TYPE TEXT,
  EXPOSURE_UNIT TEXT,
  START_DATE DATE,
  END_DATE DATE,
  RESOLUTION TEXT,
  AGGREGATION TEXT
);

-- load the exposure_type table with properly formatted data
INSERT INTO cmaq_exposures_list (EXPOSURE_TYPE, EXPOSURE_UNIT, START_DATE, END_DATE, RESOLUTION, AGGREGATION)
  SELECT
    exposure_type,
    exposure_unit,
    cast(START_DATE as DATE),
    cast(END_DATE as DATE),
    resolution,
    aggregation
  FROM tmp;

-- drop the temporary table
DROP TABLE tmp;

-- set owner to datatrans user
ALTER TABLE cmaq_exposures_list OWNER TO datatrans;

-- display a sample of contents to user
SELECT * FROM cmaq_exposures_list ORDER BY exposure_type ASC LIMIT 10;