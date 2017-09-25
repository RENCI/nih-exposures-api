import sys
import importlib
from sqlalchemy import create_engine, exists, and_
from models import CmaqExposuresDatum, CmaqExposuresList
from flask import jsonify
from configparser import ConfigParser
from controllers import Session

parser = ConfigParser()
parser.read('ini/connexion.ini')
sys.path.append(parser.get('sys-path', 'exposures'))
sys.path.append(parser.get('sys-path', 'controllers'))


def cmaq_get() -> str:
    session = Session()
    results = session.query(CmaqExposuresList).all()
    data = jsonify({"cmaq": [dict(exposureType=o.exposure_type,
                                  exposureUnit=o.exposure_unit,
                                  startDate=o.start_date,
                                  endDate=o.end_date,
                                  resolution=o.resolution.split(';'),
                                  aggregation=o.aggregation.split(';')) for o in results]})
    return data


def cmaq_get_scores_get(exposureType, startDate, endDate, latLon, resolution = None, aggregation = None, utcOffset = None) -> str:
    session = Session()
    if not session.query(exists().where(CmaqExposuresList.exposure_type == exposureType)).scalar():
        return 'Invalid parameter', 400, {'x-error': 'Invalid parameter: exposureType'}
    session.close()
    from cmaq import CmaqExposures
    cmaq = CmaqExposures()
    kwargs = locals()
    data = cmaq.get_scores(**kwargs)

    return data


def cmaq_get_values_get(exposureType, startDate, endDate, latLon, resolution = None, aggregation = None, utcOffset = None) -> str:
    session = Session()
    if not session.query(exists().where(CmaqExposuresList.exposure_type == exposureType)).scalar():
        return 'Invalid parameter', 400, {'x-error': 'Invalid parameter: exposureType'}
    session.close()
    from cmaq import CmaqExposures
    cmaq = CmaqExposures()
    kwargs = locals()
    data = cmaq.get_values(**kwargs)

    return data
