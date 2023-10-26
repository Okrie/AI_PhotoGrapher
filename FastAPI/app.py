from fastapi import FastAPI
from fastapi import Request
from fastapi.templating import Jinja2Templates
from typing import Union
import os
import pymysql
from .static.pred import pred


app = FastAPI()
templates = Jinja2Templates(directory="templates")

@app.get('/')
def read_root(request: Request):
    return templates.TemplateResponse('index.html', {'request' : request})


@app.get('/pred')
def pred_image(request: Request):

    return pred()
    

# import subprocess

# result = subprocess.run(["python", "--version"], stdout=subprocess.PIPE, text=True)
# print(result.stdout)
