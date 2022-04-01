local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Dimension of Chaos"
    o.setCodePrefix = "DOCS-EN"
    o.setNameUrl = "Dimension of Chaos"
    o.releaseDate = "2015-11-06"
    o.packTextures = imageHost .. "/textures/packs/coresets/057-DOCS.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/057-DOCS.png"

    return o
end

return PackGenerator
