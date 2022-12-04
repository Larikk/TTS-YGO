local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicG")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Power of the Elements"
    o.setCodePrefix = "POTE-EN"
    o.setNameUrl = "Power of the Elements"
    o.releaseDate = "2022-08-05"
    o.packTextures = imageHost .. "/textures/packs/coresets/084-POTE.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/084-POTE.png"

    return o
end

return PackGenerator
