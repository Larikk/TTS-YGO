local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Return of the Duelist"
    o.setCodePrefix = "REDU-EN"
    o.setNameUrl = "Return of the Duelist"
    o.releaseDate = "2012-08-28"
    o.packTextures = imageHost .. "/textures/packs/coresets/044-REDU.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/044-REDU.png"

    return o
end

return PackGenerator
