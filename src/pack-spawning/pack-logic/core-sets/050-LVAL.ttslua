local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Legacy of the Valiant"
    o.setCodePrefix = "LVAL-EN"
    o.setNameUrl = "Legacy of the Valiant"
    o.releaseDate = "2014-01-24"
    o.packTextures = imageHost .. "/textures/packs/coresets/050-LVAL.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/050-LVAL.png"

    return o
end

return PackGenerator
