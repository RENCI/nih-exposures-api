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
cmaq2011 = config['cmaq2011']

# get all 2011 CMAQ files in configured dir
inpath = cmaq2011['netcdf-path']
pat = cmaq2011['netcdf-file-pattern-match']
files = [f for f in os.listdir(inpath) if re.match(pat, f)]

for file in files:

    # open CMAQ file into xarray Dataset
    ds = xr.open_dataset(inpath+file, decode_coords=True)

    # drop all unused variables in the Dataset
    new_ds = ds
    for var in ds.data_vars:
        if(var not in cmaq2011['data-vars']):
            new_ds = new_ds.drop(var)
        
    # delete LAY dimension?
    # not for now

    # re-start col, row dimensions at 1
    new_ds.coords['COL'] = new_ds.coords['COL'] + 1
    new_ds.coords['ROW'] = new_ds.coords['ROW'] + 1
        

    # add date range coords to TSTEP dimension

    sdate = str(getattr(new_ds, 'SDATE'))
    # :STIME is normally 10000 in CMAQ 2011 netcdf files
    # representing HH:MM:SS
    # not sure how else to do this this - but if hour is not zero padded
    # cannot use datetime time formatting
    # just handle hour based start dates for now
    stime = getattr(new_ds, 'STIME')
    hr = int(stime)/10000
    date_str = datetime.datetime.strptime(sdate, '%Y%j')

    # add start hour
    date_str = date_str + datetime.timedelta(hours=hr)
    tstep_len = len(new_ds.coords['TSTEP'])
    new_ds.coords['TSTEP'] = pd.date_range(date_str, freq='H', periods=tstep_len)

    # save to CSV
    # get month from filename
    month = file.split(".")[-1]
    outfile = cmaq2011['out-csv-path'] + cmaq2011['out-csv-file-name'] + month + ".csv"
    print("Writing to " + outfile + " - this might take awhile ...")
    fd = open(outfile, 'w')
    df1 = new_ds.to_dataframe()
    df1.to_csv(path_or_buf=fd) #, sep=',', na_rep='', float_format=None, columns=None, header=True, index=True, index_label=None, mode='a', encoding=None, compression=None, quoting=None, quotechar='"', line_terminator='\n', chunksize=None, tupleize_cols=False, date_format=None, doublequote=True, escapechar=None, decimal='.')
    fd.close()

print("Done!")
