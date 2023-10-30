from models.DBModel import Base
from config.DBConfig import DBConfig

def create_tables():
    Base.metadata.create_all(bind=DBConfig.engine)

create_tables()