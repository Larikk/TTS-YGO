local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicA")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Spell Ruler"
    o.setCodePrefix = "SRL-EN"
    o.setNameUrl = "Spell Ruler"
    o.releaseDate = "2002-09-16"
    o.packTextures = imageHost .. "/textures/packs/coresets/003-SRL.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/003-SRL.png"

    return o
end

return PackGenerator
