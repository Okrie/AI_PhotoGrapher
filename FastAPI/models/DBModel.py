"""
    models/DBModel.py
"""

from config.Config import db
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, String, Integer, ForeignKey
from pydantic import BaseModel

Base = declarative_base()
class UserDB(Base):
    __tablename__ = "user"
    id = Column(String(20), primary_key=True)
    password = Column(String(45), nullable=False)

class User(BaseModel):
    id: str
    password: str

class PhotographerDB(Base):
    __tablename__ = "photographer"
    seq = Column(Integer(), primary_key=True)
    pauthor = Column(String(45), nullable=False)
    pnickname = Column(String(45))
    price = Column(Integer(), nullable=False)
    count = Column(Integer())
    pimage = Column(String())

class Photographer(BaseModel):
    seq: int
    pauthor: str
    pnickname: str
    price: int
    count: int
    pimage: str

class PurchaseDB(Base):
    __tablename__ = "purchase"
    seq = Column(Integer(), ForeignKey('photographer.seq'), primary_key=True)
    userid = Column(String(20), ForeignKey('user.id'), primary_key=True)
    paid = Column(Integer())
    expired = Column(Integer())

    def as_dict(self):
        return {c.name: getattr(self, c.name) for c in self.__table__.columns}


class Purchase(BaseModel):
    seq: int
    userid: str
    paid: int
    expired: int