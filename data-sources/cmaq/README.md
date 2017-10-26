## CMAQ Data

The NetCDF processing scripts make use of the [Anaconda 3](https://www.anaconda.com) distribution of Python. Other variations may work, but are not being supported by this project.

### Data Sources

The CMAQ output is presented as NetCDF files which contain a variety of exposure types. The exposures of interest can be extracted from the 36k or 12k grid by defining them in a yaml file, and then running the corresponding Python code.

Example: 2010 is 36k grid, 2011 is 12k grid

```yaml
# config data for create_cmaq_csv.py application

cmaq2010:
    netcdf-path: /projects/datatrans/CMAQ/2010/raw/  # must end with /
    netcdf-file-name: CCTM_v502_with_CDC2010_Linux2_x86_64intel.ACONC.20100101.combine_base 
    netcdf-file-pattern-match: .*\.combine_base
    netcdf-file-date-partno: 2 
    out-csv-path: /projects/datatrans/CMAQ/2010/csv/  # must end with /
    out-csv-file-name: cmaq
    data-vars: # enter data vars of interest in CMAQ 2010 netCDF files
       - O3
       - PMIJ
       - FORM
       - ALD2
       - ALDX
cmaq2011:
    netcdf-path: /projects/datatrans/CMAQ/2011/raw/  # must end with /
    netcdf-file-name: CCTM_CMAQ_v51_Release_Oct23_NoDust_ed_emis_combine.aconc.01
    netcdf-file-pattern-match: CCTM_CMAQ_v51_Release_Oct23_NoDust_ed_emis_combine\.aconc\.0[1-9]|1[0-2]
    out-csv-path: /projects/datatrans/CMAQ/2011/csv/  # must end with /
    out-csv-file-name: cmaq2011
    data-vars: # enter data vars of interest in CMAQ 2011 netCDF files
       - O3
       - PMIJ
       - FORM
       - ALD2
       - ALDX
```

### Running with Conda

From directory: `nih-exposures-api/data-sources/cmaq/`

Example using `conda` on OSX:

```
$ cd nih-exposures-api/data-sources/cmaq/
$ conda create --name cmaq
$ source activate cmaq
$ conda install --channel conda-forge --yes --file requirements.txt
```

Invoke by (exmaple using 2011):

```
$ /PATH_TO/anaconda/envs/cmaq/bin/python create_cmaq_csv-2011.py
Writing to /Users/stealey/CMAQ/2011/csv/cmaq201101.csv - this might take awhile ...
Done!

Process finished with exit code 0
```