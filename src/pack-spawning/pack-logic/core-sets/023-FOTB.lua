local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicC")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Force of the Breaker"
    o.setCodePrefix = "FOTB-EN"
    o.setNameUrl = "Force of the Breaker"
    o.releaseDate = "2007-05-16"
    o.packTextures = imageHost .. "/textures/packs/coresets/023-FOTB.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/023-FOTB.png"

    return o
end

return PackGenerator
