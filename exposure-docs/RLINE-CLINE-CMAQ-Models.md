# R-LINE, C-LINE-, & CMAQ Air Quality Models (AirQualityModels)
**Last Updated: 10/17/2017**

**R-LINE**

The Roadside LINE Source Model (R-LINE) is a research-grade dispersion model that is currently under development by EPA for near-roadway assessments of air quality. The research tool model is based on a steady-state Gaussian formulation and is designed to simulate line type source emissions (e.g. mobile sources along roadways) by numerically integrating point source emissions. The current version, R-LINE v1.2, is formulated for near-surface releases, contains new formulations for vertical and lateral dispersion rates, simulates low-wind meander conditions, includes Monin-Obukhov similarity profiling of winds near the surface, and selects plume-weighted winds for transport and dispersion calculations. R-LINE uses the surface meteorology provided by the AERMET meteorological data preprocessor and includes user-friendly input requirements such as simplified road-link specifications. Model simulation with integrated point sources has been formulated with careful attention to appropriately simulate line source emissions for receptors very near the source line.
The current version of the model is appropriate for flat roadways (no surrounding complexities); however, beta-option algorithms are available for simulating near-source effects of complex roadway configurations (noise and vegetative barriers, depressed roadways, etc) and for simulating the line source emissions with an analytical approximation (rather than the numerical integration).

[Additional information](https://www.cmascenter.org/r-line/)

**C-LINE**

The Community LINE Source Model (C-LINE) is a web-based screening-level model designed to inform the user of local air quality impacts due to mobile sources in their community area of interest using a simplified modeling approach. As has been established in near-road and near-source monitoring studies, busy roadways and large emission sources, respectively, may impact local air quality near the source. 
C-LINE computes dispersion of primary mobile source pollutants using meteorological conditions for the area of interest and computes air quality concentrations corresponding to these selected conditions. The dispersion routines used are based on the analytical version of R-LINE described in Snyder, et. al. Atmos. Environ., 2013.

Specific emissions for each road link are calculated by combining national databases on traffic volume (AADT) and fleet mix with emissions factors from EPA's MOVES-2014. The user can modify the emissions for each road-link by changing the traffic composition, speed, and/or traffic volume. The air quality impact from a change in emissions due to changes in activity or fleet composition, or changes in representative meteorological conditions can be visually quantified for a select set of pollutants and select mobile source air toxic (MSAT) species.

This web-based tool is currently capable of modeling any local area of the United States. When the concentrations are displayed, a maximum value is applied for each pollutant. This is the maximum concentration estimate provided by the visualization tool. The tool does not distinguish values above the maximum.

Available measurements from C-LINE:

NOx: Nitrogen oxides (sum of NO & NO2). Maximum: 200 ppb.
NO2: Nitrogen dioxide. Maximum: 200 ppb.
CO: Carbon monoxide. Maximum: 10,000 ppb.
SO2: Sulfur dioxide. Maximum: 100 ppb.
PM2.5: Particulate matter with aerodynamic diameter less than 2.5 microns. Maximum: 50 µg/m3.
D-PM2.5: PM2.5 emissions from diesel vehicles only. Maximum: 50 µg/m3.
EC2.5: The portion of PM2.5 consisting of elemental carbon (graphitic carbon and high molecular weight, nonvolatile organic compounds). Maximum: 50 µg/m3.
OC2.5: The portion of PM2.5 consisting of organic carbon (particulate organic compounds containing more than 20 carbon atoms). Maximum: 50 µg/m3.
PM10: Particulate matter with aerodynamic diameter less than 10 microns. Maximum: 50 µg/m3.
Benzene. Maximum: 30 µg/m3.
Formaldehyde. Maximum: 9.8 µg/m3.
Acetaldehyde (systematic name: ethanal). Maximum: 9 µg/m3.
Acrolein (systematic name: propenal). Maximum: 0.02 µg/m3.
1,3-Butadiene. Maximum: 2 µg/m3.

[Additional information](https://www.cmascenter.org/c-tools/)

**CMAQ**

The Community Multiscale Air Quality model (CMAQ) is a powerful computational tool used for air quality management that simultaneously models multiple air pollutants including ozone, particulate matter and a variety of air toxics. CMAQ brings together three kinds of models:

•	Meteorological models to represent atmospheric and weather activities.

•	Emission models to represent man-made and naturally occurring contributions to the atmosphere. 

•	An air chemistry transport model to predict the atmospheric fate of air pollutants under varying conditions.

The tool can provide detailed information about air pollutant concentrations in any given area for any specified emission or climate scenario. CMAQ’s modular design allows for inclusion of new science in the model to address increasingly complex air pollution issues.

The CMAQ modeling community has thousands of users in over 50 countries and includes researchers, regulators, consultants, and forecasters in government, academia and the private sector. Both EPA and states use CMAQ for air quality management. States also use CMAQ to assess implementation actions needed to attain National Ambient Air Quality Standards. Air quality regulators use CMAQ to provide a clear picture of how to implement pollution controls. The National Weather Service uses CMAQ to produce daily U.S. forecasts for air quality.

In June 2017, EPA released CMAQ v5.2 to the public. This newest version of the modeling system includes three major scientific advances, additional diagnostic capabilities, and several minor modifications and bug fixes. The major new features of CMAQ v5.2 include new treatment of organic aerosols, new windblown dust model, and a new gas-phase chemical mechanism. The new organic aerosol treatment and windblown dust model address deficiencies in earlier versions of CMAQ. CMAQ v5.2 also includes several new instrumented diagnostic capabilities that allow users to probe source-receptor relationships.

[Additional information](https://www.epa.gov/airresearch/communitymultiscaleairqualitycmaqmodelingsystemairqualitymanagement)

[GitHub site](https://github.com/USEPA/CMAQ/blob/5.2/CCTM/docs/Release_Notes/README.md)
