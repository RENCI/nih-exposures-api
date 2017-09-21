import sys
import re
from datetime import datetime, date, timedelta
import pytz
from sqlalchemy import create_engine, exists, and_
from models import CmaqExposuresDatum, CmaqExposuresList
from configparser import ConfigParser
from flask import jsonify
from controllers import Session
import json
from .cmaq_utils import latlon2rowcol

parser = ConfigParser()
parser.read('ini/connexion.ini')
sys.path.append(parser.get('sys-path', 'exposures'))
sys.path.append(parser.get('sys-path', 'controllers'))

class CmaqExposures(object):

    def is_valid_date_range(self, **kwargs):
        session = Session()
        min_date = session.query(CmaqExposuresList.start_date).filter(
            CmaqExposuresList.exposure_type == kwargs.get('exposureType')).one()
        max_date = session.query(CmaqExposuresList.end_date).filter(
            CmaqExposuresList.exposure_type == kwargs.get('exposureType')).one()
        session.close()
        if min_date[0] > datetime.strptime(kwargs.get('endDate'), "%Y-%m-%d").date():
            return False
        elif max_date[0] < datetime.strptime(kwargs.get('startDate'), "%Y-%m-%d").date():
            return False
        elif datetime.strptime(kwargs.get('startDate'), "%Y-%m-%d").date() > \
                datetime.strptime(kwargs.get('endDate'), "%Y-%m-%d").date():
            return False
        else:
            return True

    def is_valid_lat_lon(self, **kwargs):
        (valid_points, message, pt) = self.validate_coordinate_point(**kwargs)
	
        return valid_points
        
    def validate_coordinate_point(self, **args):
        session = Session()
        latlon = session.query(CmaqExposuresList.resolution).filter(
            CmaqExposuresList.latLon == args.get('exposureType')).one()
        session.close()

        # if lat is populated - make sure lon is too - and vise versa
        try:
            y, x =  latlon.split(",")
        except:
            return False, ('Not Found', 400, {'x-error': 'Both latitude and longitude must be specified to search for'
                                                         ' a point'}), []
        lat = float(y)
        lon = float(x)
        pt = [lat, lon]

        # check format of coordinates, if provided
        if lat is not None and len is not None:
            # check latitude
            if re.match("^(\+|-)?(?:90(?:(?:\.0{1,})?)|(?:[0-9]|[1-8][0-9])(?:(?:\.[0-9]{1,})?))$", lat) is None:
                return False, ('Not Found', 400, {'x-error': 'Invalid latitude'}), []

            # check longitude
            if re.match("^(\+|-)?(?:180(?:(?:\.0{1,})?)|(?:[0-9]|[1-9][0-9]|1[0-7][0-9])(?:(?:\.[0-9]{1,})?))$", lon) is None:
                return False, ('Not Found', 400, {'x-error': 'Invalid longitude'}), []

        return True, '', pt

    def is_valid_resolution(self, **kwargs):
        res_set = set()
        session = Session()
        res = session.query(CmaqExposuresList.resolution).filter(
            CmaqExposuresList.exposure_type == kwargs.get('exposureType')).one()
        session.close()
        for item in res:
            res_set.update(item.split(';'))
        if kwargs.get('resolution') not in res_set:
            return False
        else:
            return True

    def is_valid_aggregation(self, **kwargs):
        agg_set = set()
        session = Session()
        agg = session.query(CmaqExposuresList.aggregation).filter(
            CmaqExposuresList.exposure_type == kwargs.get('exposureType')).one()
        session.close()
        for item in agg:
            agg_set.update(item.split(';'))
        if kwargs.get('aggregation') not in agg_set:
            return False
        else:
            return True

    def is_valid_utc_offset(self, **kwargs):
        off_set = set(range(-12, 15))
        if kwargs.get('utcOffset') not in off_set:
            return False
        else:
            return True

    def validate_parameters(self, **kwargs):
        if not self.is_valid_date_range(**kwargs):
            return 'Invalid parameter', 400, {'x-error': 'Invalid parameter: startDate, endDate'}
        elif not self.is_valid_lat_lon(**kwargs):
            return 'Invalid parameter', 400, {'x-error': 'Invalid parameter: latLon'}
        elif not self.is_valid_resolution(**kwargs):
            return 'Invalid parameter', 400, {'x-error': 'Invalid parameter: resolution'}
        elif not self.is_valid_aggregation(**kwargs):
            return 'Invalid parameter', 400, {'x-error': 'Invalid parameter: aggregation'}
        elif not self.is_valid_utc_offset(**kwargs):
            return 'Invalid parameter', 400, {'x-error': 'Invalid parameter: utcOffset'}
        else:
            return True

    def get_scores(self, **kwargs):
        # exposureType, startDate, endDate, latLon, resolution = None, aggregation = None, utcOffset = None
        data = self.validate_parameters(**kwargs)

        # data = jsonify({"scores": [{"score": '10',
        #                             "dateTime": datetime.now(pytz.timezone('UTC')).isoformat(timespec='milliseconds'),
        #                             "latLon": kwargs.get('latLon')}]})

        return data

    def get_values(self, **kwargs):
        # exposureType, startDate, endDate, latLon, resolution = None, aggregation = None, utcOffset = None
        data = self.validate_parameters(**kwargs)

        return data
