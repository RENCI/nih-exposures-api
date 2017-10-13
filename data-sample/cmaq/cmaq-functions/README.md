## CMAQ Postgres Functions

### cmaq\_grid\_size( _yr TEXT)

Used to find the size of the CMAQ grid based on year.

Input parameter is TEXT for year: `_yr`

```sql
-- find grid size in CMAQ for a particular year
CREATE OR REPLACE FUNCTION cmaq_grid_size (
  IN  _yr TEXT,
  OUT min_row INT,
  OUT max_row INT,
  OUT min_col INT,
  OUT max_col INT
)
```

Output is minimum and maximum values for row and column

### cmaq\_o3\_pmij\_stats\_row( _yr TEXT, _r INT)

Used to populate max and avg statistical values for resolutions of 24 hour, 7 day and 14 day for pmij and o3.

Input parameters are TEXT for year: `_yr` and INT for row: `_r`

```
-- populate statistical data for o3 and pmij
-- o3: o3_avg_24, o3_max_24, o3_avg_7day, o3_max_7day, o3_avg_14day, o3_max_14day
-- pmij: pmij_avg_24, pmij_max_24, pmij_avg_7day, pmij_max_7day, pmij_avg_14day, pmij_max_14day
CREATE OR REPLACE FUNCTION cmaq_o3_pmij_stats_row (
  IN _yr TEXT,
  IN _r INT
)
```
Returns VOID

### How to use

Once the database is stood up and populated with the base data, functions and indices, a script named [run-o3-pmij-by-row.sh](run-o3-pmij-by-row.sh) can be used to calculate and insert the statistical data for

- o3\_avg\_24
- o3\_max\_24
- o3\_avg\_7day
- o3\_max\_7day
- o3\_avg\_14day
- o3\_max\_14day
- pmij\_avg\_24
- pmij\_max\_24
- pmij\_avg\_7day
- pmij\_max\_7day
- pmij\_avg\_14day
- pmij\_max\_14day

The [run-o3-pmij-by-row.sh](run-o3-pmij-by-row.sh) must be altered to match the enviornment for which it is being run if being used outside of the Docker development environment. This typically means adjusting the `MIN_ROW` or `MAX_ROW` values and changing the **docker exec** calls to be standard **psql** calls.

Example:

```
$ ./run-o3-pmij-by-row.sh 2011
NOTICE:  Check grid using date: 2011-01-01 12:00:00
 min_col | max_col
---------+---------
       1 |       4
(1 row)

min_col = 1, max_col = 4
Does this match expected?: [Y/n] y
Yes
Processing Row: 1
NOTICE:  Check grid using date: 2011-01-01 12:00:00
 cmaq_o3_pmij_stats_row
------------------------
...

(1 row)

Processing Row: 4
NOTICE:  Check grid using date: 2011-01-01 12:00:00
 cmaq_o3_pmij_stats_row
------------------------

(1 row)
```