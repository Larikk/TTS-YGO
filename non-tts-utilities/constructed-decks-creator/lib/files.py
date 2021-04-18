import os
import re
import inspect

def write(folder, name, content):
    if folder[-1] != "/": folder += "/"
    path = folder + name
    with open(path, "w") as f: f.write(content)

def compileDeckList(folder, prefix):
    files = os.listdir(folder)
    files = filter(lambda f: re.match(r"^[0-9]{3}-.+\.ttslua$", f), files)
    files = map(lambda f: f.split(".")[0], files)
    files = map(lambda f: f'require("TTS-YGO/{prefix}/{f}"),', files)

    sep = "\n    "
    content = f"""\
-- autogenerated
return {{
    {sep.join(files)}
}}
"""
    write(folder, "_all.ttslua", content)
