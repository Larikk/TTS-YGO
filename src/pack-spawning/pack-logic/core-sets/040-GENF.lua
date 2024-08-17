local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Generation Force"
    o.setCodePrefix = "GENF-EN"
    o.setNameUrl = "Generation Force"
    o.releaseDate = "2011-08-16"
    o.packTextures = imageHost .. "/textures/packs/coresets/040-GENF.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/040-GENF.png"

    return o
end

return PackGenerator
