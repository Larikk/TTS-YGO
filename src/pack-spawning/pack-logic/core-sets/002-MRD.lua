local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicA")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Metal Raiders"
    o.setCodePrefix = "MRD-EN"
    o.setNameUrl = "Metal Raiders"
    o.releaseDate = "2002-06-26"
    o.packTextures = imageHost .. "/textures/packs/coresets/002-MRD.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/002-MRD.png"

    return o
end

return PackGenerator
