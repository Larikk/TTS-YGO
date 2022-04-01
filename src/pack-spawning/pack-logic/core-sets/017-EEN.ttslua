local ParentGenerator = require("TTS-YGO/src/pack-spawning/pack-logic/core-sets/_CoreSetLogicB")
local imageHost = require("TTS-YGO/src/common/ImageHost")

local PackGenerator = ParentGenerator:new()

function PackGenerator:new()
    local o = ParentGenerator:new()
    setmetatable(o, self)
    self.__index = self

    o.setName = "Elemental Energy"
    o.setCodePrefix = "EEN-EN"
    o.setNameUrl = "Elemental Energy"
    o.releaseDate = "2005-11-16"
    o.packTextures = imageHost .. "/textures/packs/coresets/017-EEN.jpg"
    o.boxTexture = imageHost .. "/textures/boxes/coresets/017-EEN.png"

    return o
end

return PackGenerator
