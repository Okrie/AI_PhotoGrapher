from fastapi import FastAPI, Response, UploadFile, File
from fastapi import Request
from fastapi.templating import Jinja2Templates
from fastapi.responses import JSONResponse
from pred.predImages import PredImages
import os

app = FastAPI()
templates = Jinja2Templates(directory="templates")

@app.get('/')
def read_root(request: Request):
    return templates.TemplateResponse('index.html', {'request' : request})


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
    # except Exception as e:
        # return JSONResponse(status_code=400, content={"message": f"Error occurred: {e}"})


# import subprocess

# result = subprocess.run(["python", "--version"], stdout=subprocess.PIPE, text=True)
# print(result.stdout)
