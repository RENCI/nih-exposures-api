-- Format
DROP TABLE IF EXISTS form_ald2_aldx;

-- create temp table to hold new data
CREATE TEMP TABLE IF NOT EXISTS form_ald2_aldx (
  col   INT,
  lay   INT,
  row   INT,
  tstep TIMESTAMP,
  ald2  FLOAT,
  aldx  FLOAT,
  form  FLOAT,
  o3    FLOAT,
  pmij  FLOAT
);

COPY form_ald2_aldx FROM '/cmaq-update.csv' DELIMITER AS ',' CSV HEADER;

SELECT * FROM form_ald2_aldx ORDER BY tstep ASC LIMIT 10;

-- update cmaq_exposures_data table with form, ald2 and aldx data
UPDATE cmaq_exposures_data b
  SET
      (  ald2,   aldx,   form)
    = (a.ald2, a.aldx, a.form)
  FROM form_ald2_aldx a
  WHERE
    a.tstep = b.utc_date_time
    AND a.row = b.row
    AND a.col = b.col;

-- drop temp table after update
DROP TABLE IF EXISTS form_ald2_aldx;

-- display a sample of contents to user
SELECT row, col, utc_date_time, ald2, aldx, form
FROM cmaq_exposures_data
WHERE form IS NOT NULL
ORDER BY row, col, utc_date_time ASC LIMIT 10;
