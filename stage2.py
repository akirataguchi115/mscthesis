import re, json
from os import listdir

with open('stage1') as file:
  stage_1_identifiers = file.read().splitlines()

json_file_names = [f for f in listdir('scancode-licensedb/docs/') if (re.compile('^.*\\.json').match(f))]

json_file_names.remove('index.json')
json_file_names.sort()

def get_spdx_license_key(json_file_name):
  with open ('scancode-licensedb/docs/' + json_file_name, 'r') as file:
    json_loader = json.load(file)
    spdx_license_key = ''
    try:
      spdx_license_key = json_loader['spdx_license_key']
    except:
      print('doesnt have spdx: ' + json_loader['key'])
  return spdx_license_key

scancode_keys = list(map(lambda json_file_name: get_spdx_license_key(json_file_name),json_file_names))

counter = 0
for identifier in stage_1_identifiers:
  for key in scancode_keys:
    if identifier == key:
      counter += 1

print(counter)

# fetch full license texts to licenses/
# manually fetch licenses to manual-licenses/
# remove and document duplicates
# create a dockerfile for testing purposes