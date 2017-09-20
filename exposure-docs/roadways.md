# Exposure to Roadways (road)

**Last Updated:** 06/16/2017

## Overview

-	**Data Source:** US Department of Transportation Roadway Data

-	**Input:** EXPest, latitude/longitude for resident location

-	**Output:** absolute distance (meters); categorical score, ranging from 1 (far from road) to 5 (close to road)

Roadways are classified in a variety of ways. For our purposes, we’ll focus on major roads (i.e., primary urban roads and arterial roads with medium to large traffic capacity) and highways (expressways and primary and secondary highways) and calculate distance between home residence and major road/highway in meters [4] 

Note that several authors [e.g., 4] have used the ArcGIS online mapping program to calculate distance

Exposure scores calculated [1,3,4] as:

```
1 = if home residence >300 meters from major road/highway
2 = if home residence 201-300 meters from major road/highway
3 = if home residence 101-200 meters from major road/highway
4 = if home residence 50-100 meters from major road/highway
5 = of home residence <50 meters from major road/highway
```

**Caveat:** This approach is restricted to primary home residence and does not account for exposure to secondary or connecting roads

**Caveat:** The approach could be adapted to account for locations other than home residence (e.g., school, workplace)

## References

https://github.com/mjstealey/datatranslator/blob/develop/exposure_docs/references.md

## Implemented as

Code:

•	python-flask-server/exposures/pm25.py

## Details:

•	TODO
