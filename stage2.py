import re, json
from os import listdir, path
from pathlib import Path
from shutil import rmtree

with open('stage1.txt') as file:
  licenses = dict.fromkeys(file.read().splitlines())

scancode_jsons = [json.load(open('./scancode-licensedb/docs/' + f ,'r')) for f in listdir('scancode-licensedb/docs/') if (re.compile('^(?!index\\.json$).+\\.json$').match(f))]
for json_loader in scancode_jsons:
  try:
    spdx_license_key = json_loader['spdx_license_key']
    if spdx_license_key in licenses.keys():
      licenses[spdx_license_key] = json_loader['text']
  except:
    pass

manual_txts = [f.removesuffix('.txt') for f in listdir('manual-licenses/') if (re.compile('^.*\\.txt').match(f))]
for filename in manual_txts:
  with open('manual-licenses/' + filename + '.txt', 'r') as file_object:
    licenses[filename] = file_object.read()

with open ('license-exceptions.json', 'r') as file_object:
  json_loader = json.load(file_object)
  for license_key in json_loader:
    licenses.pop(license_key)

count = 0
for key, value in licenses.items():
  if value == None:
    count += 1
print(count)