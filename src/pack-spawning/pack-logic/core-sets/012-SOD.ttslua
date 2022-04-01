local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicB")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Soul of the Duelist"
    o.setCodePrefix = "SOD-EN"
    o.setNameUrl = "Soul of the Duelist"
    o.releaseDate = "2004-10-01"
    o.packTextures = imageHost .. "/textures/packs/coresets/012-SOD.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/012-SOD.png"

    return o
end

return PackGenerator
