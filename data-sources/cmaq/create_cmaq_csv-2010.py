# application to read CMAQ netCDF file and create 
# desired CSV file, suitable for loading into DB

import numpy as np
import pandas as pd
import xarray as xr
import datetime
import yaml
import os
import re

# get file path configs
fd = open("./create_cmaq_csv_config.yml")
config = yaml.safe_load(fd)
fd.close()
cmaq2010 = config['cmaq2010']

# get all 2010 CMAQ files in configured dir
inpath = cmaq2010['netcdf-path']
pat = cmaq2010['netcdf-file-pattern-match']
files = [f for f in os.listdir(inpath) if re.match(pat, f)]

for file in files:
    # open CMAQ file into xarray Dataset
    ds = xr.open_dataset(inpath+file, decode_coords=True)

    # drop all unused variables in the Dataset
    new_ds = ds
    for var in ds.data_vars:
        if(var not in cmaq2010['data-vars']):
            new_ds = new_ds.drop(var)
        
    # delete LAY dimension?
    # not for now

    # re-start col, row dimensions at 1
    new_ds.coords['COL'] = new_ds.coords['COL'] + 1
    new_ds.coords['ROW'] = new_ds.coords['ROW'] + 1
        
    # add date range coords to TSTEP dimension
    sdate = str(getattr(new_ds, 'SDATE'))
    # for now, :STIME is defined as 0 in 2010 CMAQ files
    # so do not need to add onto start date
    stime = getattr(new_ds, 'STIME')
    date_str = datetime.datetime.strptime(sdate, '%Y%j')
    tstep_len = len(new_ds.coords['TSTEP'])
    new_ds.coords['TSTEP'] = pd.date_range(date_str, freq='H', periods=tstep_len)

    # save to CSV
    # get date from filename
    partno = int(cmaq2010['netcdf-file-date-partno'])
    parts = file.split(".")
    outfile = cmaq2010['out-csv-path'] + cmaq2010['out-csv-file-name'] + parts[partno] + ".csv"
    print("Writing to " + outfile + " ...")
    fd = open(outfile, 'w')
    df1 = new_ds.to_dataframe()
    df1.to_csv(path_or_buf=fd) #, sep=',', na_rep='', float_format=None, columns=None, header=True, index=True, index_label=None, mode='a', encoding=None, compression=None, quoting=None, quotechar='"', line_terminator='\n', chunksize=None, tupleize_cols=False, date_format=None, doublequote=True, escapechar=None, decimal='.')
    fd.close()

print("Done!")
