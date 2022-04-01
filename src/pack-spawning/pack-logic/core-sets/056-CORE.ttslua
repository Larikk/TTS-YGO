local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Clash of Rebellions"
    o.setCodePrefix = "CORE-EN"
    o.setNameUrl = "Clash of Rebellions"
    o.releaseDate = "2015-08-07"
    o.packTextures = imageHost .. "/textures/packs/coresets/056-CORE.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/056-CORE.png"

    return o
end

return PackGenerator
