# main.py
import os
import yaml
import json
import shutil
from fastapi import FastAPI, File, UploadFile

app = FastAPI()

@app.post("/file/upload")
async def upload_file(file: UploadFile):
    
    upload_dir = os.path.join(os.getcwd(), "uploads")

    # Create the upload directory if it doesn't exist
    if not os.path.exists(upload_dir):
        os.makedirs(upload_dir)

    # get the destination path
    dest = os.path.join(upload_dir, file.filename)

    # copy the file contents
    with open(dest, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)

    return {"filename": file.filename}

@app.post("/read/yaml/{fname}")
async def read_yaml(fname: str):
    
    with open(fname, 'r') as file:
        data = yaml.safe_load(file)
        # data = json.loads(file)

    return {"data": data, "filename": fname}
