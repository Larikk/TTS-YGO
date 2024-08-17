local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Shadow Specters"
    o.setCodePrefix = "SHSP-EN"
    o.setNameUrl = "Shadow Specters"
    o.releaseDate = "2013-11-08"
    o.packTextures = imageHost .. "/textures/packs/coresets/049-SHSP.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/049-SHSP.png"

    return o
end

return PackGenerator
