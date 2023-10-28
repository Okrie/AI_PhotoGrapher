from ..config.Config import db
from pydantic import BaseModel

class User(db.Model):
    __tablename__ = "user"
    id = db.Column(db.String(20), primary_key=True)
    password = db.Column(db.String(45), nullable=False)

class Photographer(db.Model):
    __tablename__ = "photographer"
    seq = db.Column(db.Integer(), primary_key=True)
    pauthor = db.Column(db.String(45), nullable=False)
    price = db.Column(db.Integer(), nullable=False)

class Purchase(db.Model):
    __tablename__ = "purchase"
    seq = db.Column(db.Integer(), primary_key=True)
    userid = db.Column(db.String(20), primary_key=True)
    paid = db.Column(db.Integer())
    price = db.Column(db.Integer())