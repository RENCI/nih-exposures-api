# Utility functions to support CMAQ related exposures

from netCDF4 import Dataset, num2date, date2num
from pyproj import Proj, transform

# Convert lat lon point (in decimal degree format) to row col in CMAQ grid
def latlon2rowcol(latitude, longitude):

    # CMAQ uses Lambert Conformal Conic projection
    proj = 'lcc'
    row_now = -1
    col_no = -1


    # open CMAQ 12K NetCDF file (47Gb!!)
    #dataset = Dataset('./projects/datatrans/CMAQ/2011/CCTM_CMAQ_v51_Release_Oct23_NoDust_ed_emis_combine.aconc.01')
    #print(dataset.file_format)

    # pull out some attributes we need
    #sdate = getattr(dataset, 'SDATE')
    #stime = getattr(dataset, 'STIME')
    #number_of_columns = getattr(dataset, 'NCOLS') # 459
    #number_of_rows = getattr(dataset, 'NROWS') # 299
    #lat_0 = getattr(dataset, 'YCENT') # 40.0
    #lat_1 = getattr(dataset, 'P_ALP') # 33.0
    #lat_2 = getattr(dataset, 'P_BET') # 45.0
    #lon_0 = getattr(dataset, 'XCENT') # -97
    #xorig = getattr(dataset, 'XORIG') # -2556000.0
    #yorig = getattr(dataset, 'YORIG') # -1728000.0
    #xcell = getattr(dataset, 'XCELL') # 12000.0
    #ycell = getattr(dataset, 'YCELL') # 12000.0


    # NEED TO CHANGE THIS TO GET PROJECTION VALUES FROM CONFIG FILE or DB?
    number_of_columns = 459
    number_of_rows = 299
    lat_0 = "40.0"
    lat_1 = "33.0"
    lat_2 = "45.0"
    lon_0 = "-97"
    xorig = -2556000.0
    yorig = -1728000.0
    xcell = 12000.0
    ycell = 12000.0

    #dataset.close()


    # Create the CMAQ projection so we can do some conversions
    proj_str = "+proj=" + proj + " +lon_0=" + str(lon_0) + " +lat_0=" + str(lat_0) + \
           " +lat_1=" + str(lat_1) + " +lat_2=" + str(lat_2) + " +units=meters"

    p1 = Proj(projparams=proj_str)

    x1,y1 = p1(latitude, longitude)

    # verify the points are in the grid
    if((x1>=xorig) and (x1<=(xorig+(xcell*number_of_columns))) and
       (y1>=yorig) and (y1<=(yorig+(ycell*number_of_rows)))):
        
        # find row and column in grid     
        column_no=int(abs((xorig)-x1)/xcell) + 1
        row_no=int((abs(yorig)+y1)/ycell) + 1

    return row_no, col_no 
