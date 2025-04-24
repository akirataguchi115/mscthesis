import re, json
from os import listdir, path
from pathlib import Path
from shutil import rmtree

# Stage 2
with open('stage1.txt') as file:
  licenses = dict.fromkeys(file.read().splitlines())

# Fetch license text from scancode based on shortcode
scancode_jsons = [json.load(open('./scancode-licensedb/docs/' + f ,'r')) for f in listdir('scancode-licensedb/docs/') if (re.compile('^(?!index\\.json$).+\\.json$').match(f))]
for json_loader in scancode_jsons:
  try:
    spdx_license_key = json_loader['spdx_license_key']
    if spdx_license_key in licenses.keys():
      licenses[spdx_license_key] = json_loader['text']
  except:
    pass

# Append missing licenses manually
manual_txts = [f.removesuffix('.txt') for f in listdir('manual-licenses/') if (re.compile('^.*\\.txt').match(f))]
for filename in manual_txts:
  with open('manual-licenses/' + filename + '.txt', 'r') as file_object:
    licenses[filename] = file_object.read()

# Print out licenses that need to be added manually
manual_licenses = []
for key, value in licenses.items():
  if value == None:
    manual_licenses.append(key)
print('Fetch these ' + str(len(manual_licenses)) + ' licenses manually')
print(str(manual_licenses) + '\n')


# Remove empty full license text pairs from licenses dict
empty_licenses = {k: v for k, v in licenses.items() if v == ' '}
print('These ' + str(len(empty_licenses)) + ' license texts were empty')
print(empty_licenses.keys())
licenses = {k: v for k, v in licenses.items() if v != ' '}

# Find duplicates for researcher
if path.exists('duplicate-finding'):
  rmtree('duplicate-finding')
Path('duplicate-finding').mkdir(parents=True, exist_ok=True)
number = 1
licenses_in_tuples = sorted(list(licenses.items()), key=lambda x:x[1])
for tuple in licenses_in_tuples:
  # put shortcode name here as well as the number but number first
  file_object = open('duplicate-finding/' + str(number) + '-' + tuple[0] + '.txt', 'w')
  file_object.write(tuple[1])
  number += 1


if path.exists('stage2-licenses'):
  rmtree('stage2-licenses')
Path('stage2-licenses').mkdir(parents=True, exist_ok=True)
for key in licenses:
  if licenses[key]:
    file_object = open('stage2-licenses/' + key + '.txt', 'w')
    file_object.write(licenses[key])

# Stage 3: Inclusion & Exclusion
# if path.exists('excluded-licenses'):
#   rmtree('excluded-licenses')
# Path('excluded-licenses').mkdir(parents=True, exist_ok=True)
# why can't i find arphic licenses anymore from the included licenses after inserting arhpic to manual licenses?
# # create a dictionary inversed sort by keys and return n-1 and n+1 licenses from the each of the manually added licenses
# excluded_licenses = []
# search_string = r'\b(source|software|program|code|module|public\s+license|ware|\w+ware)\b'
# for key in licenses:
#   if licenses[key] and re.findall(search_string, licenses[key], re.IGNORECASE):
#     pass
#   elif licenses[key]:
#     file_object = open('excluded-licenses/' + key + '.txt', 'w')
#     file_object.write(licenses[key])
#     excluded_licenses.append(licenses[key])