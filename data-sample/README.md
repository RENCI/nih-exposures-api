## Sample Data

Sample data is provided for development purposes and should retain the same format as that deployed in production.

All scripts herein assume the use of the development [database](../database). These scripts should be used as a guide for establishing similar ingest scripts in the production enviornment.

### Configuration and Database Setup

**Configuration**

- The file named **database.cfg** defines the configuration to be used for setting up the database. This file will be used as the informational source for the sample data scripts in this directory.

- **database.cfg** default values:

	```bash
	export DB_NAME='exposures'
	export DB_USER='datatrans'
	export DB_PASS='datatrans'
	export DB_CONTAINER_NAME='database'
	```

**Database Setup**

- The script named **setup-exposures-db.sh** is used to setup the database container based on the contents of **database.cfg**.

- This script should be run prior to loading any sample data into the database.

	```
	./setup-exposures-db.sh
	```

- Example:

	```
	$ ./setup-exposures-db.sh
	Going to remove database
	Removing database ... done
	Building database
	Step 1/11 : FROM centos:7
	 ---> 328edcd84f1b
	...
	Step 11/11 : CMD run
	 ---> Using cache
	 ---> b1f20035a0cc
	
	Successfully built b1f20035a0cc
	Successfully tagged database_database:latest
	Creating database ...
	Creating database ... done
	/Users/stealey/Github/nih-exposures-api/sample-data
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
	```

## CMAQ Data

### CMAQ Exposures List

Script named **load-cmaq-list.sh** will load the list of exposure types available for CMAQ

```
$ ./load-cmaq-list
DROP TABLE
CREATE TABLE
COPY 2
psql:cmaq-list.sql:4: NOTICE:  table "cmaq_exposures_list" does not exist, skipping
CREATE TABLE
INSERT 0 2
DROP TABLE
ALTER TABLE
 id | exposure_type | exposure_unit | start_date |  end_date  |     resolution      | aggregation
----+---------------+---------------+------------+------------+---------------------+-------------
  2 | o3            | ppm           | 2011-01-01 | 2011-12-31 | hour;day;7day;14day | max;avg
  1 | pm25          | ugm3          | 2011-01-01 | 2011-12-31 | hour;day;7day;14day | max;avg
(2 rows)
```

### CMAQ Exposures Data

Script named **load-cmaq-sample** will load the sample exposures data for a limited period of time to develop with.

```
$ ./load-cmaq-sample
DROP TABLE
CREATE TABLE
COPY 72
CREATE TABLE
INSERT 0 72
CREATE INDEX
DROP TABLE
ALTER TABLE
 id | col | row |    utc_date_time    |        o3        | o3_avg_24 | o3_max_24 | o3_avg_7day | o3_max_7day | o3_avg_14day | o3_max_14day |       pmij       | pmij_avg_24 | pmij_max_24 | pmij_avg_7day | pmij_max_7day | pmij_avg_14day | pmij_max_14day
----+-----+-----+---------------------+------------------+-----------+-----------+-------------+-------------+--------------+--------------+------------------+-------------+-------------+---------------+---------------+----------------+----------------
  1 |   1 |   1 | 2011-01-01 00:00:00 | 33.7424583435059 |           |           |             |             |              |              | 2.02411556243896 |             |             |               |               |                |
  2 |   1 |   1 | 2011-01-01 01:00:00 | 33.5511512756348 |           |           |             |             |              |              | 2.06854724884033 |             |             |               |               |                |
  3 |   1 |   1 | 2011-01-01 02:00:00 | 33.4930381774902 |           |           |             |             |              |              | 2.05997824668884 |             |             |               |               |                |
  4 |   1 |   1 | 2011-01-01 03:00:00 | 33.4488830566406 |           |           |             |             |              |              |  2.0421085357666 |             |             |               |               |                |
  5 |   1 |   1 | 2011-01-01 04:00:00 | 33.5000419616699 |           |           |             |             |              |              | 2.03720164299011 |             |             |               |               |                |
  6 |   1 |   1 | 2011-01-01 05:00:00 | 33.6842765808105 |           |           |             |             |              |              | 2.01134991645813 |             |             |               |               |                |
  7 |   1 |   1 | 2011-01-01 06:00:00 | 33.8893775939941 |           |           |             |             |              |              | 1.92126488685608 |             |             |               |               |                |
  8 |   1 |   1 | 2011-01-01 07:00:00 | 34.0733184814453 |           |           |             |             |              |              | 1.77965939044952 |             |             |               |               |                |
  9 |   1 |   1 | 2011-01-01 08:00:00 | 34.0809783935547 |           |           |             |             |              |              | 1.64729368686676 |             |             |               |               |                |
 10 |   1 |   1 | 2011-01-01 09:00:00 |  34.125129699707 |           |           |             |             |              |              | 1.51135265827179 |             |             |               |               |                |
(10 rows)
```