from fastapi import FastAPI, Response, UploadFile, File, Depends
from fastapi import Request
from fastapi.templating import Jinja2Templates
from fastapi.responses import JSONResponse
from pred.predImages import PredImages
from sqlalchemy.orm import Session
from .models.DBModel import User, Photographer, Purchase
from .config.DBConfig import DBConfig
from pydantic import BaseModel
import os

app = FastAPI()
database = DBConfig()
templates = Jinja2Templates(directory="templates")

@app.get('/')
def read_root(request: Request):
    return templates.TemplateResponse('index.html', {'request' : request})

@app.get('/getusers')
def get_users(db: Session = Depends(database.get_db)):
    users = db.query(User).all()
    return users

@app.get('/auth/user')
def loginuser(user: User, db: Session = Depends(database.get_db)):
    # 사용자 정보 조회
    existing_user = db.query(User).filter(User.id == user.id).first()

    if (not existing_user) | (existing_user.password != user.password):
        return {'result' : 'Wrong ID or Paswword'}, 400

    return {'result' : 'Login Success'}, 200

@app.get('/auth/user/register')
def registeruser(user: User, db: Session = Depends(database.get_db)):
    # ID 중복 체크
    existing_user = db.query(User).filter(User.id == user.id).first()
    if existing_user:
        return {'result' : 'ID Duplicated'}, 403

    db.add(user)
    db.commit()

    return {'result' : 'Register Success'}, 200

@app.get('/purchase')
def purchaseFilter(pur: Purchase, db: Session = Depends(database.get_db)):
    # ID Check
    existing_user = db.query(User).filter(User.id == pur.id).first()
    if not existing_user:
        return {'result' : 'Not User'}, 403

    db.add(pur)
    db.commit()

    return {'result' : 'Purchase Success'}, 200


@app.post('/pred')
async def pred_image(image: UploadFile = File(...)):
    # try:
    contents = await image.read()  
    with open(f"{os.path.realpath('.')}/pred/pred_image/{image.filename}.jpg", "wb") as f:
        f.write(contents)
    print(image.filename)
    pi = PredImages()
    result = pi.pred(image.filename)

    return {'result' : result}, 200



# import subprocess

# result = subprocess.run(["python", "--version"], stdout=subprocess.PIPE, text=True)
# print(result.stdout)
