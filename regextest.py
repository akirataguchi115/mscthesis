import re

string = "source\ncreative commons"

pattern = r'^(?!.*\b(documentation\s+license|creative\s+commons)\b).*?\b(source|software|program|code|module|public\s+license|ware|\w+ware)\b'

match = re.search(pattern, string, flags=re.IGNORECASE | re.DOTALL)

print(match.group(0) if match else "No match")