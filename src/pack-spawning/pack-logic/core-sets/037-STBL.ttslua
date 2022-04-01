local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Starstrike Blast"
    o.setCodePrefix = "STBL-EN"
    o.setNameUrl = "Starstrike Blast"
    o.releaseDate = "2010-11-16"
    o.packTextures = imageHost .. "/textures/packs/coresets/037-STBL.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/037-STBL.png"

    return o
end

return PackGenerator
