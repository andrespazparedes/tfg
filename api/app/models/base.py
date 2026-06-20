from sqlalchemy.orm import DeclarativeBase
from sqlalchemy import MetaData

# We use a specific schema 'app' for our internal tables
metadata_obj = MetaData(schema="app")

class Base(DeclarativeBase):
    metadata = metadata_obj
