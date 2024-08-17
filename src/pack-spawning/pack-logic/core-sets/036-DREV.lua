local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Duelist Revolution"
    o.setCodePrefix = "DREV-EN"
    o.setNameUrl = "Duelist Revolution"
    o.releaseDate = "2010-08-17"
    o.packTextures = imageHost .. "/textures/packs/coresets/036-DREV.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/036-DREV.png"

    return o
end

return PackGenerator
