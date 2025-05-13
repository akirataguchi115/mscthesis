import re, json
from os import listdir, path
import os
from pathlib import Path
from shutil import rmtree
import difflib
import time
from sys import exit

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
for shortcode, value in licenses.items():
  if value == None:
    manual_licenses.append(shortcode)
print('Fetch these ' + str(len(manual_licenses)) + ' licenses manually')
print(str(manual_licenses) + '\n')

# Remove empty full license text pairs from licenses dict
empty_licenses = {k: v for k, v in licenses.items() if v == ' '}
print('These ' + str(len(empty_licenses)) + ' license texts were empty')
print(empty_licenses.keys())
licenses = {k: v for k, v in licenses.items() if v != ' '}

# Remove already defined duplicates from licenses dict
with open('duplicates.txt') as file:
  duplicates = file.read().splitlines()
for shortcode in duplicates:
  print(shortcode)
  # pause execution if duplicate removal fails (expensive, O(n^3))
  if not shortcode in licenses:
    print(licenses.keys())
    print(shortcode)
    pause = input('holdup pause this should not happen')
  licenses.pop(shortcode, None)

# Stage 2: Inclusion & Exclusion
if path.exists('excluded-licenses'):
  rmtree('excluded-licenses')
Path('excluded-licenses').mkdir(parents=True, exist_ok=True)
excluded_licenses = []
search_string = r'^(?!.*\b(documentation\s+license|creative\s+commons|open data)\b).*'
# Remove manually included from the excluded licenses
with open('inclusions.txt') as file:
  inclusions = file.read().splitlines()
# Remove manually excluded licenses
with open ('exclusions.txt') as file:
  exclusions = file.read().splitlines()
  for shortcode in exclusions:
    file_object = open('excluded-licenses/' + shortcode + '.txt', 'w')
    file_object.write(licenses[shortcode])
    licenses.pop(shortcode, None)

for shortcode in licenses:
  if (licenses[shortcode] and re.search(search_string, licenses[shortcode], flags=re.IGNORECASE | re.DOTALL)) or shortcode in inclusions:
    pass
  elif licenses[shortcode]:
    file_object = open('excluded-licenses/' + shortcode + '.txt', 'w')
    file_object.write(licenses[shortcode])
    excluded_licenses.append(shortcode)
for shortcode in excluded_licenses:
  licenses.pop(shortcode, None)

# Write stage 2 inclusion, exclusion of texts and shortcodes to IO
if path.exists('stage2-licenses'):
  rmtree('stage2-licenses')
Path('stage2-licenses').mkdir(parents=True, exist_ok=True)
for shortcode in licenses:
  if licenses[shortcode]:
    file_object = open('stage2-licenses/' + shortcode + '.txt', 'w')
    file_object.write(licenses[shortcode])
if path.exists('stage2-licenses.txt'):
  os.remove('stage2-licenses.txt')
file_object = open('stage2-licenses.txt', 'w')
for shortcode in licenses.keys():
  file_object.write(shortcode + '\n')

# Write stage 3 license texts and shortcodes to IO
if path.exists('stage3-licenses'):
  rmtree('stage3-licenses')
Path('stage3-licenses').mkdir(parents=True, exist_ok=True)
for shortcode in licenses:
  if licenses[shortcode]:
    file_object = open('stage3-licenses/' + shortcode + '.txt', 'w')
    file_object.write(licenses[shortcode])
if path.exists('stage3-licenses.txt'):
  os.remove('stage3-licenses.txt')
file_object = open('stage3-licenses.txt', 'w')
for shortcode in licenses.keys():
  file_object.write(shortcode + '\n')

# Stage 3: Removal of duplicates
deadass = input('Are you sure you want to start duplicate finding? (y/n)')
if deadass == 'n':
  exit(0)
start_time = time.time()
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

# Sort by similarity
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
print("--- %s seconds ---" % (time.time() - start_time))
