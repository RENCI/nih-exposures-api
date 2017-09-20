## Environmental Exposures API

As defined using [OpenAPI 2.0 Specification](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md)

cmaq

```
@description - list of CMAQ exposures
@param 
	- None
@return 
	- {JSON object} cmaq - returns array of exposure objects available from CMAQ

cmaq(): {
  "cmaq": [
    {
      "exposureType": "string",
      "exposureUnit": "string",
      "startDate": "string(date)",
      "endDate": "string(date)",
      "resolution": [
        "string"
      ],
      "aggregation": [
        "string"
      ]
    }
  ]
}
```

cmaq/getValues

- UTC offset [reference](https://en.wikipedia.org/wiki/List_of_UTC_time_offsets)

```
@description - get values for exposure type at location for date range
@param 
	- {string} exposureType - unique exposure type in CMAQ
	- {date} startDate - start date of exposure
	- {date} endDate - end date of exposure
	- {string} latLon - latitude, longitude of exposure (multiples to be seperated by semicolon ";")
	- {string} - resolution - temporal resolution (hour, day), default day
	- {string} - aggregation - numerical aggrigation (max, avg), default max
	- {integer} - utcOffset - hour offset from UTC (-12 to +14), default 0
@return 
	- {JSON object} values - returns array of exposure values based on date range and location

getValues(): {
  "values": [
    {
      "value": "string",
      "dateTime": "yyyy-mm-ddTHH:MM:SS.000Z",
      "latLon": "string"
    }
  ]
}
```

cmaq/getScores

```
@description - get score for exposure type at location for date range
@param 
	- {string} exposureType - unique exposure type in CMAQ
	- {date} startDate - start date of exposure
	- {date} endDate - end date of exposure
	- {string} latLon - latitude, longitude of exposure (multiples to be seperated by semicolon ";")
	- {string} - resolution - temporal resolution (hour, day), default day
	- {string} - aggregation - numerical aggrigation (max, avg), default max
	- {integer} - utcOffset - hour offset from UTC (-12 to +14), default 0
@return 
	- {JSON object} scores - returns array of exposure scores based on date range and location

getScores(): {
  "scores": [
    {
      "score": "string",
      "dateTime": "yyyy-mm-ddTHH:MM:SS.000Z",
      "latLon": "string"
    }
  ]
}
```