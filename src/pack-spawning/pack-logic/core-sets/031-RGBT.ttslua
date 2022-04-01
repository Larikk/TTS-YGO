local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Raging Battle"
    o.setCodePrefix = "RGBT-EN"
    o.setNameUrl = "Raging Battle"
    o.releaseDate = "2009-05-12"
    o.packTextures = imageHost .. "/textures/packs/coresets/031-RGBT.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/031-RGBT.png"

    return o
end

return PackGenerator
