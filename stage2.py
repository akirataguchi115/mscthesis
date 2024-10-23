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
    if spdx_license_key in licenses.keys:
      licenses[spdx_license_key] = json_loader['text']
  except:
    pass

manual_filenames = [f.removesuffix('.txt') for f in listdir('manual-licenses/') if (re.compile('^.*\\.txt').match(f))]

for license_key in manual_filenames:
  with open('manual-licenses/' + license_key + '.txt', 'r') as file_object:
    license_texts.append((license_key, file_object.read()))

for license_key in manual_filenames:
  manually_fetchable_licenses.remove(license_key)

with open ('license-exceptions.json', 'r') as file_object:
  json_loader = json.load(file_object)
  for license_key in json_loader:
    manually_fetchable_licenses.remove(license_key)

with open('fetch_these_licenses_manually.txt', 'w') as file_object:
  file_object.write('\n'.join(manually_fetchable_licenses))

all_licenses = manual_filenames

for license_pair_1 in license_texts:
  for license_pair_2 in license_texts:
    if license_pair_1[0] == license_pair_2[1]:
      continue
    if license_pair_1[1] == [license_pair_2[1]]:
      print(license_pair_1[0] + ' is duplicates with ' + license_pair_2[0])