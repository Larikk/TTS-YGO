local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicE")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Extreme Force"
    o.setCodePrefix = "EXFO-EN"
    o.setNameUrl = "Extreme Force"
    o.releaseDate = "2018-02-02"
    o.packTextures = imageHost .. "/textures/packs/coresets/066-EXFO.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/066-EXFO.png"

    return o
end

return PackGenerator
