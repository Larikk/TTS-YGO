local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicE")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Invasion: Vengeance"
    o.setCodePrefix = "INOV-EN"
    o.setNameUrl = "Invasion: Vengeance"
    o.releaseDate = "2016-11-04"
    o.packTextures = imageHost .. "/textures/packs/coresets/061-INOV.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/061-INOV.png"

    return o
end

return PackGenerator
