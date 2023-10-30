"""
    app.py
"""

from fastapi import FastAPI, UploadFile, File, Depends
from fastapi import Request
from fastapi.templating import Jinja2Templates
from fastapi.staticfiles import StaticFiles
from pred.predImages import PredImages
from sqlalchemy.orm import Session
from models.DBModel import *
from config.DBConfig import DBConfig
import os

app = FastAPI()
database = DBConfig()
templates = Jinja2Templates(directory="templates")

# 메인
@app.post('/', status_code=201)
def read_root(request: Request):
    return templates.TemplateResponse('index.html', {'request' : request})

# 이미지 연결
app.mount("/images", StaticFiles(directory="static/author"), name="images")

# 작가 정보
@app.get('/getauthors')
def get_authors(db: Session = Depends(database.get_db)):
    authors = db.query(PhotographerDB).all()
    return authors

# 유저 로그인
@app.post('/auth/user', status_code=201)
def login_user(user: User, db: Session = Depends(database.get_db)):
    # 사용자 정보 조회
    existing_user = db.query(UserDB).filter(UserDB.id == user.id).first()
    if (not existing_user) | (existing_user.password != user.password):
        return {'result' : 'Fail'}, 400

    return {'result' : 'Success'}, 200

# 유저 등록
@app.post('/auth/user/register', status_code=201)
def register_user(user: User, db: Session = Depends(database.get_db)):
    # ID 중복 체크
    existing_user = db.query(UserDB).filter(UserDB.id == user.id).first()
    if existing_user:
        return {'result' : 'ID Duplicated'}, 403
    new_user = UserDB(**user.model_dump())  # SQLAlchemy 모델 생성
    db.add(new_user)
    db.commit()
    return {'result' : 'Success'}, 200

# 유저 구매
@app.post('/purchase', status_code=201)
def purchase_filter(userid: str, pseq: int, db: Session = Depends(database.get_db)):
    # ID Check
    existing_user = db.query(UserDB).filter(UserDB.id == userid).all()
    if not existing_user:
        return {'result' : 'Not User'}, 403
    # Author Check
    existing_author = db.query(PhotographerDB).filter(PhotographerDB.seq == pseq).first()
    if not existing_author:
        return {'result' : 'Not Author'}, 403
    existing_purchase = db.query(PurchaseDB).filter(PhotographerDB.seq == pseq, UserDB.id == userid).first()
    if existing_purchase:
        return {'result' : 'Fail'}, 200
    pur = Purchase(seq=existing_author.seq, userid=userid, paid=existing_author.price, expired=existing_author.count)
    new_purchase = PurchaseDB(**pur.model_dump())  # SQLAlchemy 모델 생성
    db.add(new_purchase)
    db.commit()
    return {'result' : 'Success'}, 200

# 필터 사용
@app.post('/usefilter', status_code=201)
def use_filter(userid: str, pseq: int, db: Session = Depends(database.get_db)):
    # ID Check
    existing_user = db.query(UserDB).filter(UserDB.id == userid).all()
    if not existing_user:
        return {'result' : 'Not User'}, 403
    # Purchase Author Check
    existing_author = db.query(PurchaseDB).filter(PurchaseDB.seq == pseq).first()
    if not existing_author:
        return {'result' : 'Not Author'}, 403
    if existing_author.expired-1 < 0:
        return {'result' : 'Expired'}, 403
    else:
        existing_author.expired = existing_author.expired-1
        db.commit()
        return {'result' : 'Success'}, 200

# 유저 구매 목록
@app.post('/userinfo', status_code=201)
def purchase_info(userid: str, db: Session = Depends(database.get_db)):
    # ID Check
    existing_user = db.query(PurchaseDB).filter(PurchaseDB.userid == userid).all()
    if not existing_user:
        return {'result' : 'Fail'}, 403
    return {'result' : existing_user}, 200

# AI 예측
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
