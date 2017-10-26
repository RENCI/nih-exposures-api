## Adding form, ald2 and aldx

### Preliminary

Run the `create_cmaq_csv-2010.py` and `create_cmaq_csv-2011.py` scripts against the updated `create_cmaq_csv_config.yml` file to generate output for.

- FORM (Formaldehyde)
- ALD2 (Acetaldehyde)
- ALDX (Higher Aldehydes)
- PMIJ (PM2.5)
- O3 (Ozone)

### Update database

From existing database with only **pmij** and **o3** entries, the user will need to:

1. Run the `form-ald2-aldx-alter-table.sh` script (or it's non-docker equivelant) to update the datbase schema
2. Run the `form-ald2-aldx-update-table.sh` script (or it's non-docker equivelant) to populate `form`, `ald2` and `aldx` for 2010 and 2011
	- will need to repeated across all 2010 and 2011 csv output files 
3. Load the `cmaq_form_ald2_aldx_stats_row` function from `form-ald2-aldx-stats-row.sql` into PostgreSQL
4. Run the `run-form-ald2-aldx-by-row.sh` script for each year
	- `$ run-form-ald2-aldx-by-row.sh 2010` 
	- `$ run-form-ald2-aldx-by-row.sh 2011` 

	
### Note

The underlying data model python uses needs to be updated anytime there is a change to the database schema.

This is reflected as the `server/models.py` file and the instructions to do this are in the `server/README.md` file.