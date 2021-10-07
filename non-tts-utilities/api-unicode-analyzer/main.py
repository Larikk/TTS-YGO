# analyzes the unicode sequences in the return value of the api

import re

apiData = ""
with open("data.json", "r") as f:
    apiData = f.read()

results = set()

for hit in re.finditer(r"\\u[0-9a-fA-F]+", apiData):
    results.add(hit.group())

results = list(results)
results.sort()

out = ""
for s in results:
    out = out + s + "\n"

print(out)
print("done")

