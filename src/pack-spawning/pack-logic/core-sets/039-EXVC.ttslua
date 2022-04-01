local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Extreme Victory"
    o.setCodePrefix = "EXVC-EN"
    o.setNameUrl = "Extreme Victory"
    o.releaseDate = "2011-05-10"
    o.packTextures = imageHost .. "/textures/packs/coresets/039-EXVC.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/039-EXVC.png"

    return o
end

return PackGenerator
