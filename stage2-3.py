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

# with open ('exceptions.json', 'r') as file_object:
#   json_loader = json.load(file_object)
#   for license_key in json_loader:
#     licenses.pop(license_key)

manual_licenses = []
for key, value in licenses.items():
  if value == None:
    manual_licenses.append(key)
print(manual_licenses)
print(len(manual_licenses))

if path.exists('excluded-licenses'):
  rmtree('excluded-licenses')
Path('excluded-licenses').mkdir(parents=True, exist_ok=True)
# why can't i find arphic licenses anymore from the included licenses after inserting arhpic to manual licenses?
# create a dictionary inversed sort by keys and return n-1 and n+1 licenses from the each of the manually added licenses
excluded_licenses = []
search_string = r'\b(source|software|program|code|module|public\s+license|ware|\w+ware)\b'
for key in licenses:
  if licenses[key] and re.findall(search_string, licenses[key], re.IGNORECASE):
    pass
  elif licenses[key]:
    file_object = open('excluded-licenses/' + key + '.txt', 'w')
    file_object.write(licenses[key])
    excluded_licenses.append(licenses[key])

if path.exists('duplicate-finding'):
  rmtree('duplicate-finding')
Path('duplicate-finding').mkdir(parents=True, exist_ok=True)
number = 0
# are there going to be any None values at this point anyway?
text_list = [x for x in list(licenses.values()) if x is not None]
text_list = [license for license in text_list if license not in excluded_licenses]
text_list.sort()
for license_text in text_list:
  if license_text:
    file_object = open('duplicate-finding/' + str(number) + '.txt', 'w')
    file_object.write(license_text)
    number += 1

if path.exists('stage2-licenses'):
  rmtree('stage2-licenses')
Path('stage2-licenses').mkdir(parents=True, exist_ok=True)
for key in licenses:
  if licenses[key]:
    file_object = open('stage2-licenses/' + key + '.txt', 'w')
    file_object.write(licenses[key])