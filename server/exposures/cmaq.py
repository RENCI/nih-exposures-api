import sys
from datetime import datetime, timedelta
import pytz
from sqlalchemy import extract
from configparser import ConfigParser
from flask import jsonify
from models import CmaqExposuresDatum, CmaqExposuresList
from controllers import Session
from exposures.cmaq_utils import latlon2rowcol, cmaq_calc_score

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
        # lat: 0 to +/- 90, lon: 0 to +/- 180 as lat,lon
        import re
        latlon = kwargs.get('latLon')
        for item in latlon.split(';'):
            if re.match(r'^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?),\s*[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)$',
                        item) is None:
                return False
        return True

    def is_valid_resolution(self, **kwargs):
        res_set = set()
        session = Session()
        res = session.query(CmaqExposuresList.resolution).filter(
            CmaqExposuresList.exposure_type == kwargs.get('exposureType')).one()
        session.close()
        for item in res:
            res_set.update(item.split(';'))
        if kwargs.get('resolution') in res_set:
            return True
        else:
            return False

    def is_valid_aggregation(self, **kwargs):
        agg_set = set()
        session = Session()
        agg = session.query(CmaqExposuresList.aggregation).filter(
            CmaqExposuresList.exposure_type == kwargs.get('exposureType')).one()
        session.close()
        for item in agg:
            agg_set.update(item.split(';'))
        if kwargs.get('aggregation') in agg_set:
            return True
        else:
            return False

    def is_valid_utc_offset(self, **kwargs):
        off_set = {'utc', 'eastern', 'central', 'mountain', 'pacific'}
        if kwargs.get('utcOffset') in off_set:
            return True
        else:
            return False

    def validate_parameters(self, **kwargs):
        if not self.is_valid_date_range(**kwargs):
            return False, ('Invalid parameter', 400, {'x-error': 'Invalid parameter: startDate, endDate'})
        elif not self.is_valid_lat_lon(**kwargs):
            return False, ('Invalid parameter', 400, {'x-error': 'Invalid parameter: latLon'})
        elif not self.is_valid_resolution(**kwargs):
            return False, ('Invalid parameter', 400, {'x-error': 'Invalid parameter: resolution'})
        elif not self.is_valid_aggregation(**kwargs):
            return False, ('Invalid parameter', 400, {'x-error': 'Invalid parameter: aggregation'})
        elif not self.is_valid_utc_offset(**kwargs):
            return False, ('Invalid parameter', 400, {'x-error': 'Invalid parameter: utcOffset'})
        else:
            return True, ''

    def get_scores(self, **kwargs):
        # exposureType, startDate, endDate, latLon, resolution = None, aggregation = None, utcOffset = None
        # 'UTC', 'US/Central', 'US/Eastern','US/Mountain', 'US/Pacific'
        tzone_dict = {'utc': 'UTC',
                      'eastern': 'US/Eastern',
                      'central': 'US/Central',
                      'mountain': 'US/Mountain',
                      'pacific': 'US/Pacific'}
        # validate input from user
        is_valid, message = self.validate_parameters(**kwargs)
        if not is_valid:
            return message
        # determine exposure type to query
        if kwargs.get('exposureType') == 'pm25':
            exposure = 'pmij'
        else:
            exposure = 'o3'
        # set resolution and aggregate to query
        if kwargs.get('resolution') == 'day':
            exposure += '_' + kwargs.get('aggregation') + '_24'
        elif kwargs.get('resolution') == '7day':
            exposure += '_' + kwargs.get('aggregation') + '_7day'
        elif kwargs.get('resolution') == '14day':
            exposure += '_' + kwargs.get('aggregation') + '_14day'
        # create data object
        data = {}
        data['scores'] = []
        # set UTC offset as time zone parameter for query
        dt = datetime.now()
        utc_offset = int(str(pytz.timezone(tzone_dict.get(kwargs.get('utcOffset'))).localize(dt)
                             - pytz.utc.localize(dt)).split(':')[0])
        # datetime objects for query and output adjustment
        start_time = datetime.strptime(kwargs.get('startDate'), "%Y-%m-%d")
        end_time = datetime.strptime(kwargs.get('endDate'), "%Y-%m-%d") + timedelta(hours=23)
        # retrieve query result for each lat,lon pair and add to data object
        lat_lon_set = kwargs.get('latLon').split(';')
        for lat_lon in lat_lon_set:
            coords = lat_lon.split(',')
            row, col = latlon2rowcol(coords[0], coords[1], str(start_time.year))
            session = Session()
            if kwargs.get('resolution') == 'hour':
                # hourly resolution of data - return all hours for date range
                query = session.query(CmaqExposuresDatum.id,
                                      CmaqExposuresDatum.utc_date_time,
                                      getattr(CmaqExposuresDatum, exposure)). \
                    filter(CmaqExposuresDatum.utc_date_time >= start_time + timedelta(hours=utc_offset)). \
                    filter(CmaqExposuresDatum.utc_date_time <= end_time + timedelta(hours=utc_offset)). \
                    filter(CmaqExposuresDatum.row == row). \
                    filter(CmaqExposuresDatum.col == col)
            else:
                # daily resolution of data - return only matched hours for date range
                query = session.query(CmaqExposuresDatum.id,
                                      CmaqExposuresDatum.utc_date_time,
                                      getattr(CmaqExposuresDatum, exposure)). \
                    filter(CmaqExposuresDatum.utc_date_time >= start_time + timedelta(hours=utc_offset)). \
                    filter(CmaqExposuresDatum.utc_date_time <= end_time + timedelta(hours=utc_offset)). \
                    filter(CmaqExposuresDatum.row == row). \
                    filter(CmaqExposuresDatum.col == col). \
                    filter(extract('hour', CmaqExposuresDatum.utc_date_time) == utc_offset)
            session.close()
            # add query output to data object in JSON structured format
            for cmaq_id, cmaq_date_time, cmaq_exp in query:
                # print(cmaq_id, cmaq_date_time, cmaq_exp)
                data['scores'].append({'dateTime': cmaq_date_time,
                                       'latLon': lat_lon,
                                       'score': str(cmaq_calc_score(kwargs.get('exposureType'), cmaq_exp))})
        return jsonify(data)

    def get_values(self, **kwargs):
        # exposureType, startDate, endDate, latLon, resolution = None, aggregation = None, utcOffset = None
        # 'UTC', 'US/Central', 'US/Eastern','US/Mountain', 'US/Pacific'
        tzone_dict = {'utc': 'UTC',
                      'eastern': 'US/Eastern',
                      'central': 'US/Central',
                      'mountain': 'US/Mountain',
                      'pacific': 'US/Pacific'}
        # validate input from user
        is_valid, message = self.validate_parameters(**kwargs)
        if not is_valid:
            return message
        # determine exposure type to query
        if kwargs.get('exposureType') == 'pm25':
            exposure = 'pmij'
        else:
            exposure = 'o3'
        # set resolution and aggregate to query
        if kwargs.get('resolution') == 'day':
            exposure += '_' + kwargs.get('aggregation') + '_24'
        elif kwargs.get('resolution') == '7day':
            exposure += '_' + kwargs.get('aggregation') + '_7day'
        elif kwargs.get('resolution') == '14day':
            exposure += '_' + kwargs.get('aggregation') + '_14day'
        # create data object
        data = {}
        data['values'] = []
        # set UTC offset as time zone parameter for query
        dt = datetime.now()
        utc_offset = int(str(pytz.timezone(tzone_dict.get(kwargs.get('utcOffset'))).localize(dt)
                             - pytz.utc.localize(dt)).split(':')[0])
        # datetime objects for query and output adjustment
        start_time = datetime.strptime(kwargs.get('startDate'), "%Y-%m-%d")
        end_time = datetime.strptime(kwargs.get('endDate'), "%Y-%m-%d") + timedelta(hours=23)
        # retrieve query result for each lat,lon pair and add to data object
        lat_lon_set = kwargs.get('latLon').split(';')
        for lat_lon in lat_lon_set:
            coords = lat_lon.split(',')
            row, col = latlon2rowcol(coords[0], coords[1], str(start_time.year))
            session = Session()
            if kwargs.get('resolution') == 'hour':
                # hourly resolution of data - return all hours for date range
                query = session.query(CmaqExposuresDatum.id,
                                      CmaqExposuresDatum.utc_date_time,
                                      getattr(CmaqExposuresDatum, exposure)). \
                    filter(CmaqExposuresDatum.utc_date_time >= start_time + timedelta(hours=utc_offset)). \
                    filter(CmaqExposuresDatum.utc_date_time <= end_time + timedelta(hours=utc_offset)). \
                    filter(CmaqExposuresDatum.row == row). \
                    filter(CmaqExposuresDatum.col == col)
            else:
                # daily resolution of data - return only matched hours for date range
                query = session.query(CmaqExposuresDatum.id,
                                      CmaqExposuresDatum.utc_date_time,
                                      getattr(CmaqExposuresDatum, exposure)).\
                    filter(CmaqExposuresDatum.utc_date_time >= start_time + timedelta(hours=utc_offset)).\
                    filter(CmaqExposuresDatum.utc_date_time <= end_time + timedelta(hours=utc_offset)).\
                    filter(CmaqExposuresDatum.row == row).\
                    filter(CmaqExposuresDatum.col == col).\
                    filter(extract('hour', CmaqExposuresDatum.utc_date_time) == utc_offset)
            session.close()
            # add query output to data object in JSON structured format
            for cmaq_id, cmaq_date_time, cmaq_exp in query:
                # print(cmaq_id, cmaq_date_time, cmaq_exp)
                data['values'].append({'dateTime': cmaq_date_time,
                                       'latLon': lat_lon,
                                       'value': str(cmaq_exp)})
        return jsonify(data)
