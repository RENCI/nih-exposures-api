-- Alter table cmaq_exposures_data for form, ald2, aldx
-- form = Formaldehyde
-- ald2 = Acetaldehyde
-- aldx = Higher Aldehydes

ALTER TABLE cmaq_exposures_data ADD COLUMN IF NOT EXISTS form FLOAT;
ALTER TABLE cmaq_exposures_data ADD COLUMN IF NOT EXISTS form_avg_24 FLOAT;
ALTER TABLE cmaq_exposures_data ADD COLUMN IF NOT EXISTS form_max_24 FLOAT;
ALTER TABLE cmaq_exposures_data ADD COLUMN IF NOT EXISTS form_avg_7day FLOAT;
ALTER TABLE cmaq_exposures_data ADD COLUMN IF NOT EXISTS form_max_7day FLOAT;
ALTER TABLE cmaq_exposures_data ADD COLUMN IF NOT EXISTS form_avg_14day FLOAT;
ALTER TABLE cmaq_exposures_data ADD COLUMN IF NOT EXISTS form_max_14day FLOAT;
ALTER TABLE cmaq_exposures_data ADD COLUMN IF NOT EXISTS ald2 FLOAT;
ALTER TABLE cmaq_exposures_data ADD COLUMN IF NOT EXISTS ald2_avg_24 FLOAT;
ALTER TABLE cmaq_exposures_data ADD COLUMN IF NOT EXISTS ald2_max_24 FLOAT;
ALTER TABLE cmaq_exposures_data ADD COLUMN IF NOT EXISTS ald2_avg_7day FLOAT;
ALTER TABLE cmaq_exposures_data ADD COLUMN IF NOT EXISTS ald2_max_7day FLOAT;
ALTER TABLE cmaq_exposures_data ADD COLUMN IF NOT EXISTS ald2_avg_14day FLOAT;
ALTER TABLE cmaq_exposures_data ADD COLUMN IF NOT EXISTS ald2_max_14day FLOAT;
ALTER TABLE cmaq_exposures_data ADD COLUMN IF NOT EXISTS aldx FLOAT;
ALTER TABLE cmaq_exposures_data ADD COLUMN IF NOT EXISTS aldx_avg_24 FLOAT;
ALTER TABLE cmaq_exposures_data ADD COLUMN IF NOT EXISTS aldx_max_24 FLOAT;
ALTER TABLE cmaq_exposures_data ADD COLUMN IF NOT EXISTS aldx_avg_7day FLOAT;
ALTER TABLE cmaq_exposures_data ADD COLUMN IF NOT EXISTS aldx_max_7day FLOAT;
ALTER TABLE cmaq_exposures_data ADD COLUMN IF NOT EXISTS aldx_avg_14day FLOAT;
ALTER TABLE cmaq_exposures_data ADD COLUMN IF NOT EXISTS aldx_max_14day FLOAT;

-- set owner to datatrans user
ALTER TABLE cmaq_exposures_data OWNER TO datatrans;

-- display a sample of contents to user
SELECT * FROM cmaq_exposures_data ORDER BY utc_date_time ASC LIMIT 10;
