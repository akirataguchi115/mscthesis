import yaml
import re
from os import listdir

with open('stage1') as file:
  stage_1_identifiers = file.read().splitlines()


license_ymls = [f for f in listdir('scancode-licensedb/docs/') if (re.compile('^.*\.yml').match(f))]

scancode_keys = [f for yaml.safe_load(f)['spdx_license_key'] in license_ymls]


with open ('scancode-licensedb/docs/' + license_ymls[0], 'r') as file:
  license_service = yaml.safe_load(file)

print(stage_1_identifiers[0])

print(license_service['spdx_license_key'])

counter = 0
for study_identifier in stage_1_identifiers:
