local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicG")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Burst of Destiny"
    o.setCodePrefix = "BODE-EN"
    o.setNameUrl = "Burst of Destiny"
    o.releaseDate = "2021-11-05"
    o.packTextures = imageHost .. "/textures/packs/coresets/081-BODE.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/081-BODE.png"

    return o
end

return PackGenerator
