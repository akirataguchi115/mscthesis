import re, json
from os import listdir, path
from pathlib import Path
from shutil import rmtree
import difflib

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

# Remove already defined duplicates from licenses dict
# this doesnt remove agpl  WHY+1+1+10110111!?!?!
# oh lol it does but writing stage 2 licenses happens so late i cant see it manifest
# need to write temporarily stage 2 licenses out before difflib mess
with open('duplicates.txt') as file:
  duplicates = file.read().splitlines()
for shortcode in duplicates:
  licenses.pop(shortcode, None)
print(licenses.keys())

# Stage 2: Inclusion & Exclusion
if path.exists('excluded-licenses'):
  rmtree('excluded-licenses')
Path('excluded-licenses').mkdir(parents=True, exist_ok=True)
excluded_licenses = []
search_string = r'\b(source|software|program|code|module|public\s+license|ware|\w+ware)\b'
for key in licenses:
  if licenses[key] and re.findall(search_string, licenses[key], re.IGNORECASE):
    pass
  elif licenses[key]:
    file_object = open('excluded-licenses/' + key + '.txt', 'w')
    file_object.write(licenses[key])
    excluded_licenses.append(licenses[key])
for shortcode in excluded_licenses:
  licenses.pop(shortcode, None)

# Stage 3: Removal of duplicates
if path.exists('duplicate-finding'):
  rmtree('duplicate-finding')
Path('duplicate-finding').mkdir(parents=True, exist_ok=True)
# Make a list of tuples: (shortcode, license_text)
licenses_list = list(licenses.items())

# Prepare lowercased texts for comparison
licenses_lower = [text.lower() for _, text in licenses_list]

# Initialize sorting
remaining = list(range(len(licenses_list)))
sorted_indices = []
current = remaining.pop(0)
sorted_indices.append(current)

# Sort by similarity step-by-step
count = 0
while remaining:
    count += 1
    print(count)
    similarities = [
        (i, difflib.SequenceMatcher(None, licenses_lower[current], licenses_lower[i]).ratio())
        for i in remaining
    ]
    next_i, _ = max(similarities, key=lambda x: x[1])
    current = remaining.pop(remaining.index(next_i))
    sorted_indices.append(current)

# Write sorted licenses to files
number = 1
for i in sorted_indices:
    shortcode, license_text = licenses_list[i]
    with open(f'duplicate-finding/{number}-{shortcode}.txt', 'w') as f:
        f.write(license_text)
    number += 1

# Write stage 3 licenses to IO
if path.exists('stage2-licenses'):
  rmtree('stage2-licenses')
Path('stage2-licenses').mkdir(parents=True, exist_ok=True)
for key in licenses:
  if licenses[key]:
    file_object = open('stage2-licenses/' + key + '.txt', 'w')
    file_object.write(licenses[key])
