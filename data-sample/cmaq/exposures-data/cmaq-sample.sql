-- Format
-- id,col,row,utc_date_time,o3,o3_avg_24,o3_max_24,o3_avg_7day,o3_max_7day,o3_avg_14day,o3_max_14day,
--     pmij,pmij_avg_24,pmij_max_24,pmij_avg_7day,pmij_max_7day,pmij_avg_14day,pmij_max_14day
-- 132873217,1,1,2010-12-01 00:00:00,53.2187423706055,,,,,,,
--     1.14570212364197,,,,,,
DROP TABLE IF EXISTS cmaq_exposures_data;

-- create a table to load data into named cmaq
CREATE TABLE IF NOT EXISTS cmaq_exposures_data (
  id              SERIAL UNIQUE PRIMARY KEY,
  col             INT,
  row             INT,
  utc_date_time   TIMESTAMP,
  o3              FLOAT,
  o3_avg_24       FLOAT,
  o3_max_24       FLOAT,
  o3_avg_7day     FLOAT,
  o3_max_7day     FLOAT,
  o3_avg_14day    FLOAT,
  o3_max_14day    FLOAT,
  pmij            FLOAT,
  pmij_avg_24       FLOAT,
  pmij_max_24       FLOAT,
  pmij_avg_7day     FLOAT,
  pmij_max_7day     FLOAT,
  pmij_avg_14day    FLOAT,
  pmij_max_14day    FLOAT
);

COPY cmaq_exposures_data FROM '/cmaq-sample.csv' DELIMITER AS ',' CSV HEADER;

-- set owner to datatrans user
ALTER TABLE cmaq_exposures_data OWNER TO datatrans;

-- display a sample of contents to user
SELECT * FROM cmaq_exposures_data ORDER BY utc_date_time ASC LIMIT 10;
