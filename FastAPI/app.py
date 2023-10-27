from fastapi import FastAPI, Response
from fastapi import Request
from fastapi.templating import Jinja2Templates
from typing import Union
import os, sys
import pymysql
import zipfile
# sys.path.append(os.path.abspath(os.path.dirname(__file__)))
from pred.predImages import PredImages

app = FastAPI()
templates = Jinja2Templates(directory="templates")

@app.get('/')
def read_root(request: Request):
    return templates.TemplateResponse('index.html', {'request' : request})


@app.get('/pred')
async def pred_image(request: Request):
    pi = PredImages()
    result = pi.pred()
    
    return {'result' : result}, 200


# import subprocess

# result = subprocess.run(["python", "--version"], stdout=subprocess.PIPE, text=True)
# print(result.stdout)
