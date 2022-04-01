local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Crossed Souls"
    o.setCodePrefix = "CROS-EN"
    o.setNameUrl = "Crossed Souls"
    o.releaseDate = "2015-05-15"
    o.packTextures = imageHost .. "/textures/packs/coresets/055-CROS.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/055-CROS.png"

    return o
end

return PackGenerator
