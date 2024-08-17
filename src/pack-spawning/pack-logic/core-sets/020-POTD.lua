local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicB")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Power of the Duelist"
    o.setCodePrefix = "POTD-EN"
    o.setNameUrl = "Power of the Duelist"
    o.releaseDate = "2006-08-16"
    o.packTextures = imageHost .. "/textures/packs/coresets/020-POTD.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/020-POTD.png"

    return o
end

return PackGenerator
