local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Duelist Alliance"
    o.setCodePrefix = "DUEA-EN"
    o.setNameUrl = "Duelist Alliance"
    o.releaseDate = "2014-08-15"
    o.packTextures = imageHost .. "/textures/packs/coresets/052-DUEA.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/052-DUEA.png"

    return o
end

return PackGenerator
