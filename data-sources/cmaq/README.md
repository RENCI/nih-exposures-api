## CMAQ Data

The NetCDF processing scripts make use of the [Anaconda 3](https://www.anaconda.com) distribution of Python. Other variations may work, but are not being supported by this project.

### Conda

From directory: `nih-exposures-api/data-sources/cmaq/`

Example using `conda` on OSX:

```
$ cd nih-exposures-api/data-sources/cmaq/
$ conda create --name cmaq
$ source activate cmaq
$ conda install --channel conda-forge --yes --file requirements.txt
```

Invoke by:

```
$ /PATH_TO/anaconda/envs/cmaq/bin/python create_cmaq_csv.py
Writing to /out-csv-path/out-csv-file-name - this might take awhile ...
Done!

Process finished with exit code 0
```