import requests
from pprint import pprint

try:
    url = 'http://127.0.0.1:8000/file/upload'
    file = {'file': open("D:/downloads/temp.txt", 'r')}
    resp = requests.post(url=url, files=file) 
except Exception as inst:
    print(inst)

# try:
#     url = 'http://127.0.0.1:8000/read/yaml/config.json'
#     resp = requests.post(url=url) 
# except Exception as inst:
#     print(inst)

pprint(resp.json())