local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicB")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Rise of Destiny"
    o.setCodePrefix = "RDS-EN"
    o.setNameUrl = "Rise of Destiny"
    o.releaseDate = "2004-12-01"
    o.packTextures = imageHost .. "/textures/packs/coresets/013-RDS.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/013-RDS.png"

    return o
end

return PackGenerator
