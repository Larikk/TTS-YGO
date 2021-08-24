import json

def printBooster(booster):
    print(json.dumps(booster, indent=4))

def asTtsLuaFile(booster, folder, parentLogic):
    box = booster['box-texture']
    if box != "nil": box = '"' + box + '"'

    return f"""\
local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/{folder}/{parentLogic}")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "{booster['name']}"
    o.setCodePrefix = "{booster['code-long']}"
    o.setNameUrl = "{booster['name-url']}"
    o.releaseDate = "{booster['release-date']}"
    o.packTextures = "{booster['pack-texture']}"
    o.boxTexture = {box}

    return o
end

return PackGenerator
"""