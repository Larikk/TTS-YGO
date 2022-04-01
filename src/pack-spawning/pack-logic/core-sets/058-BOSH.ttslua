local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicE")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Breakers of Shadow"
    o.setCodePrefix = "BOSH-EN"
    o.setNameUrl = "Breakers of Shadow"
    o.releaseDate = "2016-01-15"
    o.packTextures = imageHost .. "/textures/packs/coresets/058-BOSH.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/058-BOSH.png"

    return o
end

return PackGenerator
