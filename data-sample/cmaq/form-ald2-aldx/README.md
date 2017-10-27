## Adding form, ald2 and aldx

### Preliminary

Run the `create_cmaq_csv-2010.py` and `create_cmaq_csv-2011.py` scripts against the updated `create_cmaq_csv_config.yml` file to generate output for.

- FORM (Formaldehyde)
- ALD2 (Acetaldehyde)
- ALDX (Higher Aldehydes)
- PMIJ (PM2.5)
- O3 (Ozone)

### Update database

**NOTE**: 

- The Exposures REST services should be taken offline while updating the underlying database as the schema will be changing and concurrent queries to the database could disrupt the creation of necessary additional columns.

From existing database with only **pmij** and **o3** entries, the user will need to:

1. Run the `form-ald2-aldx-alter-table.sh` script (or it's non-docker equivalent) to update the datbase schema
2. Run the `form-ald2-aldx-update-table.sh` script (or it's non-docker equivalent) to populate `form`, `ald2` and `aldx` for 2010 and 2011
	- will need to be repeated across all 2010 and 2011 csv output files 
3. Load the `cmaq_form_ald2_aldx_stats_row` function from `form-ald2-aldx-stats-row.sql` into PostgreSQL
4. Run the `run-form-ald2-aldx-by-row.sh` script for each year
	- `$ run-form-ald2-aldx-by-row.sh 2010` 
	- `$ run-form-ald2-aldx-by-row.sh 2011` 

	
### Programmers note

The underlying data model python uses needs to be updated anytime there is a change to the database schema. With the addition of new columns to the **cmaq\_exposures\_data** table, there will be the need to regenerate the `server/models.py` file. Instructions to do this are in the `server/README.md` file.