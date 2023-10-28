import os
from .Config import db
from sqlalchemy.orm import sessionmaker

DB_HOST = os.environ.get('DB_HOST')
DB_USER = os.environ.get('DB_USER')
DB_PORT = os.environ.get('DB_PORT')
DB_PASSWORD = os.environ.get('DB_PASSWORD')
DB_DATABASE = os.environ.get('DB_DATABASE')

class DBConfig:
    # MySQL 연결을 위한 SQLAlchemy Engine 생성
    DEBUG = True
    SQLALCHEMY_DATABASE_URI = f'{os.environ.get("DB_URI")}{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_DATABASE}?charset=utf8'
    SQLALCHEMY_TRACK_MODIFICATIONS = os.environ.get('TRACK_MODIFICATIONS')
    engine = db.create_engine(SQLALCHEMY_DATABASE_URI)

    # SQLAlchemy Session 생성
    SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

    # Dependency로 사용할 함수
    def get_db(self):
        db = self.SessionLocal()
        try:
            yield db
        finally:
            db.close()