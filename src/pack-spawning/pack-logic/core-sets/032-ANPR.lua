local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Ancient Prophecy"
    o.setCodePrefix = "ANPR-EN"
    o.setNameUrl = "Ancient Prophecy"
    o.releaseDate = "2009-09-01"
    o.packTextures = imageHost .. "/textures/packs/coresets/032-ANPR.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/032-ANPR.png"

    return o
end

return PackGenerator
