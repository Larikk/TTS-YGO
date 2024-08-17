local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Gladiator's Assault"
    o.setCodePrefix = "GLAS-EN"
    o.setNameUrl = "Gladiator's Assault"
    o.releaseDate = "2007-11-14"
    o.packTextures = imageHost .. "/textures/packs/coresets/025-GLAS.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/025-GLAS.png"

    return o
end

return PackGenerator
