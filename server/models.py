# coding: utf-8
from sqlalchemy import ARRAY, Boolean, CheckConstraint, Column, Date, DateTime, Float, Index, Integer, String, Table, Text, text
from geoalchemy2.types import Geometry
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.dialects.postgresql import TEXT, DOUBLE_PRECISION

Base = declarative_base()
metadata = Base.metadata


class CmaqExposuresDatum(Base):
    __tablename__ = 'cmaq_exposures_data'
    __table_args__ = (
        Index('col_row_date', 'col', 'row', 'utc_date_time', unique=True),
    )

    id = Column(Integer, primary_key=True, server_default=text("nextval('cmaq_exposures_data_id_seq'::regclass)"))
    col = Column(Integer)
    row = Column(Integer)
    utc_date_time = Column(DateTime)
    o3 = Column(Float(53))
    o3_avg_24 = Column(Float(53))
    o3_max_24 = Column(Float(53))
    o3_avg_7day = Column(Float(53))
    o3_max_7day = Column(Float(53))
    o3_avg_14day = Column(Float(53))
    o3_max_14day = Column(Float(53))
    pmij = Column(Float(53))
    pmij_avg_24 = Column(Float(53))
    pmij_max_24 = Column(Float(53))
    pmij_avg_7day = Column(Float(53))
    pmij_max_7day = Column(Float(53))
    pmij_avg_14day = Column(Float(53))
    pmij_max_14day = Column(Float(53))


class CmaqExposuresList(Base):
    __tablename__ = 'cmaq_exposures_list'

    id = Column(Integer, primary_key=True, server_default=text("nextval('cmaq_exposures_list_id_seq'::regclass)"))
    exposure_type = Column(Text)
    exposure_unit = Column(Text)
    start_date = Column(Date)
    end_date = Column(Date)
    resolution = Column(Text)
    aggregation = Column(Text)


t_geography_columns = Table(
    'geography_columns', metadata,
    Column('f_table_catalog', String),
    Column('f_table_schema', String),
    Column('f_table_name', String),
    Column('f_geography_column', String),
    Column('coord_dimension', Integer),
    Column('srid', Integer),
    Column('type', Text)
)


t_geometry_columns = Table(
    'geometry_columns', metadata,
    Column('f_table_catalog', String(256)),
    Column('f_table_schema', String),
    Column('f_table_name', String),
    Column('f_geometry_column', String),
    Column('coord_dimension', Integer),
    Column('srid', Integer),
    Column('type', String(30))
)


t_raster_columns = Table(
    'raster_columns', metadata,
    Column('r_table_catalog', String),
    Column('r_table_schema', String),
    Column('r_table_name', String),
    Column('r_raster_column', String),
    Column('srid', Integer),
    Column('scale_x', Float(53)),
    Column('scale_y', Float(53)),
    Column('blocksize_x', Integer),
    Column('blocksize_y', Integer),
    Column('same_alignment', Boolean),
    Column('regular_blocking', Boolean),
    Column('num_bands', Integer),
    Column('pixel_types', ARRAY(TEXT())),
    Column('nodata_values', ARRAY(DOUBLE_PRECISION(precision=53))),
    Column('out_db', Boolean),
    Column('extent', Geometry),
    Column('spatial_index', Boolean)
)


t_raster_overviews = Table(
    'raster_overviews', metadata,
    Column('o_table_catalog', String),
    Column('o_table_schema', String),
    Column('o_table_name', String),
    Column('o_raster_column', String),
    Column('r_table_catalog', String),
    Column('r_table_schema', String),
    Column('r_table_name', String),
    Column('r_raster_column', String),
    Column('overview_factor', Integer)
)


class SpatialRefSy(Base):
    __tablename__ = 'spatial_ref_sys'
    __table_args__ = (
        CheckConstraint('(srid > 0) AND (srid <= 998999)'),
    )

    srid = Column(Integer, primary_key=True)
    auth_name = Column(String(256))
    auth_srid = Column(Integer)
    srtext = Column(String(2048))
    proj4text = Column(String(2048))
