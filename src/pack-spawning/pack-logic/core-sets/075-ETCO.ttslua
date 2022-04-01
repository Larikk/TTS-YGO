local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicG")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Eternity Code"
    o.setCodePrefix = "ETCO-EN"
    o.setNameUrl = "Eternity Code"
    o.releaseDate = "2020-06-05"
    o.packTextures = imageHost .. "/textures/packs/coresets/075-ETCO.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/075-ETCO.png"

    return o
end

return PackGenerator
