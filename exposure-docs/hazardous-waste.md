# Exposure to Hazardous Waste (haz_waste)

**Last Updated**: 06/16/2017

## Overview

- **Data Source**: NC Department of Environmental Quality ([https://deq.nc.gov/about/divisions/waste-management/waste-management-rules-data/waste-management-gis-maps](https://deq.nc.gov/about/divisions/waste-management/waste-management-rules-data/waste-management-gis-maps)); US EPA Superfund Sites ([https://www.epa.gov/superfund/search-superfund-sites-where-you-live](https://www.epa.gov/superfund/search-superfund-sites-where-you-live))
- **Input**: EXPest, latitude/longitude of home residence
- **Output**: distance from hazardous waste site (miles); categorical hazardous waste exposure score (low, medium, high)

A variety of exposures are available from NC DEQ and the US Superfund Program; we will restrict our focus initially to four generally categories (six types) of hazardous waste exposures

Hazardous waste exposure types:

- Active Disaster Debris Sites (ActiveDisaster)
- Active Hazardous Waste Sites
	- Small Quantity Generators (ActiveSQG)
	- Large Quantity Generators (ActiveLQG)
	- Treatment, Processing and Disposal Facilities (ActiveTreatment)
- Inactive Hazardous Waste Sites (InactiveHazard)
- Superfund Sites (Superfund)

Hazardous waste exposure 'scores' (calculated for each of the above six types of hazardous waste exposures):[9-14]

```
1 = Low: home residence >50 miles from site
2 = Medium: home residence 1-50 miles from site
3 = High: home residence <1 mile from site
```

**Caveat**: The data are available for both NC and the nation and are more or less static, although active sites may become inactive sites and superfund sites might be declared ‘clean’ at some point in the future

**Note**: The categories are based on [9-14], with numerous studies showing an increased risk of cancer and a variety of other health outcomes, including those specific to pregnant women and children; as such, these exposures might represent a good point of synergy between Green Team and Blue Team

## References
https://github.com/mjstealey/datatranslator/blob/develop/exposure_docs/references.md

## Implemented as

Code: 
 
- TODO (haz_waste.py)

Details:

- TODO
