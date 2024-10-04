import re, json
from os import listdir, path
from pathlib import Path
from shutil import rmtree

if path.exists('licensedb-licenses'):
  rmtree('licensedb-licenses')
Path('licensedb-licenses').mkdir(parents=True, exist_ok=True)

with open('stage1.txt') as file:
  stage_1_identifiers = file.read().splitlines()

json_filenames = [f for f in listdir('scancode-licensedb/docs/') if (re.compile('^.*\\.json').match(f))]
json_filenames.remove('index.json')

manually_fetchable_licenses = stage_1_identifiers

for json_file_name in json_filenames:
  with open ('scancode-licensedb/docs/' + json_file_name, 'r') as file:
    json_loader = json.load(file)
    try:
      spdx_license_key = json_loader['spdx_license_key']
      if spdx_license_key in stage_1_identifiers:
        file_object = open('licensedb-licenses/' + json_loader['key'] + '.txt', 'w')
        file_object.write(json_loader['text'])
        manually_fetchable_licenses.remove(spdx_license_key)
    except:
      print('doesnt have spdx: ' + json_loader['key'])

manual_filenames = [f.removesuffix('.txt') for f in listdir('manual-licenses/') if (re.compile('^.*\\.txt').match(f))]

for license_key in manual_filenames: manually_fetchable_licenses.remove(license_key)

with open('fetch_these_licenses_manually.txt', 'w') as file_object:
  file_object.write('\n'.join(manually_fetchable_licenses))

# fetch full license texts to licensedb-licenses/
# manually fetch licenses to manual-licenses/
# remove and document duplicates
# document ccby4 scancode in thesis