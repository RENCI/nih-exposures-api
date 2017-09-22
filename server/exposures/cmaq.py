import sys
from datetime import datetime, timedelta
import pytz
from models import CmaqExposuresDatum, CmaqExposuresList
from configparser import ConfigParser
from flask import jsonify
from controllers import Session
from random import uniform

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
        # TODO
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
                      'eastern': 'Eastern',
                      'central': 'Central',
                      'mountain': 'Mountain',
                      'pacific': 'Pacific'}
        is_valid, message = self.validate_parameters(**kwargs)
        if not is_valid:
            return message

        if kwargs.get('resolution') == 'hour':
            time_delta = 1
        else:
            time_delta = 24

        data = {}
        data['scores'] = []
        if kwargs.get('utcOffset') == 'utc':
            tzone = pytz.timezone(tzone_dict.get(kwargs.get('utcOffset')))
        else:
            tzone = pytz.timezone('US/' + tzone_dict.get(kwargs.get('utcOffset')))

        lat_lon_set = kwargs.get('latLon').split(';')
        for lat_lon in lat_lon_set:
            exposure_time = tzone.localize(datetime.strptime(kwargs.get('startDate'), "%Y-%m-%d"))
            end_time = tzone.localize(datetime.strptime(kwargs.get('endDate'), "%Y-%m-%d"))

            while exposure_time <= (end_time + timedelta(hours=23)):
                data['scores'] += [{'dateTime': exposure_time,
                                    'latLon': lat_lon,
                                    'score': round(uniform(1,5),4)}]
                exposure_time += timedelta(hours=time_delta)

        return jsonify(data)

    def get_values(self, **kwargs):
        # exposureType, startDate, endDate, latLon, resolution = None, aggregation = None, utcOffset = None
        # 'UTC', 'US/Central', 'US/Eastern','US/Mountain', 'US/Pacific'
        tzone_dict = {'utc': 'UTC',
                      'eastern': 'Eastern',
                      'central': 'Central',
                      'mountain': 'Mountain',
                      'pacific': 'Pacific'}
        is_valid, message = self.validate_parameters(**kwargs)
        if not is_valid:
            return message

        if kwargs.get('resolution') == 'hour':
            time_delta = 1
        else:
            time_delta = 24

        data = {}
        data['values'] = []
        if kwargs.get('utcOffset') == 'utc':
            tzone = pytz.timezone(tzone_dict.get(kwargs.get('utcOffset')))
        else:
            tzone = pytz.timezone('US/' + tzone_dict.get(kwargs.get('utcOffset')))

        lat_lon_set = kwargs.get('latLon').split(';')
        for lat_lon in lat_lon_set:
            exposure_time = tzone.localize(datetime.strptime(kwargs.get('startDate'), "%Y-%m-%d"))
            end_time = tzone.localize(datetime.strptime(kwargs.get('endDate'), "%Y-%m-%d"))

            while exposure_time <= (end_time + timedelta(hours=23)):
                if kwargs.get('exposureType') == 'pm25':
                    exp_val = round(uniform(0, 50), 4)
                else:
                    exp_val = round(uniform(0, 0.2), 4)
                data['values'] += [{'dateTime': exposure_time,
                                    'latLon': lat_lon,
                                    'value': exp_val}]
                exposure_time += timedelta(hours=time_delta)

        return jsonify(data)
