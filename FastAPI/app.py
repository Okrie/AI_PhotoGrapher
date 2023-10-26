from fastapi import FastAPI
from fastapi import Request
from fastapi.templating import Jinja2Templates
from typing import Union
import os
import pymysql

app = FastAPI()
templates = Jinja2Templates(directory="templates")

@app.get('/')
def read_root(request: Request):
    return templates.TemplateResponse('index.html', {'request' : request})

# import subprocess

# result = subprocess.run(["python", "--version"], stdout=subprocess.PIPE, text=True)
# print(result.stdout)
