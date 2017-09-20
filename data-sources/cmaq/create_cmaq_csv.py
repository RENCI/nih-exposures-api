# application to read CMAQ netCDF file and create 
# desired CSV file, suitable for loading into DB

import numpy as np
import pandas as pd
import xarray as xr
import datetime
import yaml

# get file path configs
fd = open("./create_cmaq_csv_config.yml")
config = yaml.safe_load(fd)
fd.close()
cmaq2011 = config['cmaq2011']

# open CMAQ file into xarray Dataset
infile = cmaq2011['netcdf-path'] + cmaq2011['netcdf-file-name']
ds = xr.open_dataset(infile, decode_coords=True)

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
stime = getattr(new_ds, 'STIME')
date_str = datetime.datetime.strptime(sdate, '%Y%j')
tstep_len = len(new_ds.coords['TSTEP'])
new_ds.coords['TSTEP'] = pd.date_range(date_str, freq='H', periods=tstep_len)

# save to CSV
outfile = cmaq2011['out-csv-path'] + cmaq2011['out-csv-file-name']
print("Writing to " + outfile + " - this might take awhile ...")
fd = open(outfile, 'w')
df1 = new_ds.to_dataframe()
df1.to_csv(path_or_buf=fd) #, sep=',', na_rep='', float_format=None, columns=None, header=True, index=True, index_label=None, mode='a', encoding=None, compression=None, quoting=None, quotechar='"', line_terminator='\n', chunksize=None, tupleize_cols=False, date_format=None, doublequote=True, escapechar=None, decimal='.')
fd.close()
print("Done!")
