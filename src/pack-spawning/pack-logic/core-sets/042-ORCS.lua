local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Order of Chaos"
    o.setCodePrefix = "ORCS-EN"
    o.setNameUrl = "Order of Chaos"
    o.releaseDate = "2012-01-24"
    o.packTextures = imageHost .. "/textures/packs/coresets/042-ORCS.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/042-ORCS.png"

    return o
end

return PackGenerator
