# NIH Exposures API

ReSTful data service implemented in [Swagger](https://swagger.io) using [OpenAPI 2.0](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md) standards that provides environmental exposures data based on GeoCodes (latitude,longitude) and dates.

See [README.md](exposure-docs/README.md) in `exposure-docs/` for detailed information on supported exposures and return types

## Development Environment

### Assumptions

- Python 3 on the host
- Docker on the host

### Swagger Editor

See [README.md](swagger-editor/README.md) in `swagger-editor/`

### Server

See [README.md](server/README.md) in `server/`

### Database

See [README.md](database/README.md) in `database/`

### Scripts

A script named [run-database-all.sh](scripts/run-database-all.sh) can be used to:

- Create the database container
- Create the exposures database and the datatrans user
- Populate the exposures database with sample data
- Create functions and indices on the exposures database

Example:

```
$ ./run-database-all.sh
No stopped containers
Error: No such image: database_databaseError: No such image: centos:7Building database
Step 1/11 : FROM centos:7
7: Pulling from library/centos
d9aaf4d82f24: Pull complete
Digest: sha256:eba772bac22c86d7d6e72421b4700c3f894ab6e35475a34014ff8de74c10872e
Status: Downloaded newer image for centos:7
 ---> 196e0ce0c9fb
...
Step 11/11 : CMD run
 ---> Running in 95ff009d8fab
 ---> 914e80e8c823
Removing intermediate container 95ff009d8fab
Successfully built 914e80e8c823
Successfully tagged database_database:latest
Creating database ...
Creating database ... done
Database is running - use your local IP address for connection
/Users/stealey/Github/nihdt/nih-exposures-api/scripts
Database container already exists
CREATE ROLE
CREATE DATABASE
GRANT
CREATE EXTENSION
CREATE EXTENSION
CREATE EXTENSION
                                  List of databases
   Name    |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges
-----------+----------+----------+-------------+-------------+------------------------
 exposures | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =Tc/postgres          +
           |          |          |             |             | postgres=CTc/postgres +
           |          |          |             |             | datatrans=CTc/postgres
 postgres  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 template0 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres           +
           |          |          |             |             | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres           +
           |          |          |             |             | postgres=CTc/postgres
(4 rows)

                                         List of installed extensions
       Name       | Version |   Schema   |                             Description
------------------+---------+------------+---------------------------------------------------------------------
 ogr_fdw          | 1.0     | public     | foreign-data wrapper for GIS data access
 plpgsql          | 1.0     | pg_catalog | PL/pgSQL procedural language
 postgis          | 2.3.3   | public     | PostGIS geometry, geography, and raster spatial types and functions
 postgis_topology | 2.3.3   | topology   | PostGIS topology spatial types and functions
(4 rows)

/PATH_TO/nih-exposures-api/scripts
DROP TABLE
psql:cmaq-list.sql:4: NOTICE:  table "cmaq_exposures_list" does not exist, skipping
CREATE TABLE
COPY 2
CREATE TABLE
INSERT 0 2
DROP TABLE
ALTER TABLE
 id | exposure_type | exposure_unit | start_date |  end_date  |     resolution      | aggregation
----+---------------+---------------+------------+------------+---------------------+-------------
  2 | o3            | ppm           | 2011-01-01 | 2011-12-31 | hour;day;7day;14day | max;avg
  1 | pm25          | ugm3          | 2011-01-01 | 2011-12-31 | hour;day;7day;14day | max;avg
(2 rows)

/PATH_TO/nih-exposures-api/scripts
DROP TABLE
psql:cmaq-sample.sql:6: NOTICE:  table "cmaq_exposures_data" does not exist, skipping
CREATE TABLE
COPY 46064
ALTER TABLE
    id     | col | row |    utc_date_time    |        o3        | o3_avg_24 | o3_max_24 | o3_avg_7day | o3_max_7day | o3_avg_14day | o3_max_14day |       pmij       | pmij_avg_24 | pmij_max_24 | pmij_avg_7day | pmij_max_7day | pmij_avg_14day | pmij_max_14day
-----------+-----+-----+---------------------+------------------+-----------+-----------+-------------+-------------+--------------+--------------+------------------+-------------+-------------+---------------+---------------+----------------+----------------
 145428961 |   2 |   2 | 2011-01-01 01:00:00 | 33.6253852844238 |           |           |             |             |              |              | 2.08039736747742 |             |             |               |               |                |
 145430449 |   2 |   4 | 2011-01-01 01:00:00 | 33.5208473205566 |           |           |             |             |              |              | 2.03274345397949 |             |             |               |               |                |
 145207249 |   1 |   3 | 2011-01-01 01:00:00 | 33.5331764221191 |           |           |             |             |              |              | 2.08565402030945 |             |             |               |               |                |
 145428217 |   2 |   1 | 2011-01-01 01:00:00 | 33.7440719604492 |           |           |             |             |              |              | 2.02048206329346 |             |             |               |               |                |
 145429705 |   2 |   3 | 2011-01-01 01:00:00 | 33.5246391296387 |           |           |             |             |              |              | 2.07938885688782 |             |             |               |               |                |
 145207993 |   1 |   4 | 2011-01-01 01:00:00 | 33.5291023254395 |           |           |             |             |              |              | 2.03650760650635 |             |             |               |               |                |
 145205761 |   1 |   1 | 2011-01-01 01:00:00 | 33.7424583435059 |           |           |             |             |              |              | 2.02411556243896 |             |             |               |               |                |
 145206505 |   1 |   2 | 2011-01-01 01:00:00 | 33.6172256469727 |           |           |             |             |              |              | 2.08304381370544 |             |             |               |               |                |
 145651417 |   3 |   2 | 2011-01-01 01:00:00 | 33.6336097717285 |           |           |             |             |              |              |  2.0758228302002 |             |             |               |               |                |
 145650673 |   3 |   1 | 2011-01-01 01:00:00 | 33.7342147827148 |           |           |             |             |              |              | 2.01978802680969 |             |             |               |               |                |
(10 rows)

/PATH_TO/nih-exposures-api/scripts
psql:cmaq-functions.sql:2: ERROR:  index "cmaq_col_row_date" does not exist
CREATE INDEX
psql:cmaq-functions.sql:7: ERROR:  index "cmaq_datetime" does not exist
CREATE INDEX
                                          List of relations
  Schema  |                      Name                       | Type  |   Owner   |        Table
----------+-------------------------------------------------+-------+-----------+---------------------
 public   | cmaq_col_row_date                               | index | datatrans | cmaq_exposures_data
 public   | cmaq_datetime                                   | index | datatrans | cmaq_exposures_data
 public   | cmaq_exposures_data_pkey                        | index | datatrans | cmaq_exposures_data
 public   | cmaq_exposures_list_pkey                        | index | datatrans | cmaq_exposures_list
 public   | spatial_ref_sys_pkey                            | index | postgres  | spatial_ref_sys
 topology | layer_pkey                                      | index | postgres  | layer
 topology | layer_schema_name_table_name_feature_column_key | index | postgres  | layer
 topology | topology_name_key                               | index | postgres  | topology
 topology | topology_pkey                                   | index | postgres  | topology
(9 rows)

psql:cmaq-functions.sql:14: ERROR:  function cmaq_grid_size(text) does not exist
CREATE FUNCTION
psql:cmaq-functions.sql:39: ERROR:  function cmaq_o3_pmij_stats_row(text, integer) does not exist
CREATE FUNCTION
                                                                     List of functions
 Schema |          Name          | Result data type |                                     Argument data types                                      |  Type
--------+------------------------+------------------+----------------------------------------------------------------------------------------------+--------
 public | cmaq_grid_size         | record           | _yr text, OUT min_row integer, OUT max_row integer, OUT min_col integer, OUT max_col integer | normal
 public | cmaq_o3_pmij_stats_row | void             | _yr text, _r integer                                                                         | normal
(2 rows)

/PATH_TO/nih-exposures-api/scripts
```

A script named [reload-database-all.sh](scripts/run-database-all.sh) can also be used to:

- Drop and repopulate the exposures database with sample data
- Drop and create functions and indices on the exposures database

Example:

```
$ ./reload-database-all.sh
database
database
DROP TABLE
CREATE TABLE
COPY 2
CREATE TABLE
INSERT 0 2
DROP TABLE
ALTER TABLE
 id | exposure_type | exposure_unit | start_date |  end_date  |     resolution      | aggregation
----+---------------+---------------+------------+------------+---------------------+-------------
  2 | o3            | ppm           | 2011-01-01 | 2011-12-31 | hour;day;7day;14day | max;avg
  1 | pm25          | ugm3          | 2011-01-01 | 2011-12-31 | hour;day;7day;14day | max;avg
(2 rows)

/PATH_TO/nih-exposures-api/scripts
DROP TABLE
CREATE TABLE
COPY 46064
ALTER TABLE
    id     | col | row |    utc_date_time    |        o3        | o3_avg_24 | o3_max_24 | o3_avg_7day | o3_max_7day | o3_avg_14day | o3_max_14day |       pmij       | pmij_avg_24 | pmij_max_24 | pmij_avg_7day | pmij_max_7day | pmij_avg_14day | pmij_max_14day
-----------+-----+-----+---------------------+------------------+-----------+-----------+-------------+-------------+--------------+--------------+------------------+-------------+-------------+---------------+---------------+----------------+----------------
 145428961 |   2 |   2 | 2011-01-01 01:00:00 | 33.6253852844238 |           |           |             |             |              |              | 2.08039736747742 |             |             |               |               |                |
 145430449 |   2 |   4 | 2011-01-01 01:00:00 | 33.5208473205566 |           |           |             |             |              |              | 2.03274345397949 |             |             |               |               |                |
 145207249 |   1 |   3 | 2011-01-01 01:00:00 | 33.5331764221191 |           |           |             |             |              |              | 2.08565402030945 |             |             |               |               |                |
 145428217 |   2 |   1 | 2011-01-01 01:00:00 | 33.7440719604492 |           |           |             |             |              |              | 2.02048206329346 |             |             |               |               |                |
 145429705 |   2 |   3 | 2011-01-01 01:00:00 | 33.5246391296387 |           |           |             |             |              |              | 2.07938885688782 |             |             |               |               |                |
 145207993 |   1 |   4 | 2011-01-01 01:00:00 | 33.5291023254395 |           |           |             |             |              |              | 2.03650760650635 |             |             |               |               |                |
 145205761 |   1 |   1 | 2011-01-01 01:00:00 | 33.7424583435059 |           |           |             |             |              |              | 2.02411556243896 |             |             |               |               |                |
 145206505 |   1 |   2 | 2011-01-01 01:00:00 | 33.6172256469727 |           |           |             |             |              |              | 2.08304381370544 |             |             |               |               |                |
 145651417 |   3 |   2 | 2011-01-01 01:00:00 | 33.6336097717285 |           |           |             |             |              |              |  2.0758228302002 |             |             |               |               |                |
 145650673 |   3 |   1 | 2011-01-01 01:00:00 | 33.7342147827148 |           |           |             |             |              |              | 2.01978802680969 |             |             |               |               |                |
(10 rows)

/PATH_TO/nih-exposures-api/scripts
psql:cmaq-functions.sql:2: ERROR:  index "cmaq_col_row_date" does not exist
CREATE INDEX
psql:cmaq-functions.sql:7: ERROR:  index "cmaq_datetime" does not exist
CREATE INDEX
                                          List of relations
  Schema  |                      Name                       | Type  |   Owner   |        Table
----------+-------------------------------------------------+-------+-----------+---------------------
 public   | cmaq_col_row_date                               | index | datatrans | cmaq_exposures_data
 public   | cmaq_datetime                                   | index | datatrans | cmaq_exposures_data
 public   | cmaq_exposures_data_pkey                        | index | datatrans | cmaq_exposures_data
 public   | cmaq_exposures_list_pkey                        | index | datatrans | cmaq_exposures_list
 public   | spatial_ref_sys_pkey                            | index | postgres  | spatial_ref_sys
 topology | layer_pkey                                      | index | postgres  | layer
 topology | layer_schema_name_table_name_feature_column_key | index | postgres  | layer
 topology | topology_name_key                               | index | postgres  | topology
 topology | topology_pkey                                   | index | postgres  | topology
(9 rows)

DROP FUNCTION
CREATE FUNCTION
DROP FUNCTION
CREATE FUNCTION
                                                                     List of functions
 Schema |          Name          | Result data type |                                     Argument data types                                      |  Type
--------+------------------------+------------------+----------------------------------------------------------------------------------------------+--------
 public | cmaq_grid_size         | record           | _yr text, OUT min_row integer, OUT max_row integer, OUT min_col integer, OUT max_col integer | normal
 public | cmaq_o3_pmij_stats_row | void             | _yr text, _r integer                                                                         | normal
(2 rows)

/PATH_TO/nih-exposures-api/scripts
```

Once the database is stood up and populated with the base data, functions and indices, a script named [run-o3-pmij-by-row.sh](data-sample/cmaq/cmaq-functions/run-o3-pmij-by-row.sh) can be used to calculate and insert the statistical data for

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

### Data Sample

Since the database is located within a Docker container, the user would need to use Docker commands to interact with it. 

Example:

Become the **postgres** user on the **exposures** database:

```
$ docker exec -ti -u postgres database psql exposures
```

Issue a SQL command:

```
exposures=# SELECT * FROM cmaq_exposures_data ORDER BY utc_date_time LIMIT 20;
    id     | col | row |    utc_date_time    |        o3        |    o3_avg_24     |    o3_max_24     |   o3_avg_7day    |   o3_max_7day    |   o3_avg_14day   |   o3_max_14day   |       pmij       |   pmij_avg_24    |   pmij_max_24    |  pmij_avg_7day   |  pmij_max_7day   |  pmij_avg_14day  |  pmij_max_14day
-----------+-----+-----+---------------------+------------------+------------------+------------------+------------------+------------------+------------------+------------------+------------------+------------------+------------------+------------------+------------------+------------------+------------------
 145873129 |   4 |   1 | 2011-01-01 01:00:00 | 33.7093811035156 | 33.7093811035156 | 33.7093811035156 | 33.7093811035156 | 33.7093811035156 | 33.7093811035156 | 33.7093811035156 | 2.02110481262207 | 2.02110481262207 | 2.02110481262207 | 2.02110481262207 | 2.02110481262207 | 2.02110481262207 | 2.02110481262207
 145650673 |   3 |   1 | 2011-01-01 01:00:00 | 33.7342147827148 | 33.7342147827148 | 33.7342147827148 | 33.7342147827148 | 33.7342147827148 | 33.7342147827148 | 33.7342147827148 | 2.01978802680969 | 2.01978802680969 | 2.01978802680969 | 2.01978802680969 | 2.01978802680969 | 2.01978802680969 | 2.01978802680969
 145428217 |   2 |   1 | 2011-01-01 01:00:00 | 33.7440719604492 | 33.7440719604492 | 33.7440719604492 | 33.7440719604492 | 33.7440719604492 | 33.7440719604492 | 33.7440719604492 | 2.02048206329346 | 2.02048206329346 | 2.02048206329346 | 2.02048206329346 | 2.02048206329346 | 2.02048206329346 | 2.02048206329346
 145205761 |   1 |   1 | 2011-01-01 01:00:00 | 33.7424583435059 | 33.7424583435059 | 33.7424583435059 | 33.7424583435059 | 33.7424583435059 | 33.7424583435059 | 33.7424583435059 | 2.02411556243896 | 2.02411556243896 | 2.02411556243896 | 2.02411556243896 | 2.02411556243896 | 2.02411556243896 | 2.02411556243896
 145206505 |   1 |   2 | 2011-01-01 01:00:00 | 33.6172256469727 | 33.6172256469727 | 33.6172256469727 | 33.6172256469727 | 33.6172256469727 | 33.6172256469727 | 33.6172256469727 | 2.08304381370544 | 2.08304381370544 | 2.08304381370544 | 2.08304381370544 | 2.08304381370544 | 2.08304381370544 | 2.08304381370544
 145207249 |   1 |   3 | 2011-01-01 01:00:00 | 33.5331764221191 | 33.5331764221191 | 33.5331764221191 | 33.5331764221191 | 33.5331764221191 | 33.5331764221191 | 33.5331764221191 | 2.08565402030945 | 2.08565402030945 | 2.08565402030945 | 2.08565402030945 | 2.08565402030945 | 2.08565402030945 | 2.08565402030945
 145207993 |   1 |   4 | 2011-01-01 01:00:00 | 33.5291023254395 | 33.5291023254395 | 33.5291023254395 | 33.5291023254395 | 33.5291023254395 | 33.5291023254395 | 33.5291023254395 | 2.03650760650635 | 2.03650760650635 | 2.03650760650635 | 2.03650760650635 | 2.03650760650635 | 2.03650760650635 | 2.03650760650635
 145428961 |   2 |   2 | 2011-01-01 01:00:00 | 33.6253852844238 | 33.6253852844238 | 33.6253852844238 | 33.6253852844238 | 33.6253852844238 | 33.6253852844238 | 33.6253852844238 | 2.08039736747742 | 2.08039736747742 | 2.08039736747742 | 2.08039736747742 | 2.08039736747742 | 2.08039736747742 | 2.08039736747742
 145429705 |   2 |   3 | 2011-01-01 01:00:00 | 33.5246391296387 | 33.5246391296387 | 33.5246391296387 | 33.5246391296387 | 33.5246391296387 | 33.5246391296387 | 33.5246391296387 | 2.07938885688782 | 2.07938885688782 | 2.07938885688782 | 2.07938885688782 | 2.07938885688782 | 2.07938885688782 | 2.07938885688782
 145430449 |   2 |   4 | 2011-01-01 01:00:00 | 33.5208473205566 | 33.5208473205566 | 33.5208473205566 | 33.5208473205566 | 33.5208473205566 | 33.5208473205566 | 33.5208473205566 | 2.03274345397949 | 2.03274345397949 | 2.03274345397949 | 2.03274345397949 | 2.03274345397949 | 2.03274345397949 | 2.03274345397949
 145651417 |   3 |   2 | 2011-01-01 01:00:00 | 33.6336097717285 | 33.6336097717285 | 33.6336097717285 | 33.6336097717285 | 33.6336097717285 | 33.6336097717285 | 33.6336097717285 |  2.0758228302002 |  2.0758228302002 |  2.0758228302002 |  2.0758228302002 |  2.0758228302002 |  2.0758228302002 |  2.0758228302002
 145652161 |   3 |   3 | 2011-01-01 01:00:00 | 33.5546569824219 | 33.5546569824219 | 33.5546569824219 | 33.5546569824219 | 33.5546569824219 | 33.5546569824219 | 33.5546569824219 | 2.06953716278076 | 2.06953716278076 | 2.06953716278076 | 2.06953716278076 | 2.06953716278076 | 2.06953716278076 | 2.06953716278076
 145652905 |   3 |   4 | 2011-01-01 01:00:00 | 33.5305366516113 | 33.5305366516113 | 33.5305366516113 | 33.5305366516113 | 33.5305366516113 | 33.5305366516113 | 33.5305366516113 | 2.03037524223328 | 2.03037524223328 | 2.03037524223328 | 2.03037524223328 | 2.03037524223328 | 2.03037524223328 | 2.03037524223328
 145873873 |   4 |   2 | 2011-01-01 01:00:00 | 33.6226844787598 | 33.6226844787598 | 33.6226844787598 | 33.6226844787598 | 33.6226844787598 | 33.6226844787598 | 33.6226844787598 | 2.06580376625061 | 2.06580376625061 | 2.06580376625061 | 2.06580376625061 | 2.06580376625061 | 2.06580376625061 | 2.06580376625061
 145874617 |   4 |   3 | 2011-01-01 01:00:00 | 33.5541572570801 | 33.5541572570801 | 33.5541572570801 | 33.5541572570801 | 33.5541572570801 | 33.5541572570801 | 33.5541572570801 | 2.05466723442078 | 2.05466723442078 | 2.05466723442078 | 2.05466723442078 | 2.05466723442078 | 2.05466723442078 | 2.05466723442078
 145875361 |   4 |   4 | 2011-01-01 01:00:00 | 33.5231628417969 | 33.5231628417969 | 33.5231628417969 | 33.5231628417969 | 33.5231628417969 | 33.5231628417969 | 33.5231628417969 | 2.02457571029663 | 2.02457571029663 | 2.02457571029663 | 2.02457571029663 | 2.02457571029663 | 2.02457571029663 | 2.02457571029663
 145873130 |   4 |   1 | 2011-01-01 02:00:00 |  33.520881652832 | 33.6151313781738 | 33.7093811035156 | 33.6151313781738 | 33.7093811035156 | 33.6151313781738 | 33.7093811035156 | 2.03848743438721 | 2.02979612350464 | 2.03848743438721 | 2.02979612350464 | 2.03848743438721 | 2.02979612350464 | 2.03848743438721
 145650674 |   3 |   1 | 2011-01-01 02:00:00 | 33.5395965576172 |  33.636905670166 | 33.7342147827148 |  33.636905670166 | 33.7342147827148 |  33.636905670166 | 33.7342147827148 | 2.05229020118713 | 2.03603911399841 | 2.05229020118713 | 2.03603911399841 | 2.05229020118713 | 2.03603911399841 | 2.05229020118713
 145428218 |   2 |   1 | 2011-01-01 02:00:00 | 33.5495109558105 | 33.6467914581298 | 33.7440719604492 | 33.6467914581298 | 33.7440719604492 | 33.6467914581298 | 33.7440719604492 | 2.06364917755127 | 2.04206562042237 | 2.06364917755127 | 2.04206562042237 | 2.06364917755127 | 2.04206562042237 | 2.06364917755127
 145205762 |   1 |   1 | 2011-01-01 02:00:00 | 33.5511512756348 | 33.6468048095704 | 33.7424583435059 | 33.6468048095704 | 33.7424583435059 | 33.6468048095704 | 33.7424583435059 | 2.06854724884033 | 2.04633140563964 | 2.06854724884033 | 2.04633140563964 | 2.06854724884033 | 2.04633140563964 | 2.06854724884033
 (20 rows)

exposures=#
```

Or, run the full command from the host:

```
$ docker exec -ti -u postgres database psql exposures -c "SELECT * FROM cmaq_exposures_data ORDER BY utc_date_time LIMIT 20;"
```