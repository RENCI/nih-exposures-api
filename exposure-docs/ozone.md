# Exposure to Ozone (o3)

**Last Updated**: 06/16/2017

## Overview

- **Data Source**: US EPA via the Center for Community Modeling and Assessment System, UNC Institute for the Environment
- **Input**: EXPest, latitude/longitude of home residence
- **Output**: ozone exposure value (ppm); categorical ozone exposure score, ranging from 1 (low) to 5 (high)

Daily ozone exposure ‘score’ (DESo):[5-7]

```
DESo = 1 if 24h max ozone ≤ 0.050 ppm
DESo = 2 if 24h max ozone 0.051 – 0.075 ppm
DESo = 3 if 24h max ozone 0.076-0.100 ppm
DESo = 4 if 24h max ozone 0.101-0.125 ppm
DESo = 5 if 24h max ozone > 0.125 ppm
```

Overall 7- and 14-day ozone exposure ‘scores’

```
DES7o = (DESo1+DESo2…DESo7)/7
DES14o = (DESo1+DESo2…DESo14)/14
```

**Caveat**: The cutoffs are based on [6], [7], and [8]. As with PM2.5, the ozone exposure cutoffs that we propose are lower than the US EPA AQI breakpoints US EPA AQI breakpoints: 8-h average: 0-54 ppb, 55-70 ppb, 71-85 ppm 86-105 ppb, 106-200 ppb; 1-h average: 125-164 ppb, 165-204 ppb, 205-404 ppb, 405-504 ppb, 505-604 ppb ([https://en.wikipedia.org/wiki/Air_quality_index](https://en.wikipedia.org/wiki/Air_quality_index))[3].

## References
https://github.com/mjstealey/datatranslator/blob/develop/exposure_docs/references.md

## Implemented as

Code: 

- [python-flask-server/exposures/o3.py](../python-flask-server/exposures/o3.py)

Details:

- TODO
