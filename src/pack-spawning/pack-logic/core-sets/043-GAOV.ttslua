local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicD")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Galactic Overlord"
    o.setCodePrefix = "GAOV-EN"
    o.setNameUrl = "Galactic Overlord"
    o.releaseDate = "2012-05-08"
    o.packTextures = imageHost .. "/textures/packs/coresets/043-GAOV.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/043-GAOV.png"

    return o
end

return PackGenerator
